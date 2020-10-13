import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:refah/models/EnrollVM.dart';
import 'package:refah/services/EnrollService.dart';
import 'package:refah/widgets/WDG_BackIconCircle.dart';
import 'package:refah/widgets/WDG_BorderedIconButton.dart';
import 'package:refah/widgets/WDG_SearchInput.dart';
import 'package:url_launcher/url_launcher.dart';

import 'DoctorChoosePage.dart';

class PatientSearchPage extends StatefulWidget {
  String title;
  String description;

  Widget content;

  PatientSearchPage({
    this.description,
    this.title,
  });

  @override
  _PatientSearchPageState createState() => _PatientSearchPageState();
}

class _PatientSearchPageState extends State<PatientSearchPage> {
  bool vis = false;
  EnrollVM info = EnrollVM();
  String credit = "";

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {}
  }

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1fac9c),
      body: WillPopScope(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 30.0,
                      left: 30.0,
                      right: 30.0,
                    ),
                    child: WDG_SearchInput(
                      searchTextChangeCallback: (result) {
                        // method
                      },
                      submitSearchCallback: (result) async {
                        setState(() {
                          info = EnrollVM();
                        });
                        if (result != null) {
                          List<EnrollVM> users = result as List<EnrollVM>;
                          if (users != null && users.length > 0) {
                            info = users
                                .where((element) =>
                                    element.enrollType == "dentist")
                                .last;
                            if (info != null) {
                              await EnrollService()
                                  .getUserActiveEnroll(info.nationalId);
                              setState(() {
                                credit =
                                    EnrollService().calculateUserCredit(info);
                              });

                              if (credit != null && credit.isNotEmpty) {
                                var alert = AlertDialog(
                                  title: Text("اعتبار دارد"),
                                  content: Text(
                                    "بیمار مورد نظر " +
                                        credit +
                                        " روز اعتبار دارد",
                                    style: TextStyle(
                                      fontFamily: "IRANSans",
                                    ),
                                  ),
                                  actions: [
                                    FlatButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "ممنون",
                                        style: TextStyle(
                                          fontFamily: "IRANSans",
                                        ),
                                      ),
                                    ),
                                  ],
                                );

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  },
                                );
                              } else {
                                var alert = AlertDialog(
                                  title: Text("عدم اعتبار"),
                                  content: Text(
                                    "فرد مورد نظر دارای اعتبار نیست",
                                    style: TextStyle(
                                      fontFamily: "IRANSans",
                                    ),
                                  ),
                                  actions: [
                                    FlatButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "ممنون",
                                        style: TextStyle(
                                          fontFamily: "IRANSans",
                                        ),
                                      ),
                                    ),
                                  ],
                                );

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  },
                                );
                              }
                            } else {
                              var alert = AlertDialog(
                                title: Text("عدم اعتبار"),
                                content: Text(
                                  "فرد مورد نظر دارای اعتبار نیست",
                                  style: TextStyle(
                                    fontFamily: "IRANSans",
                                  ),
                                ),
                                actions: [
                                  FlatButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "ممنون",
                                      style: TextStyle(
                                        fontFamily: "IRANSans",
                                      ),
                                    ),
                                  ),
                                ],
                              );

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            }
                          } else {
                            var alert = AlertDialog(
                              title: Text("بیمه شده نیست"),
                              content: Text(
                                "شخص مورد نظر بیمه شده مجموعه نیست",
                                style: TextStyle(
                                  fontFamily: "IRANSans",
                                ),
                              ),
                              actions: [
                                FlatButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "ممنون",
                                    style: TextStyle(
                                      fontFamily: "IRANSans",
                                    ),
                                  ),
                                ),
                              ],
                            );

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          }
                        } else {
                          var alert = AlertDialog(
                            title: Text("پیدا نشد"),
                            content: Text(
                              "جستجو موردی برای شما پیدا نکرد",
                              style: TextStyle(
                                fontFamily: "IRANSans",
                              ),
                            ),
                            actions: [
                              FlatButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "ممنون",
                                  style: TextStyle(
                                    fontFamily: "IRANSans",
                                  ),
                                ),
                              ),
                            ],
                          );

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        Container(
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
                                Container(
                                  width: 85.0,
                                  height: 85.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(42.0, 42.0)),
                                    image: DecorationImage(
                                      image: info.avatar != null &&
                                              info.avatar.isNotEmpty
                                          ? NetworkImage(
                                              "https://api.refahandishanco.ir" +
                                                  info.avatar)
                                          : AssetImage(
                                              'images/female_avatar.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                    border: Border.all(
                                        width: 4.0,
                                        color: const Color(0xffffffff)),
                                  ),
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Container(
                                      child: Text(
                                        'نام و نام خانوادگی : ',
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
                                        info.fullname ?? "",
                                        style: TextStyle(
                                          fontFamily: 'IRANSans',
                                          fontSize: 14,
                                          color: const Color(0xff313450),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Container(
                                      child: Text(
                                        'شماره همراه : ',
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
                                        info.systemTag ?? "",
                                        style: TextStyle(
                                          fontFamily: 'IRANSans',
                                          fontSize: 14,
                                          color: const Color(0xff313450),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Container(
                                      child: Text(
                                        'کد ملی : ',
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
                                        info.nationalId ?? "",
                                        style: TextStyle(
                                          fontFamily: 'IRANSans',
                                          fontSize: 14,
                                          color: const Color(0xff313450),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Container(
                                      child: Text(
                                        'تاریخ تولد : ',
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
                                        info.birthday ?? "",
                                        style: TextStyle(
                                          fontFamily: 'IRANSans',
                                          fontSize: 14,
                                          color: const Color(0xff313450),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    InkWell(
                                      child: WDG_BorderedIconButton(
                                        icon:
                                            SvgPicture.asset("images/call.svg"),
                                        onTapCallback: (result) {
                                          // call method
                                        },
                                      ),
                                      onTap: () {
                                        _launchURL(
                                            "tel:" + info?.systemTag ?? "");
                                      },
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          child: Text(
                                            credit ?? "بدون اعتبار",
                                            style: TextStyle(
                                              fontFamily: "IRANSans",
                                            ),
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "اعتبار : ",
                                            style: TextStyle(
                                              fontFamily: "IRANSans",
                                            ),
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
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
                      ],
                    ),
                  ),
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
