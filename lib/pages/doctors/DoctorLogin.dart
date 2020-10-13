import 'package:flutter/material.dart';
import 'package:refah/Widgets/WDG_BackIconCircle.dart';
import 'package:refah/Widgets/WDG_LoginForm.dart';
import 'package:refah/Widgets/WDG_VerificationIcon.dart';
import 'package:refah/pages/doctors/DoctorChoosePage.dart';

import '../LoginHome.dart';

class DoctorLogin extends StatelessWidget {
  DoctorLogin({
    Key key,
  }) : super(key: key);
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
                "همکار عزیز و گرامی می توانید با وارد کردن کد ملی و شماره موبایل می توانید وارد سیستم شوید",
                style: TextStyle(
                  fontFamily: "IRANSans",
                ),
                textAlign: TextAlign.center,
              ),
            ),
            WDG_LoginForm(
              userType: "partner",
              width: MediaQuery.of(context).size.width * 0.8,
              callback: (mobile, password) {
                // Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => DoctorChoosePage(),
                //   ),
                // );
              },
            ),
            SizedBox(
              height: 35.0,
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
