import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:refah/models/EnrollVM.dart';
import 'package:refah/services/EnrollService.dart';
import 'package:refah/services/OptionService.dart';

class WDG_FamilyItem extends StatefulWidget {
  EnrollVM user;
  String title;
  String subTitle;
  Function(String result) deleteCallback;
  Widget deleteRoute;
  String cost;

  WDG_FamilyItem({
    this.user,
    this.deleteCallback,
    this.deleteRoute,
    this.subTitle,
    this.title,
    this.cost,
    Key key,
  }) : super(key: key);

  @override
  _WDG_FamilyItemState createState() => _WDG_FamilyItemState();
}

class _WDG_FamilyItemState extends State<WDG_FamilyItem> {
  Future initCost() async {
    if (widget.cost == null || widget.cost.isEmpty || widget.cost == "0 ریال") {
      var res = await OptionService().getByName("dentist_one_cost");
      var reso = await OptionService().getByName("dentist_family_cost");

      setState(() {
        widget.cost = EnrollService().getMyEnrolls().length > 1
            ? reso?.value
            : res?.value ?? "0";
        widget.cost += " ریال";
      });
    }
  }

  @override
  void initState() {
    super.initState();

    initCost();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
        left: 15.0,
        right: 15.0,
      ),
      child: Row(
        children: <Widget>[
          InkWell(
            child: Container(
              padding: EdgeInsets.all(5.0),
              width: 24.0,
              height: 24.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(12.0, 12.0)),
                border: Border.all(width: 1.0, color: const Color(0xff1fac9c)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x21000000),
                    offset: Offset(0, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: SvgPicture.string(
                _svg_r5rlc4,
                allowDrawingOutsideViewBox: true,
              ),
            ),
            onTap: () async {
              var res = await EnrollService().delete(widget.user);

              if (res != null) {
                EnrollService().deleteFromList(widget.user);
                if (widget.deleteCallback != null) {
                  widget.deleteCallback("tap");
                }
              }
            },
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    widget.user?.fullname ?? 'نام و نام خانوادگی',
                    style: TextStyle(
                      fontFamily: 'IRANSans',
                      fontSize: 14,
                      color: const Color(0xff313450),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    widget.user?.nationalId ?? '',
                    style: TextStyle(
                      fontFamily: 'IRANSans',
                      fontSize: 12,
                      color: const Color(0xff898a8f),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_r5rlc4 =
    '<svg viewBox="292.1 209.4 10.0 1.0" ><path transform="matrix(0.0, 1.0, -1.0, 0.0, 302.06, 209.38)" d="M 0 0 L 0.05255126953125 9.97216796875" fill="none" stroke="#1fac9c" stroke-width="2" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
