import 'dart:io';

import 'package:flutter/material.dart';
import 'package:refah/services/EnrollService.dart';
import 'package:refah/services/UserService.dart';
import 'package:refah/widgets/WDG_BorderedGrayButton.dart';
import 'package:refah/widgets/WDG_SearchInput.dart';
import 'AdminPanelPage.dart';
import 'Registeration/AdminUserRegisterPage.dart';

class AdminEnrollsPage extends StatefulWidget {
  String title;
  String description;

  Widget content;

  AdminEnrollsPage({
    this.description,
    this.title,
  });

  @override
  _AdminEnrollsPageState createState() => _AdminEnrollsPageState();
}

class _AdminEnrollsPageState extends State<AdminEnrollsPage>
    with WidgetsBindingObserver {
  List<Widget> list = List<Widget>();
  bool vis = false;

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

    EnrollService().init().then((value) {
      setState(() {
        list = EnrollService().getEnrollWidgetList(context);
      });
    });

    EnrollService().setRefreshCallback((result) {
      EnrollService().init().then((value) {
        setState(() {
          list = EnrollService().getEnrollWidgetList(context);
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
      UserService().init().then((value) {
        setState(() {
          list = UserService().getUserWidgetList(context);
        });
      });
    }
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
                margin: EdgeInsets.only(
                  top: 10.0,
                  left: 30.0,
                  right: 30.0,
                  bottom: 10.0,
                ),
                child: WDG_SearchInput(
                  hint: "جستجوی کاربر",
                  searchTextChangeCallback: (result) {
                    if (result.isEmpty) {
                      EnrollService().init().then((value) {
                        setState(() {
                          list = EnrollService().getEnrollWidgetList(context);
                        });
                      });
                    }
                  },
                  submitSearchTextCallback: (result) async {
                    setState(() {
                      vis = true;
                    });
                    var enrolls = await EnrollService().search(result);

                    list = EnrollService()
                        .getCustomEnrollWidgetList(context, enrolls);

                    setState(() {
                      vis = false;
                    });
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: WDG_BorderedGrayButton(
                  text: "+ افزودن یک کاربر",
                  route: AdminUserRegisteryPage(),
                ),
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
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(10.0),
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
                    children: list ?? UserService().getUserWidgetList(context),
                  ),
                ),
              ),
            ],
          ),
        ),
        onWillPop: () => backPress(),
      ),
    );
  }
}
