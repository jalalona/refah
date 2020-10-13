import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:refah/api/ProfileService.dart';
import 'package:refah/pages/doctors/DoctorMessagedUsersPage.dart';
import 'package:refah/widgets/WDG_BigBorderedGrayButton.dart';

import 'PatientSearchPage.dart';

class DoctorChoosePage extends StatefulWidget {
  String title;
  String description;

  Widget content;

  DoctorChoosePage({
    this.description,
    this.title,
  });

  @override
  _DoctorChoosePageState createState() => _DoctorChoosePageState();
}

class _DoctorChoosePageState extends State<DoctorChoosePage> {
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
      backgroundColor: const Color(0xfff6f6f6),
      body: WillPopScope(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              "images/ballonbackground.png",
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              // margin: EdgeInsets.only(
              //   top: 100.0,
              //   left: 10.0,
              //   right: 10.0,
              //   bottom: 50.0,
              // ),
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: Text(
                        ProfileService().getUserData().fullname + " خوش امدید",
                        style: TextStyle(
                          fontFamily: "IRANSans",
                          color: Colors.green,
                        ),
                      ),
                    ),
                    WDG_BigBorderedGrayButton(
                      text: "جستجوی بیمار",
                      route: PatientSearchPage(),
                    ),
                    WDG_BigBorderedGrayButton(
                      text: "صندوق پیام ها",
                      route: DoctorMessagedUsersPage(),
                    ),
                    WDG_BigBorderedGrayButton(
                      text: "خروج",
                      //route: LoginHome(),
                      onTapCallback: (result) {
                        SystemNavigator.pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        onWillPop: () => backPress(),
      ),
    );
  }
}
