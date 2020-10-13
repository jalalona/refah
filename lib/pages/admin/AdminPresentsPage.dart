import 'dart:io';

import 'package:flutter/material.dart';
import 'package:refah/pages/admin/Registeration/AdminPresentRegisterPage.dart';
import 'package:refah/pages/admin/Registeration/AdminSettingRegisterPage.dart';
import 'package:refah/services/OptionService.dart';
import 'package:refah/widgets/WDG_BorderedGrayButton.dart';
import 'package:refah/widgets/WDG_SearchInput.dart';

import 'AdminPanelPage.dart';

class AdminPresentsPage extends StatefulWidget {
  String title;
  String description;

  Widget content;

  AdminPresentsPage({
    this.description,
    this.title,
  });

  @override
  _AdminPresentsPageState createState() => _AdminPresentsPageState();
}

class _AdminPresentsPageState extends State<AdminPresentsPage>
    with WidgetsBindingObserver {
  List<Widget> list = List<Widget>();

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

    OptionService().init().then((value) {
      setState(() {
        list = OptionService().getPresentsWidgetList(context);
      });
    });

    OptionService().setRefreshCallback((result) {
      OptionService().init().then((value) {
        setState(() {
          list = OptionService().getPresentsWidgetList(context);
        });
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      OptionService().init().then((value) {
        setState(() {
          list = OptionService().getPresentsWidgetList(context);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      body: WillPopScope(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              "images/BigGreenHeader.png",
              width: MediaQuery.of(context).size.width,
              height: 100.0,
              fit: BoxFit.fill,
            ),
            Container(
              margin: EdgeInsets.only(
                top: 75.0,
                bottom: 10.0,
                left: 0.0,
                right: 0.0,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      left: 30.0,
                      right: 30.0,
                    ),
                    child: WDG_SearchInput(
                      hint: "جستجوی خدمت",
                      searchTextChangeCallback: (result) {
                        // method
                      },
                      submitSearchCallback: (result) {
                        // method
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: WDG_BorderedGrayButton(
                      text: "+ افزودن یک خدمت",
                      route: AdminPresentRegisteryPage(),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 200.0,
                        margin: EdgeInsets.only(
                          top: 5.0,
                          bottom: 10.0,
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
                        child: ListView(
                          children: list ??
                              OptionService().getPresentsWidgetList(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onWillPop: () => backPress(),
      ),
    );
  }
}
