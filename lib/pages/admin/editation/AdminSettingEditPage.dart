import 'dart:io';

import 'package:flutter/material.dart';
import 'package:refah/models/OptionVM.dart';
import 'package:refah/pages/admin/AdminSettingPage.dart';
import 'package:refah/services/OptionService.dart';
import 'package:refah/widgets/WDG_BorderedMultilineTextInput.dart';
import 'package:refah/widgets/WDG_BorderedTextInput.dart';
import 'package:refah/widgets/WDG_FooterConfirmCancel.dart';

import '../AdminPanelPage.dart';

class AdminSettingEditPage extends StatefulWidget {
  OptionVM obj;
  String title;
  String description;

  Widget content;

  AdminSettingEditPage({
    this.description,
    this.title,
    this.obj,
  });

  @override
  _AdminSettingEditPageState createState() => _AdminSettingEditPageState();
}

class _AdminSettingEditPageState extends State<AdminSettingEditPage> {
  int isValid = 0;
  bool vis = false;

  Future<bool> backPress() async {
    await sleep(
      Duration(milliseconds: 10),
    );

    Navigator.pop(context);
    // Navigator.push(
    //   (context),
    //   MaterialPageRoute(
    //     builder: (context) => AdminSettingPage(),
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
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                    top: 20.0,
                    left: 10.0,
                    right: 10.0,
                    bottom: 20.0,
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
                      SizedBox(
                        height: 30.0,
                      ),
                      WDG_BorderedTextInput(
                        isRequired: true,
                        onErrorCallback: (error) {
                          isValid = error;
                        },
                        value: widget.obj.title,
                        hintText: "عنوان",
                        onChangeCallback: (result) {
                          widget.obj.title = result;
                        },
                      ),
                      WDG_BorderedTextInput(
                        isRequired: true,
                        onErrorCallback: (error) {
                          isValid = error;
                        },
                        value: widget.obj.name,
                        hintText: "نام",
                        inputType: TextInputType.text,
                        onChangeCallback: (result) {
                          widget.obj.name = result;
                        },
                      ),
                      WDG_BorderedTextInput(
                        isRequired: true,
                        onErrorCallback: (error) {
                          isValid = error;
                        },
                        value: widget.obj.type,
                        hintText: "نوع",
                        inputType: TextInputType.text,
                        onChangeCallback: (result) {
                          widget.obj.type = result;
                        },
                      ),
                      WDG_BorderedMultilineTextInput(
                        isRequired: true,
                        onErrorCallback: (error) {
                          isValid = error;
                        },
                        value: widget.obj.value,
                        hintText: "مقدار",
                        height: 200.0,
                        minLines: 5,
                        maxLines: 20,
                        onChangeCallback: (result) {
                          widget.obj.value = result;
                        },
                      ),
                      Visibility(
                        child: Container(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(),
                        ),
                        maintainSize: false,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: vis,
                      ),
                    ],
                  ),
                ),
                WDG_FooterConfirmCancel(
                  confirmTitle: "بروز رسانی",
                  confirmCallback: (result) async {
                    setState(() {
                      vis = true;
                    });
                    if (isValid > 0) return;
                    var response = await OptionService().update(widget.obj);
                    if (response != null) {
                      await OptionService().init();
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminSettingPage(),
                        ),
                      );
                    }
                    setState(() {
                      vis = false;
                    });
                  },
                  //confirmRoute: AdminSettingPage(),
                  cancelRoute: AdminSettingPage(),
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
