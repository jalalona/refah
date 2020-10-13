import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:refah/api/ProfileService.dart';
import 'package:refah/pages/admin/AdminPanelPage.dart';
import 'package:refah/widgets/WDG_FooterConfirmCancel.dart';
import 'package:refah/widgets/WDG_SMSForm.dart';

class AdminSMSPage extends StatefulWidget {
  String title;
  String description;

  Widget content;

  AdminSMSPage({
    this.description,
    this.title,
  });

  @override
  _AdminSMSPageState createState() => _AdminSMSPageState();
}

class _AdminSMSPageState extends State<AdminSMSPage> {
  String text = "";

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
        child: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 50.0),
                  child: Center(
                    child: WDG_SMSForm(
                      onTextChangeCallback: (result) {
                        text = result;
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Text(""),
                ),
                WDG_FooterConfirmCancel(
                  confirmTitle: "ارسال",
                  //confirmRoute: ProccessSuccessPage(),
                  confirmCallback: (result) async {
                    if (text != null && text.length > 0) {
                      var res = await ProfileService().sendShareSMS(text);

                      if (res) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.SUCCES,
                          animType: AnimType.BOTTOMSLIDE,
                          title: 'ارسال پیام',
                          desc: 'با موفقیت پیام های تبلیغاتی ارسال شد',
                          btnOkText: "خب",
                          btnOkOnPress: () async {
                            //
                          },
                        )..show();
                      }
                    }
                  },
                  cancelRoute: AdminPanelPage(),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () => backPress(),
      ),
    );
  }
}
