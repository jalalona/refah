import 'dart:io';

import 'package:flutter/material.dart';
import 'package:refah/pages/admin/AdminPanelPage.dart';
import 'package:refah/pages/clients/ClientHomePage.dart';
import 'package:refah/widgets/WDG_BackIconCircle.dart';
import 'package:refah/widgets/WDG_BigGreenButton.dart';

class AdminProccessSuccessPage extends StatefulWidget {
  String title;
  String description;
  String totalPrice;

  Widget content;

  AdminProccessSuccessPage({
    this.description,
    this.title,
    this.totalPrice,
  });

  @override
  _AdminProccessSuccessPageState createState() =>
      _AdminProccessSuccessPageState();
}

class _AdminProccessSuccessPageState extends State<AdminProccessSuccessPage> {
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
      backgroundColor: const Color(0xfff6f6f6),
      body: WillPopScope(
        child: SafeArea(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(
                left: 30.0,
                right: 30.0,
              ),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: const Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(0, 10),
                    blurRadius: 38,
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 75.0,
                  ),
                  Container(
                    margin: EdgeInsets.all(5.0),
                    child: Text(
                      "با موفقیت اطلاعات شما ثبت شد",
                      style: TextStyle(
                        fontFamily: "IRANSans",
                      ),
                    ),
                  ),
                  Container(
                    child: WDG_BigGreenButton(
                      text: "تائید",
                      route: AdminPanelPage(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.0),
                    child: Text(
                      "بازگشت",
                      style: TextStyle(
                        fontFamily: "IRANSans",
                      ),
                    ),
                  ),
                  Container(
                    child: WDG_BackIconCircle(
                      route: AdminPanelPage(),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  )
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
