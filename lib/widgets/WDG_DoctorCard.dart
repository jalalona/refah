import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:refah/api/ProfileService.dart';
import 'package:refah/models/UserVM.dart';
import 'package:refah/pages/clients/ClientDoctorDetails.dart';

class WDG_DoctorCard extends StatefulWidget {
  UserVM obj;
  WDG_DoctorCard({
    this.obj,
    Key key,
  }) : super(key: key);

  @override
  _WDG_DoctorCardState createState() => _WDG_DoctorCardState();
}

class _WDG_DoctorCardState extends State<WDG_DoctorCard> {
  String starNo;
  bool vis = false;
  bool opened = false;
  double rating = 3.0;
  String replyComment = "";
  UserVM prf = ProfileService().getUserData();

  var f = NumberFormat("###.#", "fa_IR");

  Widget replyRate = Text("");

  Image avatar;

  // void _showDialog(BuildContext context, UserVM user) {
  //   slideDialog.showSlideDialog(
  //     context: context,
  //     child: ,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(0.0, 25.0),
            child: Container(
              //width: MediaQuery.of(context).size.width / 3 + 7.5,
              height: 120.0,
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: const Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(0, 9),
                    blurRadius: 28,
                  ),
                ],
              ),
              child: Container(
                margin: EdgeInsets.only(
                  left: 2.0,
                  right: 2.0,
                  bottom: 2.0,
                  top: 30.0,
                ),
                width: MediaQuery.of(context).size.width / 3,
                child: Column(
                  children: <Widget>[
                    Text(
                      widget.obj?.fullname ?? 'نام دکتر',
                      style: TextStyle(
                        fontFamily: 'IRANSans',
                        fontSize: 10,
                        color: const Color(0xff313450),
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Expanded(
                      child: Text(
                        widget.obj.bio ?? 'شرح مربوط به خدمات',
                        style: TextStyle(
                          fontFamily: 'IRANSans',
                          fontSize: 9,
                          color: const Color(0xff898a8f),
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(
                      height: 2.5,
                    ),
                    Row(
                      children: <Widget>[
                        SvgPicture.string(
                          _svg_g9sv4h,
                          allowDrawingOutsideViewBox: true,
                        ),
                        Text(
                          widget.obj?.comments != null &&
                                  widget.obj?.comments?.length > 0
                              ? f
                                  .format(widget.obj?.comments
                                          ?.map((e) => e.rate)
                                          ?.reduce((a, b) => a + b) /
                                      widget.obj?.comments.length)
                                  ?.toString()
                              : "0.0",
                          style: TextStyle(
                            fontFamily: 'IRANSans',
                            fontSize: 10,
                            color: const Color(0xff898a8f),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(
                (MediaQuery.of(context).size.width / 3 + 0.0) / 3.5, 0.0),
            child:
                // Adobe XD layer: '44' (shape)
                Container(
              width: 58.0,
              height: 58.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(29.1, 29.1)),
                image: DecorationImage(
                  image: widget.obj?.avatar != null &&
                          widget.obj?.avatar.isNotEmpty
                      ? NetworkImage(
                          "https://api.refahandishanco.ir" + widget.obj.avatar)
                      : AssetImage('images/female_avatar.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClientDoctorDetails(
              user: widget.obj,
            ),
          ),
        );
      },
    );
  }
}

const String _svg_g9sv4h =
    '<svg viewBox="11.6 131.7 14.1 13.4" ><path transform="translate(11.56, 130.37)" d="M 7.056396484375 1.317999958992004 L 9.236664772033691 5.736172676086426 L 14.1125316619873 6.444850921630859 L 10.5843334197998 9.883712768554688 L 11.41719436645508 14.73992919921875 L 7.056396484375 12.44726943969727 L 2.695336818695068 14.73992919921875 L 3.5281982421875 9.883712768554688 L 0 6.444850921630859 L 4.875866889953613 5.736172676086426 L 7.056396484375 1.317999958992004 Z" fill="#efce4a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
