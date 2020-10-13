import 'dart:io';

import 'package:flutter/material.dart';
import 'package:refah/models/UserVM.dart';
import 'package:refah/pages/doctors/DoctorMessagePage.dart';
import 'package:refah/services/UserService.dart';
import 'package:refah/widgets/WDG_BigIconButton.dart';

class DoctorMessagedUsersPage extends StatefulWidget {
  String title;
  String description;

  Widget content;

  DoctorMessagedUsersPage({
    this.description,
    this.title,
  });

  @override
  _DoctorMessagedUsersPageState createState() =>
      _DoctorMessagedUsersPageState();
}

class _DoctorMessagedUsersPageState extends State<DoctorMessagedUsersPage> {
  bool vis = false;
  List<Widget> items = [Text("")];
  Future<List<UserVM>> setupMessagedUsers() async {
    setState(() {
      vis = true;
    });
    var res = await UserService().getAllMessagedUsers();

    setState(() {
      items = res
          .map(
            (e) => WDG_BigIconButton(
              title: e.fullname ?? "نام کاربر",
              description: e.nationalId ?? "کد ملی",
              icon: e.avatar != null && e.avatar.isNotEmpty
                  ? NetworkImage(e.avatar)
                  : Image.asset(
                      "images/familyinsurance.png",
                    ),
              route: DoctorMessagePage(
                user: e,
              ),
            ),
          )
          .toList();
    });
    setState(() {
      vis = false;
    });
    return res;
  }

  Future<bool> backPress() async {
    await sleep(
      Duration(milliseconds: 10),
    );

    Navigator.pop(context);

    return false;
  }

  @override
  void initState() {
    super.initState();

    setupMessagedUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1fac9c),
      body: WillPopScope(
        child: SafeArea(
          child: Column(
            children: <Widget>[
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
                child: Container(
                  // width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height - 80.0,
                  margin: EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                    right: 20.0,
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
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: items,
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
