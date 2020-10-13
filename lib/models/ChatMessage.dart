class ChatMessage {
  String senderName;
  String senderAvatar;
  String message;
  String type;
  int id;

  ChatMessage({
    this.message,
    this.senderAvatar,
    this.senderName,
    this.type,
    this.id,
  });

  ChatMessage.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    senderAvatar = json['senderAvatar'];
    senderName = json['senderName'];
    type = json['type'];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['senderAvatar'] = this.senderAvatar;
    data['senderName'] = this.senderName;
    data['type'] = this.type;
    data["id"] = this.id;
    return data;
  }

  List<ChatMessage> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<ChatMessage>((ct) {
        return ChatMessage.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
