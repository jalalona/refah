// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:refah/Provider/SignalR.dart';
import 'package:refah/api/ProfileService.dart';
import 'package:refah/models/ChatMessage.dart';
import 'package:refah/models/UserVM.dart';
import 'package:refah/pages/Splash1.dart';
import 'package:refah/pages/admin/AdminPanelPage.dart';
import 'package:refah/pages/doctors/DoctorChoosePage.dart';
import 'package:refah/services/OptionService.dart';
import 'package:url_launcher/url_launcher.dart';
import './WDG_BigGreenButton.dart';
import 'WDG_SizedInput.dart';

class WDG_LoginForm extends StatefulWidget {
  String userType;
  Widget loginRoute;

  double width;
  Function(String mobile, String password) callback;

  WDG_LoginForm({
    this.loginRoute,
    this.width = 320.0,
    this.callback,
    this.userType,
    Key key,
  }) : super(key: key);

  @override
  _WDG_LoginFormState createState() => _WDG_LoginFormState();
}

class _WDG_LoginFormState extends State<WDG_LoginForm> {
  String optionVersion;
  String nationalId = "";
  String mobile = "";
  bool vis = false;
  SignalR signalR;

  Future iosReciveLocalNotification(
    int id,
    String title,
    String body,
    String payload,
  ) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
      ),
    );
  }

  Future selectedNote(String payload) async {
    if (payload != null) {}
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      //throw 'Could not launch $url';
    }
  }

  checkAppVersion() async {
    setState(() {
      vis = true;
    });
    try {
      var info = await PackageInfo.fromPlatform();
      String version = info.version;
      setState(() {
        optionVersion = OptionService().getAppVersion(version);
      });
    } catch (e) {}
    setState(() {
      vis = false;
    });
  }

  @override
  void initState() {
    super.initState();

    signalR = SignalR(context);

    checkAppVersion();

    signalR.init().then((value) {
      signalR.setOnMessageRecivedCallback((result) async {
        // AwesomeNotifications().createNotification(
        //     content: NotificationContent(
        //         id: 12,
        //         channelKey: 'basic_channel',
        //         title: 'recive to',
        //         body: "result"));
      });
      signalR.setOnConnectedCallback((result) async {
        //   AwesomeNotifications().createNotification(
        //       content: NotificationContent(
        //           id: 12,
        //           channelKey: 'basic_channel',
        //           title: 'connected to',
        //           body: "result"));
      });
      signalR.setOnDisconnectCallback((result) async {
        await signalR.setConnection(ProfileService().getUserData().nationalId);

        await signalR.init();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: const Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: const Color(0x17000000),
            offset: Offset(0, 12),
            blurRadius: 29,
          ),
        ],
      ),
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
          optionVersion != null && optionVersion.isNotEmpty
              ? InkWell(
                  child: Container(
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Icon(
                          Icons.get_app,
                          color: Colors.redAccent,
                        ),
                        Text(
                          "نسخه جدید منتشر شده . برای دانلود لمس کنید",
                          style: TextStyle(
                            fontFamily: "IRANSans",
                            color: Colors.redAccent,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    _launchURL(optionVersion);
                  },
                )
              : SizedBox(
                  height: 1.0,
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // WDG_CountryCodeInput(disable: true),
              WDG_SizedInput(
                value: nationalId ?? "",
                inputType: TextInputType.number,
                max: 10,
                hint: "کدملی",
                onChangeCallback: (result) {
                  nationalId = result;
                },
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              WDG_SizedInput(
                value: mobile ?? "",
                inputType: TextInputType.number,
                //password: true,
                max: 11,
                hint: "شماره موبایل",
                onChangeCallback: (result) {
                  mobile = result;
                },
              ),
            ],
          ),
          SizedBox(
            height: 65.0,
          ),
          WDG_BigGreenButton(
            text: "ورود به سیستم",
            onTapCallback: (result) async {
              setState(() {
                vis = true;
              });
              var res = await ProfileService().CheckUser(
                nationalId,
                mobile,
              );

              if (res != null) {
                await signalR.setConnection(res.userName);
              }

              if (res == null && widget.userType == "people") {
                UserVM user = UserVM(
                  age: 30,
                  fullname: "no name",
                  nationalId: nationalId,
                  userName: nationalId,
                  phoneNumber: mobile,
                  email: nationalId + "@refah.ir",
                  status: "people",
                );

                var userResult = await ProfileService().register(user);

                if (userResult != null) {
                  var resLogin = await ProfileService().CheckUser(
                    nationalId,
                    mobile,
                  );

                  if (resLogin != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Splash1(),
                      ),
                    );
                  }
                }
              }

              if (res != null && res.status == "admin") {
                signalR.setConnection(nationalId);
                if (widget.userType == "partner") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorChoosePage(),
                    ),
                  );
                } else if (widget.userType == "people") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Splash1(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminPanelPage(),
                    ),
                  );
                }
              } else if (res != null && res.status == "partner") {
                if (widget.userType == "people") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Splash1(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorChoosePage(),
                    ),
                  );
                }
              } else if (res != null && res.status == "people") {
                UserVM user = UserVM(
                  age: 30,
                  fullname: "no name",
                  nationalId: nationalId,
                  userName: nationalId,
                  phoneNumber: mobile,
                  email: nationalId + "@refah.ir",
                  status: "people",
                );

                var userResult = await ProfileService().register(user);

                if (userResult != null) {
                  var resLogin = await ProfileService().CheckUser(
                    nationalId,
                    mobile,
                  );

                  if (resLogin != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Splash1(),
                      ),
                    );
                  }
                }
              }
              setState(() {
                vis = false;
              });
            },
            route: null,
            width: 250.0,
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text(
              "dev. by dejavu developers",
              style: TextStyle(fontSize: 10.0),
            ),
          ),
        ],
      ),
    );
  }
}
