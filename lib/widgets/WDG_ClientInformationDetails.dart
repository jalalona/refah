import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:refah/models/UserVM.dart';
import 'package:refah/pages/doctors/DoctorChoosePage.dart';
import 'package:refah/services/EnrollService.dart';
import 'package:refah/widgets/WDG_BackIconCircle.dart';
import 'package:url_launcher/url_launcher.dart';

import 'WDG_BorderedIconButton.dart';

class WDG_ClientInformationDetails extends StatefulWidget {
  List<UserVM> obj = List<UserVM>();

  WDG_ClientInformationDetails({
    this.obj,
    Key key,
  }) : super(key: key);

  @override
  _WDG_ClientInformationDetailsState createState() =>
      _WDG_ClientInformationDetailsState();
}

class _WDG_ClientInformationDetailsState
    extends State<WDG_ClientInformationDetails> {
  String fn = "";
  String av = "";
  String hp = "";
  String ni = "";
  String bd = "";
  String tl = "";
  String wei = "";
  String pn = "";

  initInfo() {
    if (widget.obj != null && widget.obj.length > 0) {
      setState(() {
        var info = widget.obj[0];
        fn = info.fullname;
        av = info.avatar != null && info.avatar.isNotEmpty
            ? "https://api.refahandishanco.ir" + info.avatar
            : "";
        hp = info.homePhone;
        ni = info.nationalId;
        bd = info.birthday;
        tl = info.tall?.toString();
        wei = info.weight?.toString();
        pn = info.phoneNumber;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    initInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Transform.translate(
          offset: Offset(0.0, 20.0),
          child: Container(
            margin: EdgeInsets.only(
              top: 30.0,
              bottom: 30.0,
            ),
            padding: EdgeInsets.only(
              top: 30.0,
              bottom: 60.0,
              left: 10.0,
              right: 10.0,
            ),
            width: MediaQuery.of(context).size.width,
            // height: 508.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: const Color(0xffffffff),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(0, 9),
                  blurRadius: 38,
                ),
              ],
            ),
            child: Container(
              child: Column(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      'نام و نام خانوادگی : ' + fn,
                      style: TextStyle(
                        fontFamily: 'IRANSans',
                        fontSize: 14,
                        color: const Color(0xff313450),
                        fontWeight: FontWeight.w600,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  Container(
                    child: Text(
                      'شماره تماس منزل : ' + hp,
                      style: TextStyle(
                        fontFamily: 'IRANSans',
                        fontSize: 14,
                        color: const Color(0xff313450),
                        fontWeight: FontWeight.w600,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  Container(
                    child: Text(
                      'کد ملی : ' + ni,
                      style: TextStyle(
                        fontFamily: 'IRANSans',
                        fontSize: 14,
                        color: const Color(0xff313450),
                        fontWeight: FontWeight.w600,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  Container(
                    child: Text(
                      'تاریخ تولد : ' + bd,
                      style: TextStyle(
                        fontFamily: 'IRANSans',
                        fontSize: 14,
                        color: const Color(0xff313450),
                        fontWeight: FontWeight.w600,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          child: WDG_BorderedIconButton(
                            icon: SvgPicture.asset("images/call.svg"),
                            onTapCallback: (result) {
                              // call method
                            },
                          ),
                          onTap: () {
                            launch("tel://$pn");
                          },
                        ),
                        Container(
                          child: Text(
                            "اعتبار : " + EnrollService().calculateCredit(),
                            style: TextStyle(
                              fontFamily: "IRANSans",
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    alignment: Alignment.center,
                    child: WDG_BackIconCircle(
                      route: DoctorChoosePage(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Transform.translate(
          offset: Offset((MediaQuery.of(context).size.width - 125) / 2, 30.0),
          child: Container(
            width: 85.0,
            height: 85.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.elliptical(42.0, 42.0)),
              image: DecorationImage(
                image: av != null && av.isNotEmpty
                    ? NetworkImage(av)
                    : AssetImage('images/female_avatar.jpg'),
                fit: BoxFit.cover,
              ),
              border: Border.all(width: 4.0, color: const Color(0xffffffff)),
            ),
          ),
        ),
      ],
    );
  }
}
