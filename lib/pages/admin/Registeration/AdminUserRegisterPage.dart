import 'dart:io';

import 'package:flutter/material.dart';
import 'package:refah/models/UserMicroVM.dart';
import 'package:refah/pages/admin/AdminDoctorsPage.dart';
import 'package:refah/pages/admin/AdminUsersPage.dart';
import 'package:refah/services/UserService.dart';
import 'package:refah/widgets/WDG_BorderedMultilineTextInput.dart';
import 'package:refah/widgets/WDG_BorderedTextInput.dart';
import 'package:refah/widgets/WDG_FooterConfirmCancel.dart';
import 'package:refah/widgets/WDG_PersianDateTimeInput.dart';
import 'package:refah/widgets/WDG_QuestionItem.dart';
import 'package:refah/widgets/WDG_SizedBorderedTextInput.dart';
import 'package:refah/widgets/WDG_UploadBorderedInput.dart';

import '../AdminPanelPage.dart';

class AdminUserRegisteryPage extends StatefulWidget {
  UserMicroVM obj = UserMicroVM();
  String password = "";
  String title;
  String description;

  Widget content;

  AdminUserRegisteryPage({
    this.description,
    this.title,
  });

  @override
  _AdminUserRegisteryPageState createState() => _AdminUserRegisteryPageState();
}

class _AdminUserRegisteryPageState extends State<AdminUserRegisteryPage> {
  int isValid = 0;
  bool vis = false;
  List<WDG_QuestionItem> questionItems = List<WDG_QuestionItem>();

  Future<bool> backPress() async {
    await sleep(
      Duration(milliseconds: 10),
    );

    Navigator.pop(context);
    // Navigator.push(
    //   (context),
    //   MaterialPageRoute(
    //     builder: (context) => AdminUsersPage(),
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
                    top: 50.0,
                    left: 10.0,
                    right: 10.0,
                    bottom: 0.0,
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
                      WDG_SizedBorderedTextInput(
                        isRequired: true,
                        onErrorCallback: (error) {
                          isValid = error;
                        },
                        max: 11,
                        value: widget.obj.phoneNumber ?? "",
                        hintText: "شماره موبایل",
                        inputType: TextInputType.phone,
                        onChangeCallback: (result) {
                          widget.obj.phoneNumber = result;
                          widget.obj.email = result + "@refah.ir";
                          widget.obj.userName = result;
                        },
                      ),
                      Row(
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
                            child: WDG_BorderedTextInput(
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
                          ),
                        ],
                      ),
                      Row(
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
                          // Expanded(
                          //   child: WDG_BorderedTextInput(
                          //     isRequired: true,
                          //     onErrorCallback: (error) {
                          //       isValid = error;
                          //     },
                          //     value: widget.obj.birthday ?? "",
                          //     hintText: "تاریخ تولد",
                          //     inputType: TextInputType.datetime,
                          //     onChangeCallback: (result) {
                          //       widget.obj.birthday = result;
                          //     },
                          //   ),
                          // ),
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
                      WDG_SizedBorderedTextInput(
                        //isRequired: true,
                        onErrorCallback: (error) {
                          isValid = error;
                        },
                        value: widget.obj.homePhone ?? "",
                        max: 11,
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
                      WDG_UploadBorderedInput(
                        //isRequired: true,
                        onErrorCallback: (error) {
                          isValid = error;
                        },
                        fileName: "عکس پرسنلی",
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
                WDG_FooterConfirmCancel(
                  confirmTitle: "ثبت نام",
                  //confirmRoute: AdminDoctorsPage(),
                  confirmCallback: (result) async {
                    setState(() {
                      vis = true;
                    });
                    if (isValid > 0) return;
                    widget.obj.status = "user";
                    var res = await UserService()
                        .add(widget.obj, UserService().getRandomString(10));
                    if (res) {
                      Navigator.pop(context);
                    }
                    setState(() {
                      vis = false;
                    });
                  },
                  cancelRoute: AdminDoctorsPage(),
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
