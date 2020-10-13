import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:refah/Provider/SignalR.dart';
import 'package:refah/api/ProfileService.dart';
import 'package:refah/models/ChatMessage.dart';
import 'package:refah/models/UserCommentMicroVM.dart';
import 'package:refah/models/UserVM.dart';
import 'package:refah/services/EnrollService.dart';
import 'package:refah/services/OptionService.dart';
import 'package:refah/services/UserCommentService.dart';
import 'package:refah/widgets/WDG_Input.dart';
import 'package:refah/widgets/WDG_RateIcon.dart';
import 'package:refah/widgets/WDG_ReplyIcon.dart';
import 'package:refah/widgets/WDG_SendCommentIcon.dart';

import 'ClientMessagePage.dart';

class ClientDoctorDetails extends StatefulWidget {
  String title;
  String description;
  UserVM user;

  Widget content;

  ClientDoctorDetails({
    this.user,
    this.description,
    this.title,
  });

  @override
  _ClientDoctorDetailsState createState() => _ClientDoctorDetailsState();
}

class _ClientDoctorDetailsState extends State<ClientDoctorDetails> {
  String starNo;
  bool vis = false;
  bool opened = false;
  double rating = 3.0;
  String replyComment = "";
  UserVM prf = ProfileService().getUserData();
  SignalR signalr;

  var f = NumberFormat("###.#", "fa_IR");

  Widget replyRate = Text("");

  Image avatar;

  Future<bool> backPress() async {
    await sleep(
      Duration(milliseconds: 10),
    );

    Navigator.pop(context);

    return false;
  }

  @override
  void initState() {
    super.initState();
    signalr = SignalR(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1fac9c),
      body: WillPopScope(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(10.0),
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.elliptical(50.0, 50.0),
                          ),
                          image: DecorationImage(
                            image: widget.user?.avatar != null
                                ? NetworkImage(
                                    "https://api.refahandishanco.ir" +
                                        widget.user?.avatar)
                                : AssetImage('images/female_avatar.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      EnrollService().calculateCredit() != null
                          ? Container(
                              margin: EdgeInsets.all(10.0),
                              child: WDG_SendCommentIcon(
                                icon: SvgPicture.asset(
                                  "images/comment.svg",
                                  color: Colors.greenAccent,
                                ),
                                onTapCallback: (result) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ClientMessagePage(
                                        user: widget.user,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Text(""),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: Text(
                      widget.user?.fullname ?? "--",
                      style: TextStyle(fontFamily: "IRANSans", fontSize: 16),
                    ),
                  ),
                  Container(
                    child: WDG_RateIcon(
                      rate: "1.0",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: Text(
                      widget.user?.bio != null && widget.user?.bio.isNotEmpty
                          ? widget.user.bio
                          : "بدون توضیحات",
                      style: TextStyle(
                        fontFamily: "IRANSans",
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: Text(
                      widget.user?.homePhone != null &&
                              widget.user?.homePhone.isNotEmpty
                          ? "شماره تماس : " + widget.user.homePhone
                          : "بدون شماره تماس",
                      style: TextStyle(
                        fontFamily: "IRANSans",
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: Text(
                      widget.user?.address != null &&
                              widget.user?.address.isNotEmpty
                          ? "آدرس : " + widget.user.address
                          : "بدون آدرس",
                      style: TextStyle(
                        fontFamily: "IRANSans",
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  EnrollService().calculateCredit() != null
                      ? Container(
                          margin: EdgeInsets.all(5.0),
                          padding: EdgeInsets.only(
                            right: 5.0,
                            top: 5.0,
                            bottom: 5.0,
                            left: 5.0,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  WDG_Input(
                                    value: replyComment ?? "",
                                    height: 150.0,
                                    hint: "متن کامنت",
                                    onChangeCallback: (result) {
                                      replyComment = result;
                                    },
                                  ),
                                  Visibility(
                                    child: Container(
                                      width: 20.0,
                                      height: 20.0,
                                      child: CircularProgressIndicator(),
                                    ),
                                    maintainSize: false,
                                    maintainAnimation: true,
                                    maintainState: true,
                                    visible: vis,
                                  ),
                                  WDG_ReplyIcon(
                                    onTapCallback: (reult) async {
                                      setState(() {
                                        vis = true;
                                      });
                                      var res = await UserCommentService().add(
                                        UserCommentMicroVM(
                                          rate: rating.toInt(),
                                          userCreatedId:
                                              ProfileService().getUserData().id,
                                          userId: widget.user.id,
                                          description: replyComment,
                                        ),
                                      );

                                      if (res != null) {
                                        replyComment = "";
                                        var admin = await OptionService()
                                            .getByName("aid");
                                        signalr.sendMessage(
                                          admin.value,
                                          res.id,
                                          ChatMessage(
                                            senderName: ProfileService()
                                                .getUserData()
                                                .fullname,
                                            senderAvatar: ProfileService()
                                                .getUserData()
                                                .avatar,
                                            message: res.description,
                                            id: res.id,
                                          ),
                                        );
                                        signalr.sendMessage(
                                          ProfileService()
                                              .getUserData()
                                              .nationalId,
                                          res.id,
                                          ChatMessage(
                                            senderName: ProfileService()
                                                .getUserData()
                                                .fullname,
                                            senderAvatar: ProfileService()
                                                .getUserData()
                                                .avatar,
                                            message: res.description,
                                            id: res.id,
                                          ),
                                        );

                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.SUCCES,
                                          animType: AnimType.BOTTOMSLIDE,
                                          title: 'ثبت نظر',
                                          desc: 'با موفقیت نظر شما ثبت شد',
                                          btnOkText: "ممنون",
                                          //btnCancelText: "گالری",
                                          //btnCancelOnPress: () async {},
                                          btnOkOnPress: () async {},
                                        )..show();

                                        Navigator.pop(context);
                                      }
                                      setState(() {
                                        vis = false;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              RatingBar(
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (_rating) {
                                  rating = _rating;
                                  print(rating);
                                },
                              ),
                            ],
                          ),
                        )
                      : Text(""),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () => backPress(),
      ),
    );
  }
}
