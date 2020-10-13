import 'dart:io';

import 'package:flutter/material.dart';
import 'package:refah/models/UserCommentVM.dart';
import 'package:refah/pages/admin/AdminCommentPage.dart';
import 'package:refah/services/OptionService.dart';
import 'package:refah/services/UserCommentService.dart';
import 'package:refah/widgets/WDG_BorderedMultilineTextInput.dart';
import 'package:refah/widgets/WDG_FooterConfirmCancel.dart';

class AdminCommentEditPage extends StatefulWidget {
  UserCommentVM obj;
  String title;
  String description;

  Widget content;

  AdminCommentEditPage({
    this.description,
    this.title,
    this.obj,
  });

  @override
  _AdminCommentEditPageState createState() => _AdminCommentEditPageState();
}

class _AdminCommentEditPageState extends State<AdminCommentEditPage> {
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
    //     builder: (context) => AdminCommentPage(),
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
            children: <Widget>[
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
                    SizedBox(
                      height: 15.0,
                    ),
                    WDG_BorderedMultilineTextInput(
                      //isRequired: true,
                      onErrorCallback: (error) {
                        isValid = error;
                      },
                      value: widget.obj.description,
                      hintText: "متن کامنت",
                      height: 250.0,
                      minLines: 5,
                      maxLines: 15,
                      onChangeCallback: (result) {
                        widget.obj.description = result;
                      },
                    ),
                    SizedBox(
                      height: 15.0,
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
                confirmTitle: "بروز رسانی",
                confirmCallback: (result) async {
                  setState(() {
                    vis = true;
                  });
                  if (isValid > 0) return;
                  var response = await UserCommentService().update(widget.obj);
                  if (response != null) {
                    await OptionService().init();
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminCommentPage(),
                      ),
                    );
                  }
                  setState(() {
                    vis = false;
                  });
                },
                //confirmRoute: AdminSettingPage(),
                cancelRoute: AdminCommentPage(),
              ),
            ],
          ),
        ),
        onWillPop: () => backPress(),
      ),
    );
  }
}
