import 'dart:io';

import 'package:flutter/material.dart';
import 'package:refah/api/ProfileService.dart';
import 'package:refah/models/EnrollOrderVM.dart';
import 'package:refah/models/OrderVM.dart';
import 'package:refah/models/UserSampleVM.dart';
import 'package:refah/pages/admin/AdminPanelPage.dart';
import 'package:refah/pages/admin/AdminProccessSuccessPage.dart';
import 'package:refah/services/EnrollOrderService.dart';
import 'package:refah/services/OrderService.dart';
import 'package:refah/services/UserSampleService.dart';
import 'package:refah/widgets/WDG_AdminCustomBanner.dart';
import 'package:refah/widgets/WDG_CustomUploadBorderedInput.dart';
import 'package:refah/widgets/WDG_FooterConfirmCancel.dart';
import 'package:refah/widgets/WDG_UploadBorderedInput.dart';

class AdminSampleUploadPage extends StatefulWidget {
  String title;
  String description;
  Widget route;
  Function(dynamic result) onUploadComplatedCallback;

  Widget content;

  AdminSampleUploadPage({
    this.route,
    this.onUploadComplatedCallback,
    this.description,
    this.title,
  });

  @override
  _AdminSampleUploadPageState createState() => _AdminSampleUploadPageState();
}

class _AdminSampleUploadPageState extends State<AdminSampleUploadPage> {
  bool vis = false;
  int isValid = 0;
  UserSampleVM sample = UserSampleVM();

  Future<List<UserSampleVM>> initAds() async {
    var res = await UserSampleService().init();

    return res;
  }

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

    sample.userId = ProfileService().getUserData().id;
    sample.userCreatedId = sample.userId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1fac9c),
      body: WillPopScope(
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            //height: 250.0,
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
                WDG_CustomUploadBorderedInput(
                  fileName: "تصویر تخفیف",
                  id: ProfileService().getUserData().id,
                  property: "filePath",
                  onTapCallback: (result) {
                    // method
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
                Flexible(
                  child: FutureBuilder(
                    future: initAds(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Container(
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return WDG_AdminCustomBanner(
                                sample: snapshot.data[index],
                                onTapCallback: (result) {
                                  setState(() {
                                    vis = false;
                                  });
                                },
                                onTapStartCallback: (result) {
                                  setState(() {
                                    vis = false;
                                  });
                                },
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
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
