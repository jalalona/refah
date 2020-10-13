class EnrollOrderMicroVM {
  int enrollId;
  int orderId;
  int id;
  int priority;
  int important;
  String status;
  int userCreatedId;
  String systemTag;
  String systemCategory;
  String authorize;
  String refId;

  EnrollOrderMicroVM({
    this.enrollId,
    this.orderId,
    this.id,
    this.priority,
    this.important,
    this.status,
    this.userCreatedId,
    this.systemTag,
    this.systemCategory,
    this.authorize,
    this.refId,
  });

  EnrollOrderMicroVM.fromJson(Map<String, dynamic> json) {
    enrollId = json['enrollId'];
    orderId = json['orderId'];
    id = json['id'];
    priority = json['priority'];
    important = json['important'];
    status = json['status'];
    userCreatedId = json['userCreatedId'];
    systemTag = json['systemTag'];
    systemCategory = json['systemCategory'];
    authorize = json["authorize"];
    refId = json["refId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enrollId'] = this.enrollId;
    data['orderId'] = this.orderId;
    data['id'] = this.id;
    data['priority'] = this.priority;
    data['important'] = this.important;
    data['status'] = this.status;
    data['userCreatedId'] = this.userCreatedId;
    data['systemTag'] = this.systemTag;
    data['systemCategory'] = this.systemCategory;
    data["refId"] = this.refId;
    data["authorize"] = this.authorize;
    return data;
  }

  List<EnrollOrderMicroVM> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<EnrollOrderMicroVM>((ct) {
        return EnrollOrderMicroVM.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
