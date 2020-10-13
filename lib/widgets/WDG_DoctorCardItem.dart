import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:refah/Provider/SignalR.dart';
import 'package:refah/api/ProfileService.dart';
import 'package:refah/models/ChatMessage.dart';
import 'package:refah/models/UserCommentMicroVM.dart';
import 'package:refah/models/UserVM.dart';
import 'package:refah/pages/clients/ClientDoctorDetails.dart';
import 'package:refah/pages/clients/ClientMessagePage.dart';
import 'package:refah/services/EnrollService.dart';
import 'package:refah/services/OptionService.dart';
import 'package:refah/services/UserCommentService.dart';
import 'package:refah/widgets/WDG_Input.dart';
import 'package:refah/widgets/WDG_ReplyIcon.dart';
import './WDG_RateIcon.dart';
import './WDG_SendCommentIcon.dart';

class WDG_DoctorCardItem extends StatefulWidget {
  UserVM obj;
  Function(dynamic result) onCommentTapCallback;
  Widget replyRoute;

  WDG_DoctorCardItem({
    this.replyRoute,
    this.obj,
    this.onCommentTapCallback,
    Key key,
  }) : super(key: key);

  @override
  _WDG_DoctorCardItemState createState() => _WDG_DoctorCardItemState();
}

class _WDG_DoctorCardItemState extends State<WDG_DoctorCardItem> {
  bool vis = false;
  bool opened = false;
  double rating = 3.0;
  String replyComment = "";
  UserVM prf = ProfileService().getUserData();

  Widget commentWidget;
  var f = NumberFormat("###.#", "fa_IR");

  Widget replyRate = Text("");

  @override
  void initState() {
    super.initState();

    commentWidget = WDG_Input(
      value: replyComment,
      hint: "متن کامنت",
      onChangeCallback: (result) {
        replyComment = result;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: const Color(0xffffffff),
      ),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 61.0,
                  height: 61.0,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.elliptical(30.5, 30.5)),
                    image: DecorationImage(
                      image: widget.obj?.avatar != null
                          ? NetworkImage("https://api.refahandishanco.ir" +
                              widget.obj?.avatar)
                          : AssetImage('images/female_avatar.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        widget.obj?.fullname ?? 'نام و نام خانوادگی',
                        style: TextStyle(
                          fontFamily: 'IRANSans',
                          fontSize: 14,
                          color: const Color(0xff313450),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(
                              width: 0.5, color: const Color(0xffececec)),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 160.0,
                          child: Text(
                            widget.obj?.bio ??
                                'شرح متن کامنت کاربری برای دکتر مورد نظر ...',
                            style: TextStyle(
                              fontFamily: 'IRANSans',
                              fontSize: 10,
                              color: const Color(0xff898a8f),
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Text(
              widget.obj?.address ?? '',
              style: TextStyle(
                fontFamily: 'IRANSans',
                fontSize: 10,
                color: const Color(0xffff4d4d),
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            padding: EdgeInsets.only(
              right: 15.0,
              top: 5.0,
              bottom: 5.0,
              left: 5.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                EnrollService().calculateCredit() != null
                    ? WDG_SendCommentIcon(
                        onTapCallback: (result) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClientDoctorDetails(
                                user: widget.obj,
                              ),
                            ),
                          );
                        },
                      )
                    : Text(""),
                EnrollService().calculateCredit() != null
                    ? WDG_SendCommentIcon(
                        icon: SvgPicture.asset(
                          "images/comment.svg",
                          color: Colors.greenAccent,
                        ),
                        onTapCallback: (result) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClientMessagePage(
                                user: widget.obj,
                              ),
                            ),
                          );
                        },
                      )
                    : Text(""),
                Container(
                  child: Text(
                    widget.obj?.officeName ?? '',
                    style: TextStyle(
                      fontFamily: 'IRANSans',
                      fontSize: 10,
                      color: const Color(0xff313450),
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                WDG_RateIcon(
                  rate: widget.obj?.comments != null &&
                          widget.obj?.comments?.length > 0
                      ? f
                          .format(widget.obj?.comments
                                  ?.map((e) => e.rate)
                                  ?.reduce((a, b) => a + b) /
                              widget.obj?.comments.length)
                          ?.toString()
                      : "0.0",
                ),
              ],
            ),
          ),
          replyRate,
        ],
      ),
    );
  }
}
