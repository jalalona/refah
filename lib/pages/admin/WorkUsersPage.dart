import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:refah/models/WorkVM.dart';
import 'package:refah/services/UserService.dart';
import 'package:refah/services/WorkService.dart';

class WorkUsersPage extends StatefulWidget {
  String title;
  String description;

  Widget content;

  WorkUsersPage({
    this.description,
    this.title,
  });

  @override
  _WorkUsersPageState createState() => _WorkUsersPageState();
}

class _WorkUsersPageState extends State<WorkUsersPage>
    with WidgetsBindingObserver {
  List<Widget> list = List<Widget>();
  bool vis = false;

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

    WorkService().init().then((value) {
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
                  child: FutureBuilder(
                    future: WorkService().init(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Container(
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.all(5.0),
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black45,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Column(
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    InkWell(
                                      child: Icon(
                                        Icons.remove_circle_rounded,
                                        color: Colors.red,
                                      ),
                                      onTap: () async {
                                        var result = await WorkService().delete(
                                          (snapshot.data[index] as WorkVM),
                                        );

                                        setState(() {});
                                      },
                                    ),
                                    Container(
                                      height: 35.0,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        (snapshot.data[index] as WorkVM).phone,
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                    Container(
                                      height: 100.0,
                                      width: MediaQuery.of(context).size.width,
                                      child: SingleChildScrollView(
                                        child: Text(
                                          (snapshot.data[index] as WorkVM)
                                              .message,
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
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
