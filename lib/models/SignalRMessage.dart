import 'package:refah/models/ChatMessage.dart';

class SignalRMessage {
  int identity;
  String user;
  ChatMessage message;
  DateTime sentTime;
  DateTime recivedTime;
  DateTime seenTime;

  SignalRMessage({
    this.identity,
    this.message,
    this.recivedTime,
    this.seenTime,
    this.sentTime,
    this.user,
  });
}
