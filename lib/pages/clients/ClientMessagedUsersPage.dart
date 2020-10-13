import 'dart:io';

import 'package:flutter/material.dart';
import 'package:refah/models/UserVM.dart';
import 'package:refah/pages/clients/ClientHomePage.dart';
import 'package:refah/pages/doctors/DoctorMessagePage.dart';
import 'package:refah/services/UserService.dart';
import 'package:refah/widgets/WDG_BigIconButton.dart';

import 'ClientMessagePage.dart';

class ClientMessagedUsersPage extends StatefulWidget {
  String title;
  String description;

  Widget content;

  ClientMessagedUsersPage({
    this.description,
    this.title,
  });

  @override
  _ClientMessagedUsersPageState createState() =>
      _ClientMessagedUsersPageState();
}

class _ClientMessagedUsersPageState extends State<ClientMessagedUsersPage> {
  bool vis = false;
  List<Widget> items = [Text("")];
  Future<List<UserVM>> setupMessagedUsers() async {
    setState(() {
      vis = true;
    });
    var res = await UserService().getAllMessagedUsers();
    try {
      setState(() {
        items = res
            .map(
              (e) => WDG_BigIconButton(
                title: e.fullname ?? "نام کاربر",
                description: e.nationalId ?? "کد ملی",
                icon: e.avatar != null && e.avatar.isNotEmpty
                    ? Image.network("https://api.refahandishanco.ir" + e.avatar)
                    : Image.asset(
                        "images/familyinsurance.png",
                      ),
                route: ClientMessagePage(
                  user: e,
                ),
                marginValue: 5.0,
              ),
            )
            .toList();
      });
    } catch (e) {
      print(e);
    }

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
    // Navigator.push(
    //   (context),
    //   MaterialPageRoute(
    //     builder: (context) => ClientHomePage(),
    //   ),
    // );

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
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   margin: EdgeInsets.only(
              //     top: 75.0,
              //     right: 50.0,
              //     left: 50.0,
              //   ),
              //   child: IntrinsicHeight(
              //     child: Row(
              //       children: <Widget>[
              //         InkWell(
              //           child: Container(
              //             padding: EdgeInsets.all(5.0),
              //             child: SvgPicture.asset(
              //               "images/backarrow.svg",
              //             ),
              //           ),
              //           onTap: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => DoctorChoosePage(),
              //               ),
              //             );
              //           },
              //         ),
              //         Expanded(
              //           child: Text(
              //             widget.title ?? "عنوان صفحه",
              //             style: TextStyle(
              //               fontFamily: "IRANSans",
              //               color: Colors.white,
              //             ),
              //             textAlign: TextAlign.right,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        onWillPop: () => backPress(),
      ),
    );
  }
}
