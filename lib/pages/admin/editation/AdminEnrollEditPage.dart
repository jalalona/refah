import 'dart:io';

import 'package:flutter/material.dart';
import 'package:refah/models/EnrollVM.dart';
import 'package:refah/pages/admin/AdminEnrollsPage.dart';
import 'package:refah/services/EnrollService.dart';
import 'package:refah/widgets/WDG_BorderedTextInput.dart';
import 'package:refah/widgets/WDG_DateTimeInput.dart';
import 'package:refah/widgets/WDG_FooterConfirmCancel.dart';
import 'package:refah/widgets/WDG_PersianDateTimeInput.dart';
import 'package:refah/widgets/WDG_SizedBorderedTextInput.dart';

import '../AdminPanelPage.dart';

class AdminEnrollEditPage extends StatefulWidget {
  EnrollVM obj = EnrollVM();
  String password = "";
  String title;
  String description;

  Widget content;

  AdminEnrollEditPage({
    this.obj,
    this.description,
    this.title,
  });

  @override
  _AdminEnrollEditPageState createState() => _AdminEnrollEditPageState();
}

class _AdminEnrollEditPageState extends State<AdminEnrollEditPage> {
  int isValid = 0;
  bool vis = false;

  Future<bool> backPress() async {
    await sleep(
      Duration(milliseconds: 10),
    );

    Navigator.pop(context);
    // Navigator.push(
    //   (context),
    //   MaterialPageRoute(
    //     builder: (context) => AdminEnrollsPage(),
    //   ),
    // );

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
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                    top: 20.0,
                    left: 10.0,
                    right: 10.0,
                    bottom: 20.0,
                  ),
                  padding: EdgeInsets.all(10.0),
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        WDG_BorderedTextInput(
                          isRequired: true,
                          onErrorCallback: (error) {
                            isValid = error;
                          },
                          value: widget.obj.fullname ?? "",
                          hintText: "نام و نام خانوادگی",
                          onChangeCallback: (result) {
                            widget.obj.fullname = result;
                          },
                        ),
                        WDG_BorderedTextInput(
                          isRequired: true,
                          onErrorCallback: (error) {
                            isValid = error;
                          },
                          value: widget.obj.identityNumber ?? "",
                          hintText: "شماره شناسنامه",
                          inputType: TextInputType.number,
                          onChangeCallback: (result) {
                            widget.obj.identityNumber = result;
                          },
                        ),
                        Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: WDG_SizedBorderedTextInput(
                                  isRequired: true,
                                  onErrorCallback: (error) {
                                    isValid = error;
                                  },
                                  value: widget.obj.nationalId ?? "",
                                  max: 10,
                                  hintText: "کد ملی",
                                  inputType: TextInputType.number,
                                  onChangeCallback: (result) {
                                    widget.obj.nationalId = result;
                                  },
                                ),
                              ),
                              Expanded(
                                child: WDG_SizedBorderedTextInput(
                                  isRequired: true,
                                  onErrorCallback: (error) {
                                    isValid = error;
                                  },
                                  max: 11,
                                  value: widget.obj.systemTag ?? "",
                                  hintText: "شماره موبایل",
                                  inputType: TextInputType.phone,
                                  onChangeCallback: (result) {
                                    widget.obj.systemTag = result;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: WDG_PersianDateTimeInput(
                                  hint: "",
                                  birthday: true,
                                  value: widget.obj.birthday ?? "",
                                  onChangeCallback: (result) {
                                    widget.obj.birthday = result.toString();
                                  },
                                ),
                              ),
                              Expanded(
                                child: WDG_BorderedTextInput(
                                  //isRequired: true,
                                  onErrorCallback: (error) {
                                    isValid = error;
                                  },
                                  value: widget.obj.fatherName ?? "",
                                  hintText: "نام پدر",
                                  inputType: TextInputType.text,
                                  onChangeCallback: (result) {
                                    widget.obj.fatherName = result;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        WDG_SizedBorderedTextInput(
                          //isRequired: true,
                          onErrorCallback: (error) {
                            isValid = error;
                          },
                          max: 11,
                          value: widget.obj.homePhone ?? "",
                          hintText: "شماره تلفن منزل",
                          inputType: TextInputType.phone,
                          onChangeCallback: (result) {
                            widget.obj.homePhone = result;
                          },
                        ),
                        WDG_BorderedTextInput(
                          //isRequired: true,
                          onErrorCallback: (error) {
                            isValid = error;
                          },
                          value: widget.obj.address ?? "",
                          hintText: "آدرس",
                          onChangeCallback: (result) {
                            widget.obj.address = result;
                          },
                        ),
                        WDG_DateTimeInput(
                          //hint: "تاریخ شروع",
                          value: widget.obj.startTime,
                          onChangeCallback: (result) {
                            widget.obj.startTime = result;
                          },
                        ),
                        WDG_DateTimeInput(
                          //hint: "تاریخ پایان",
                          value: widget.obj.expireTime,
                          onChangeCallback: (result) {
                            widget.obj.expireTime = result;
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
                      ],
                    ),
                  ),
                ),
                WDG_FooterConfirmCancel(
                  confirmTitle: "بروزرسانی",
                  //confirmRoute: AdminDoctorsPage(),
                  confirmCallback: (result) async {
                    setState(() {
                      vis = true;
                    });
                    if (isValid > 0) return;
                    widget.obj.status = "partner";
                    var res = await EnrollService().update(widget.obj);
                    if (res != null) {
                      Navigator.pop(context);
                    }
                    setState(() {
                      vis = false;
                    });
                  },
                  cancelRoute: AdminEnrollsPage(),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () => backPress(),
      ),
    );
  }
}
