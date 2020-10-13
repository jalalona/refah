import 'dart:io';

import 'package:flutter/material.dart';
import 'package:refah/services/UserService.dart';
import 'package:refah/widgets/WDG_BorderedGrayButton.dart';
import 'package:refah/widgets/WDG_SearchInput.dart';

import 'AdminPanelPage.dart';
import 'Registeration/AdminDoctorRegisterPage.dart';

class AdminDoctorsPage extends StatefulWidget {
  String title;
  String description;

  Widget content;

  AdminDoctorsPage({
    this.description,
    this.title,
  });

  @override
  _AdminDoctorsPageState createState() => _AdminDoctorsPageState();
}

class _AdminDoctorsPageState extends State<AdminDoctorsPage>
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

    UserService().init().then((value) {
      setState(() {
        list = UserService().getOfficeWidgetList(context);
      });
    });

    UserService().setRefreshCallback((result) {
      UserService().init().then((value) {
        setState(() {
          list = UserService().getOfficeWidgetList(context);
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
          list = UserService().getOfficeWidgetList(context);
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
                  top: 20.0,
                  left: 30.0,
                  right: 30.0,
                ),
                child: WDG_SearchInput(
                  hint: "جستجوی همکار",
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
                  text: "+ افزودن یک مرکز",
                  route: AdminDoctorRegisteryPage(),
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(
                    10.0,
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
                    children:
                        list ?? UserService().getOfficeWidgetList(context),
                  ),
                ),
              )
            ],
          ),
        ),
        onWillPop: () => backPress(),
      ),
    );
  }
}
