import 'dart:io';

import 'package:flutter/material.dart';
import 'package:refah/models/EnrollVM.dart';
import 'package:refah/widgets/WDG_FooterConfirmCancel.dart';
import 'package:refah/widgets/WDG_UploadBorderedInput.dart';

import 'InsuranceFamilyPage.dart';
import 'InsuranceRegisterPage.dart';

class InsuranceUploadPage extends StatefulWidget {
  EnrollVM obj;
  String title;
  String description;

  Widget content;

  InsuranceUploadPage({
    this.obj,
    this.description,
    this.title,
  });

  @override
  _InsuranceUploadPageState createState() => _InsuranceUploadPageState();
}

class _InsuranceUploadPageState extends State<InsuranceUploadPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> backPress() async {
    await sleep(
      Duration(milliseconds: 10),
    );

    Navigator.pop(context);
    // Navigator.push(
    //   (context),
    //   MaterialPageRoute(
    //     builder: (context) => InsuranceRegisterPage(),
    //   ),
    // );

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1fac9c),
      body: WillPopScope(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                    top: 100.0,
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
                        fileName: "کارت ملی",
                        obj: widget.obj,
                        property: "nationalCard",
                        onTapCallback: (result) {
                          // method
                        },
                      ),
                      WDG_UploadBorderedInput(
                        fileName: "شناسنامه",
                        obj: widget.obj,
                        property: "identityCard",
                        onTapCallback: (result) {
                          // method
                        },
                      ),
                      WDG_UploadBorderedInput(
                        fileName: "دفترچه بیمه",
                        obj: widget.obj,
                        property: "insuranceCard",
                        onTapCallback: (result) {
                          // method
                        },
                      ),
                      WDG_UploadBorderedInput(
                        fileName: "عکس پرسنلی",
                        obj: widget.obj,
                        property: "avatar",
                        onTapCallback: (result) {
                          // method
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Text(""),
              ),
              WDG_FooterConfirmCancel(
                pop: true,
                confirmRoute: InsuranceFamilyPage(),
                cancelRoute: InsuranceRegisterPage(),
              ),
            ],
          ),
        ),
        onWillPop: () => backPress(),
      ),
    );
  }
}
