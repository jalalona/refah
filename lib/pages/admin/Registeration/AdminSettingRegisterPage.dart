import 'dart:io';

import 'package:flutter/material.dart';
import 'package:refah/models/OptionMicroVM.dart';
import 'package:refah/pages/admin/AdminSettingPage.dart';
import 'package:refah/services/OptionService.dart';
import 'package:refah/widgets/WDG_BorderedMultilineTextInput.dart';
import 'package:refah/widgets/WDG_BorderedTextInput.dart';
import 'package:refah/widgets/WDG_FooterConfirmCancel.dart';

import '../AdminPanelPage.dart';

class AdminSettingRegisteryPage extends StatefulWidget {
  final OptionMicroVM obj = OptionMicroVM();
  String title;
  String description;

  Widget content;

  AdminSettingRegisteryPage({
    this.description,
    this.title,
  });

  @override
  _AdminSettingRegisteryPageState createState() =>
      _AdminSettingRegisteryPageState();
}

class _AdminSettingRegisteryPageState extends State<AdminSettingRegisteryPage> {
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
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                  top: 50.0,
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
                    WDG_BorderedTextInput(
                      isRequired: true,
                      onErrorCallback: (error) {
                        isValid = error;
                      },
                      hintText: "عنوان",
                      value: widget.obj.title ?? "",
                      onChangeCallback: (result) {
                        widget.obj.title = result;
                      },
                    ),
                    WDG_BorderedTextInput(
                      isRequired: true,
                      onErrorCallback: (error) {
                        isValid = error;
                      },
                      value: widget.obj.name ?? "",
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
                      value: widget.obj.type ?? "",
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
                      value: widget.obj.value ?? "",
                      hintText: "مقدار",
                      height: 250.0,
                      minLines: 5,
                      maxLines: 15,
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
              Expanded(
                child: Text(""),
              ),
              WDG_FooterConfirmCancel(
                confirmTitle: "ذخیره سازی",
                confirmCallback: (result) async {
                  setState(() {
                    vis = true;
                  });
                  if (isValid > 0) return;
                  var response = await OptionService().add(widget.obj);
                  if (response != null) {
                    await OptionService().init();
                    Navigator.pop(context);
                    Navigator.push(
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
        onWillPop: () => backPress(),
      ),
    );
  }
}
