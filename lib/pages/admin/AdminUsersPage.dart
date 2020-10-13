import 'dart:io';

import 'package:flutter/material.dart';
import 'package:refah/services/UserService.dart';
import 'package:refah/widgets/WDG_BorderedGrayButton.dart';
import 'package:refah/widgets/WDG_SearchInput.dart';
import 'AdminPanelPage.dart';
import 'Registeration/AdminUserRegisterPage.dart';

class AdminUsersPage extends StatefulWidget {
  String title;
  String description;

  Widget content;

  AdminUsersPage({
    this.description,
    this.title,
  });

  @override
  _AdminUsersPageState createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage>
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

    UserService().init().then((value) {
      setState(() {
        list = UserService().getUserWidgetList(context);
      });
    });

    UserService().setRefreshCallback((result) {
      UserService().init().then((value) {
        setState(() {
          list = UserService().getUserWidgetList(context);
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
                      setState(() {
                        vis = true;
                      });
                      UserService().init().then((value) {
                        setState(() {
                          list = UserService().getUserWidgetList(context);
                          vis = false;
                        });
                      });
                    }
                  },
                  submitSearchTextCallback: (result) async {
                    setState(() {
                      vis = true;
                    });
                    var users = await UserService().search(result);

                    list =
                        UserService().getCustomUserWidgetList(context, users);

                    setState(() {
                      vis = false;
                    });
                  },
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
              Container(
                margin: EdgeInsets.all(10.0),
                child: WDG_BorderedGrayButton(
                  text: "+ افزودن یک کاربر",
                  route: AdminUserRegisteryPage(),
                ),
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
