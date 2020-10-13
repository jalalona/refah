import 'package:flutter/material.dart';
import 'package:refah/Widgets/WDG_BigBorderedGrayButton.dart';
import 'package:refah/Widgets/WDG_BigHeader.dart';
import 'package:refah/assets/ColorAsset.dart';
import 'package:refah/services/OptionService.dart';

import 'admin/AdminLogin.dart';
import 'clients/ClientLogin.dart';
import 'doctors/DoctorLogin.dart';

class LoginHome extends StatefulWidget {
  @override
  _LoginHomeState createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  Map<String, dynamic> values;

  @override
  void initState() {
    super.initState();

    OptionService().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Column(
        children: <Widget>[
          WDG_BigHeader(
            text: "رفاه اندیشان",
          ),
          SizedBox(
            height: 20.0,
          ),
          WDG_BigBorderedGrayButton(
            width: 250.0,
            route: AdminLogin(),
            text: "ورود مدیریت",
          ),
          WDG_BigBorderedGrayButton(
            width: 250.0,
            route: DoctorLogin(),
            text: "ورود مراکز طرف قرارداد",
          ),
          WDG_BigBorderedGrayButton(
            width: 250.0,
            route: ClientLogin(),
            text: "ورود اعضاء",
          ),
        ],
      ),
    );
  }
}
