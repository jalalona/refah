import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:refah/pages/admin/AdminPanelPage.dart';
import 'package:refah/services/UserMessageService.dart';

class AdminChatPage extends StatefulWidget {
  String title;
  String description;

  Widget content;

  AdminChatPage({
    this.description,
    this.title,
  });

  @override
  _AdminChatPageState createState() => _AdminChatPageState();
}

class _AdminChatPageState extends State<AdminChatPage>
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

    UserMessageService().init().then((value) {
      setState(() {
        list = UserMessageService().getWidgetList(context);
      });
    });

    UserMessageService().setRefreshCallback((result) {
      UserMessageService().init().then((value) {
        setState(() {
          list = UserMessageService().getWidgetList(context);
        });
      });
    });
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
                  top: 10.0,
                  left: 40.0,
                  right: 40.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        child: SvgPicture.asset(
                          "images/backarrow.svg",
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminPanelPage(),
                          ),
                        );
                      },
                    ),
                    Text(
                      widget.title ?? "عنوان صفحه",
                      style: TextStyle(
                        fontFamily: "IRANSans",
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                    top: 10.0,
                    left: 10.0,
                    right: 10.0,
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
                    children:
                        list ?? UserMessageService().getWidgetList(context),
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
