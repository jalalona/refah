import 'dart:async';

// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:refah/api/ProfileService.dart';
import 'package:refah/main.dart';
import 'package:refah/models/ChatMessage.dart';
import 'package:refah/models/SignalRMessage.dart';
import 'package:signalr_core/signalr_core.dart';

class SignalR with ChangeNotifier {
  final serverUrl = "https://realtime.digisahra.ir/chathub";
  static HubConnection connection;
  static FlutterLocalNotificationsPlugin flp;
  //static List<SignalRMessage> messages = List<SignalRMessage>();
  Timer timer;

  static Function(dynamic result) onMessageRecivedCallback;
  static Function(dynamic result) onSignalRConnectedCallback;
  static Function(dynamic result) onSignalRDisConnectedCallback;

  SignalR(BuildContext context) {
    connection = HubConnectionBuilder()
        .withUrl(
          serverUrl,
          HttpConnectionOptions(
            logging: (level, message) => print(message),
          ),
        )
        .build();

    // AwesomeNotifications().initialize('resource://drawable/app_icon', [
    //   NotificationChannel(
    //     channelKey: 'basic_channel',
    //     channelName: 'رفاه اندیشان',
    //     channelDescription: 'سیستم پیام رسان راه اندیشان',
    //     defaultColor: Colors.greenAccent,
    //     ledColor: Colors.white,
    //   )
    // ]);
  }

  Future init() async {
    connection.on('ReceiveMessage', (message) {
      ChatMessage msg = ChatMessage.fromJson(message[1]);
      _showNotification(msg.id, msg.senderName, msg.message);
    });

    connection.on('ReceiveLiveMessage', (message) {});

    connection.on("ReceiveConnectedMessage", (arguments) async {
      await setConnection(ProfileService().getUserData().nationalId);
    });

    connection.on("ReceiveDisconnectedMessage", (arguments) {
      onSignalRDisConnectedCallback("");
    });

    await connection.start();

    timer = Timer.periodic(Duration(seconds: 15), (Timer t) async {
      try {
        if (connection.state == HubConnectionState.connected) {
          connection.invoke(
            "StayLiveMessage",
            args: [
              "refah",
              ProfileService().getUserData().nationalId + " i am alive",
            ],
          );
        } else {
          await connection.start();
          await setConnection(ProfileService().getUserData().nationalId);
          init();
        }
      } catch (ex) {}
    });
  }

  void setOnMessageRecivedCallback(Function(dynamic result) func) {
    onMessageRecivedCallback = func;
  }

  void setOnConnectedCallback(Function(dynamic result) func) {
    onSignalRConnectedCallback = func;
  }

  void setOnDisconnectCallback(Function(dynamic result) func) {
    onSignalRDisConnectedCallback = func;
  }

  Future setConnection(String nid) async {
    var sts = connection.state;
    if (connection.state == HubConnectionState.connected) {
      var result = await connection
          .invoke('Init', args: ['refah', nid, connection.connectionId]);
      print(result);
    } else {
      init();
    }
  }

  Future sendRecivedMessage(String user, int identity) {
    if (connection.state == HubConnectionState.connected) {
      connection.invoke(
        "SendRecivedMessage",
        args: [
          "refah",
          user,
          identity,
        ],
      );
    }
  }

  void sendMessage(String target, int identity, ChatMessage message) async {
    var msg = SignalRMessage(
      sentTime: DateTime.now(),
      identity: identity,
      message: message,
      user: target,
    );

    await connection.invoke('SendMessageToClient', args: [
      'refah',
      ProfileService().getUserData().userName,
      target,
      identity,
      message
    ]);
    // messages.add(
    //   SignalRMessage(
    //     sentTime: DateTime.now(),
    //     identity: identity,
    //     message: message,
    //     user: target,
    //   ),
    // );

    // syncMessages();
  }

  void setNotificationObject(FlutterLocalNotificationsPlugin _flp) {
    flp = _flp;
  }

  FlutterLocalNotificationsPlugin getNotificationObject() {
    return flp;
  }

  // Future syncMessages() {
  //   if (messages.length > 0) {
  //     messages.forEach((element) async {
  //       if (connection.state == HubConnectionState.connected) {
  //         await connection.invoke('SendMessageToClient', args: [
  //           'refah',
  //           ProfileService().getUserData().userName,
  //           element.user,
  //           element.identity,
  //           element.message
  //         ]);
  //       } else {
  //         await connection.start();
  //         await connection.invoke('Init', args: [
  //           'refah',
  //           ProfileService().getUserData().userName,
  //           connection.connectionId
  //         ]);
  //         await connection.invoke('SendMessageToClient', args: [
  //           'refah',
  //           ProfileService().getUserData().userName,
  //           element.user,
  //           element.identity,
  //           element.message,
  //         ]);
  //       }
  //     });
  //   }
  // }

  Future<void> _showNotification(
      int _id, String _title, String _message) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '111', 'refah', 'رفاه اندیشان',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        _id, _title, _message, platformChannelSpecifics,
        payload: 'item x');
  }
}
