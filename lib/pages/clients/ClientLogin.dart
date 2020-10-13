import 'package:flutter/material.dart';
import 'package:refah/Widgets/WDG_LoginForm.dart';
import 'package:refah/Widgets/WDG_VerificationIcon.dart';
import 'package:refah/pages/LoginHome.dart';
import 'package:refah/pages/Splash1.dart';
import 'package:refah/widgets/WDG_BackIconCircle.dart';

class ClientLogin extends StatelessWidget {
  ClientLogin({
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
                "دوستان عزیز می توانید با وارد کردن کد ملی و شماره موبایل خود وارد اپلیکیشن رفاه اندیشان شوید",
                style: TextStyle(
                  fontFamily: "IRANSans",
                ),
                textAlign: TextAlign.center,
              ),
            ),
            WDG_LoginForm(
              width: MediaQuery.of(context).size.width * 0.8,
              // callback: (mobile, password) {
              //   Navigator.pop(context);
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => Splash1(),
              //     ),
              //   );
              // },
              userType: "people",
              loginRoute: Splash1(),
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
