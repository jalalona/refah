import 'dart:io';

import 'package:flutter/material.dart';
import 'package:refah/models/UserMicroVM.dart';
import 'package:refah/pages/admin/AdminDoctorsPage.dart';
import 'package:refah/services/UserService.dart';
import 'package:refah/widgets/WDG_BorderedMultilineTextInput.dart';
import 'package:refah/widgets/WDG_BorderedTextInput.dart';
import 'package:refah/widgets/WDG_FooterConfirmCancel.dart';
import 'package:refah/widgets/WDG_QuestionItem.dart';
import 'package:refah/widgets/WDG_SizedBorderedTextInput.dart';

import '../AdminPanelPage.dart';

class AdminDoctorRegisteryPage extends StatefulWidget {
  UserMicroVM obj = UserMicroVM();
  String password = "";
  String title;
  String description;

  Widget content;

  AdminDoctorRegisteryPage({
    this.description,
    this.title,
  });

  @override
  _AdminDoctorRegisteryPageState createState() =>
      _AdminDoctorRegisteryPageState();
}

class _AdminDoctorRegisteryPageState extends State<AdminDoctorRegisteryPage> {
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
    //     builder: (context) => AdminDoctorsPage(),
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
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                      top: 50.0,
                      left: 10.0,
                      right: 10.0,
                      bottom: 10.0,
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
                          value: widget.obj?.fullname ?? "",
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
                          value: widget.obj.officeName ?? "",
                          hintText: "نام مرکز",
                          inputType: TextInputType.text,
                          onChangeCallback: (result) {
                            widget.obj.officeName = result;
                          },
                        ),
                        WDG_SizedBorderedTextInput(
                          isRequired: true,
                          onErrorCallback: (error) {
                            isValid = error;
                          },
                          max: 11,
                          value: widget.obj.homePhone ?? "",
                          hintText: "تلفن مرکز",
                          inputType: TextInputType.number,
                          onChangeCallback: (result) {
                            widget.obj.homePhone = result;
                          },
                        ),
                        WDG_SizedBorderedTextInput(
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
                        WDG_BorderedTextInput(
                          isRequired: true,
                          onErrorCallback: (error) {
                            isValid = error;
                          },
                          value: widget.obj.userName ?? "",
                          hintText: "نام کاربری",
                          inputType: TextInputType.text,
                          onChangeCallback: (result) {
                            widget.obj.userName = result;
                          },
                        ),
                        WDG_BorderedTextInput(
                          isRequired: true,
                          onErrorCallback: (error) {
                            isValid = error;
                          },
                          password: true,
                          value: widget.password,
                          hintText: "رمز عبور",
                          inputType: TextInputType.text,
                          onChangeCallback: (result) {
                            widget.password = result;
                          },
                        ),
                        WDG_SizedBorderedTextInput(
                          isRequired: true,
                          onErrorCallback: (error) {
                            isValid = error;
                          },
                          value: widget.obj.phoneNumber ?? "",
                          max: 11,
                          hintText: "شماره همراه",
                          inputType: TextInputType.phone,
                          onChangeCallback: (result) {
                            widget.obj.phoneNumber = result;
                            widget.password = result;
                            widget.obj.email = result + "@refah.ir";
                          },
                        ),
                        WDG_BorderedTextInput(
                          //isRequired: true,
                          onErrorCallback: (error) {
                            isValid = error;
                          },
                          value: widget.obj.address ?? "",
                          hintText: "آدرس",
                          inputType: TextInputType.text,
                          onChangeCallback: (result) {
                            widget.obj.address = result;
                          },
                        ),
                        WDG_BorderedMultilineTextInput(
                          //isRequired: true,
                          onErrorCallback: (error) {
                            isValid = error;
                          },
                          value: widget.obj.bio ?? "",
                          hintText: "شرح خدمات",
                          minLines: 3,
                          maxLines: 5,
                          expandable: true,
                          height: 100.0,
                          onChangeCallback: (result) {
                            widget.obj.bio = result;
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
                  WDG_FooterConfirmCancel(
                    confirmTitle: "ثبت نام",
                    //confirmRoute: AdminDoctorsPage(),
                    confirmCallback: (result) async {
                      setState(() {
                        vis = true;
                      });
                      if (isValid > 0) return;
                      widget.obj.status = "partner";
                      var res =
                          await UserService().add(widget.obj, widget.password);
                      if (res != null) {
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
        ),
        onWillPop: () => backPress(),
      ),
    );
  }
}
