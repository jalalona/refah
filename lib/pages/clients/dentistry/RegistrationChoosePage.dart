import 'dart:io';

import 'package:flutter/material.dart';
import 'package:refah/pages/clients/ClientHomePage.dart';
import 'package:refah/pages/clients/dentistry/DentistryFamilyRegisteryPage.dart';
import 'package:refah/services/EnrollService.dart';
import 'package:refah/widgets/WDG_BigBorderedGrayButton.dart';

import 'DentistryAloneRegisteryPage.dart';

class RegisterationChoosePage extends StatefulWidget {
  String title;
  String description;

  Widget content;

  RegisterationChoosePage({
    this.description,
    this.title,
  });

  @override
  _RegisterationChoosePageState createState() =>
      _RegisterationChoosePageState();
}

class _RegisterationChoosePageState extends State<RegisterationChoosePage> {
  Future<bool> backPress() async {
    await sleep(
      Duration(milliseconds: 10),
    );

    Navigator.pop(context);
    // Navigator.push(
    //   (context),
    //   MaterialPageRoute(
    //     builder: (context) => ClientHomePage(),
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
                    WDG_BigBorderedGrayButton(
                      text: "ثبت نام فردی",
                      route: DentistryAloneRegisteryPage(),
                    ),
                    WDG_BigBorderedGrayButton(
                      text: "ثبت نام خانوادگی",
                      route: DentistryFamilyRegisteryPage(),
                      onTapCallback: (result) {
                        EnrollService().clearMyEnrolls();
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
