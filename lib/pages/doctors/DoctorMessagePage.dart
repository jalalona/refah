import 'dart:io';

import 'package:flutter/material.dart';
import 'package:refah/Provider/SignalR.dart';
import 'package:refah/api/ProfileService.dart';
import 'package:refah/models/ChatMessage.dart';
import 'package:refah/models/UserMessageMicroVM.dart';
import 'package:refah/models/UserMessageVM.dart';
import 'package:refah/models/UserVM.dart';
import 'package:refah/services/UserMessageService.dart';
import 'package:refah/widgets/WDG_BorderedTextInput.dart';
import 'package:refah/widgets/WDG_ChatPanelItem.dart';
import 'package:refah/widgets/WDG_SendCommentIcon.dart';

class DoctorMessagePage extends StatefulWidget {
  String title;
  String description;
  UserVM user;

  Widget content;

  DoctorMessagePage({
    this.description,
    this.title,
    this.user,
  });

  @override
  _DoctorMessagePageState createState() => _DoctorMessagePageState();
}

class _DoctorMessagePageState extends State<DoctorMessagePage> {
  SignalR signalr;
  bool vis = false;
  String message;
  List<Widget> chats = [Text("بدون هیچ متنی")];

  Future<List<UserMessageVM>> setupMessages() async {
    setState(() {
      vis = true;
    });
    var res = await UserMessageService().getUserMessages(
      widget.user.id,
    );

    if (res != null && res.length > 0) {
      setState(() {
        chats = res
            .map(
              (e) => WDG_ChatPanelItem(
                client: widget.user,
                obj: e,
                me: ProfileService().getUserData(),
              ),
            )
            .toList();
      });
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

    return false;
  }

  @override
  void initState() {
    super.initState();

    signalr = SignalR(context);

    signalr.setOnMessageRecivedCallback((result) async {
      await setupMessages();
      setState(() {});
    });

    setupMessages();
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
                fit: FlexFit.tight,
                child: Container(
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
                  child: Column(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: ListView(
                          children: chats,
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Flexible(
                              child: WDG_BorderedTextInput(
                                value: message ?? "",
                                hintText: "متن پیام",
                                onChangeCallback: (result) {
                                  message = result;
                                },
                              ),
                            ),
                            WDG_SendCommentIcon(
                              onTapCallback: (result) async {
                                setState(() {
                                  vis = true;
                                });
                                var result = await UserMessageService().add(
                                  UserMessageMicroVM(
                                    userCreatedId:
                                        ProfileService().getUserData().id,
                                    userId: widget.user.id,
                                    message: message,
                                  ),
                                );

                                if (result != null) {
                                  signalr.sendMessage(
                                    widget.user.nationalId,
                                    result.id,
                                    ChatMessage(
                                      senderAvatar:
                                          ProfileService().getUserData().avatar,
                                      senderName: ProfileService()
                                          .getUserData()
                                          .fullname,
                                      message: message,
                                      id: result.id,
                                    ),
                                  );

                                  setupMessages();
                                  setState(() {
                                    message = "";
                                  });
                                }
                                setState(() {
                                  vis = false;
                                });
                              },
                            )
                          ],
                        ),
                      )
                    ],
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
