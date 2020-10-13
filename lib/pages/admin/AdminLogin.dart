import 'package:flutter/material.dart';
import 'package:refah/Widgets/WDG_BackIconCircle.dart';
import 'package:refah/Widgets/WDG_LoginForm.dart';
import 'package:refah/Widgets/WDG_VerificationIcon.dart';
import 'package:refah/pages/admin/AdminPanelPage.dart';

import '../LoginHome.dart';

class AdminLogin extends StatefulWidget {
  AdminLogin({
    Key key,
  }) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  bool vis = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 75.0,
            ),
            WDG_VerificationIcon(),
            Container(
              margin: EdgeInsets.only(
                top: 30.0,
                bottom: 30.0,
                left: 100.0,
                right: 100.0,
              ),
              child: Text(
                "مدیر عزیز می توانید با وارد کردن کد ملی و شماره موبایل می توانید وارد سیستم شوید",
                style: TextStyle(
                  fontFamily: "IRANSans",
                ),
                textAlign: TextAlign.center,
              ),
            ),
            WDG_LoginForm(
              width: MediaQuery.of(context).size.width * 0.8,
              callback: (mobile, password) async {
                //
              },
              userType: "admin",
              loginRoute: AdminPanelPage(),
            ),
            SizedBox(
              height: 35.0,
            ),
            Visibility(
              child: Container(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(),
              ),
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: vis,
            ),
            WDG_BackIconCircle(
              route: LoginHome(),
            )
          ],
        ),
      ),
    );
  }
}
