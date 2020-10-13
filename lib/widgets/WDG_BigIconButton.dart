import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:refah/models/EnrollVM.dart';

class WDG_BigIconButton extends StatefulWidget {
  String title;
  String description;
  Widget route;
  Image icon;
  double marginValue;
  Color descriptionColor;
  Function(dynamic result) onTapCallback;

  WDG_BigIconButton({
    this.description = "شرح کار دکمه",
    this.title = "عنوان دکمه",
    this.route,
    this.icon,
    this.marginValue,
    this.descriptionColor,
    this.onTapCallback,
    Key key,
  }) : super(key: key);

  @override
  _WDG_BigIconButtonState createState() => _WDG_BigIconButtonState();
}

class _WDG_BigIconButtonState extends State<WDG_BigIconButton> {
  EnrollVM myLastEnroll;

  Future getMyCredit() async {
    //myLastEnroll = await EnrollService().getMyCredit();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 75.0,
              width: 75.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(37.5, 37.5)),
                color: const Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(0, 11),
                    blurRadius: 35,
                  ),
                ],
              ),
              child: Container(
                margin: EdgeInsets.all(widget.marginValue ?? 15.0),
                child: widget.icon ??
                    Image.asset(
                      "images/stickingplaster.png",
                      width: 25.0,
                      height: 25.0,
                      fit: BoxFit.scaleDown,
                    ),
              ),
            ),
            Container(
              width: 90.0,
              child: Text(
                widget.title ?? "--",
                style: TextStyle(
                  fontFamily: 'IRANSans',
                  fontSize: 14,
                  color: const Color(0xff333348),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              //width: 90.0,
              child: Text(
                widget.description,
                style: TextStyle(
                  fontFamily: 'IRANSans',
                  fontSize: 10,
                  color: widget.descriptionColor ?? Color(0xff898a8f),
                  height: 1.1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        if (widget.onTapCallback != null) {
          widget.onTapCallback("tap");
        }

        if (widget.route != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => widget.route,
            ),
          );
        }
      },
    );
  }
}
