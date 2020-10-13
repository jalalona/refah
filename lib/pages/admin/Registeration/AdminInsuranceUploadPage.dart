import 'dart:io';

import 'package:flutter/material.dart';
import 'package:refah/models/EnrollVM.dart';
import 'package:refah/pages/ProccessSuccessPage.dart';
import 'package:refah/pages/admin/AdminPanelPage.dart';
import 'package:refah/pages/admin/AdminProccessSuccessPage.dart';
import 'package:refah/services/EnrollService.dart';
import 'package:refah/widgets/WDG_FooterConfirmCancel.dart';
import 'package:refah/widgets/WDG_UploadBorderedInput.dart';

import 'AdminInsuranceRegisterPage.dart';

class AdminInsuranceUploadPage extends StatefulWidget {
  String title;
  String description;
  EnrollVM obj;
  Widget route;
  Function(dynamic result) onUploadComplatedCallback;

  Widget content;

  AdminInsuranceUploadPage({
    this.obj,
    this.route,
    this.onUploadComplatedCallback,
    this.description,
    this.title,
  });

  @override
  _AdminInsuranceUploadPageState createState() =>
      _AdminInsuranceUploadPageState();
}

class _AdminInsuranceUploadPageState extends State<AdminInsuranceUploadPage> {
  int isValid = 0;

  Future<bool> backPress() async {
    await sleep(
      Duration(milliseconds: 10),
    );

    Navigator.pop(context);
    // Navigator.push(
    //   (context),
    //   MaterialPageRoute(
    //     builder: (context) => AdminPanelPage(),
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
        child: Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                  top: 50.0,
                  left: 10.0,
                  right: 10.0,
                  bottom: 50.0,
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
                    WDG_UploadBorderedInput(
                      // isRequired: true,
                      // onErrorCallback: (error) {
                      //   isValid = error;
                      // },
                      fileName: "کارت ملی",
                      obj: widget.obj,
                      property: "nationalCard",
                      onTapCallback: (result) {
                        // method
                      },
                    ),
                    WDG_UploadBorderedInput(
                      // isRequired: true,
                      // onErrorCallback: (error) {
                      //   isValid = error;
                      // },
                      fileName: "شناسنامه",
                      obj: widget.obj,
                      property: "identityCard",
                      onTapCallback: (result) {
                        // method
                      },
                    ),
                    WDG_UploadBorderedInput(
                      // isRequired: true,
                      // onErrorCallback: (error) {
                      //   isValid = error;
                      // },
                      fileName: "دفترچه بیمه",
                      obj: widget.obj,
                      property: "insuranceCard",
                      onTapCallback: (result) {
                        // method
                      },
                    ),
                    WDG_UploadBorderedInput(
                      // isRequired: true,
                      // onErrorCallback: (error) {
                      //   isValid = error;
                      // },
                      fileName: "عکس پرسنلی",
                      obj: widget.obj,
                      property: "avatar",
                      onTapCallback: (result) {
                        // method
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2.0,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Text(""),
              ),
              WDG_FooterConfirmCancel(
                //confirmRoute: AdminProccessSuccessPage(),
                confirmCallback: (result) {
                  if (isValid > 0) return;
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminProccessSuccessPage(),
                    ),
                  );
                  //
                },
                cancelRoute: AdminPanelPage(),
              ),
            ],
          ),
        ),
        onWillPop: () => backPress(),
      ),
    );
  }
}
