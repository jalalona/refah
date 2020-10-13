class EnrollOrderVM {
  int enrollId;
  int orderId;
  int id;
  bool deleted;
  bool isActive;
  String creationDateTime;
  String creationDay;
  String creationPersianDateTime;
  String modifiedDateTime;
  String modifiedDay;
  String modifiedPersianDateTime;
  String deletedDateTime;
  String deletedDay;
  String deletedPersianDateTime;
  int priority;
  int important;
  String status;
  int userCreatedId;
  String systemTag;
  String systemCategory;
  String authorize;
  String refId;

  EnrollOrderVM({
    this.enrollId,
    this.orderId,
    this.id,
    this.deleted,
    this.isActive,
    this.creationDateTime,
    this.creationDay,
    this.creationPersianDateTime,
    this.modifiedDateTime,
    this.modifiedDay,
    this.modifiedPersianDateTime,
    this.deletedDateTime,
    this.deletedDay,
    this.deletedPersianDateTime,
    this.priority,
    this.important,
    this.status,
    this.userCreatedId,
    this.systemTag,
    this.systemCategory,
    this.refId,
    this.authorize,
  });

  EnrollOrderVM.fromJson(Map<String, dynamic> json) {
    enrollId = json['enrollId'];
    orderId = json['orderId'];
    id = json['id'];
    deleted = json['deleted'];
    isActive = json['isActive'];
    creationDateTime = json['creationDateTime'];
    creationDay = json['creationDay'];
    creationPersianDateTime = json['creationPersianDateTime'];
    modifiedDateTime = json['modifiedDateTime'];
    modifiedDay = json['modifiedDay'];
    modifiedPersianDateTime = json['modifiedPersianDateTime'];
    deletedDateTime = json['deletedDateTime'];
    deletedDay = json['deletedDay'];
    deletedPersianDateTime = json['deletedPersianDateTime'];
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
    if (this.enrollId != null) data['enrollId'] = this.enrollId;
    if (this.orderId != null) data['orderId'] = this.orderId;
    if (this.id != null) data['id'] = this.id;
    if (this.deleted != null) data['deleted'] = this.deleted;
    if (this.isActive != null) data['isActive'] = this.isActive;
    if (this.creationDateTime != null)
      data['creationDateTime'] = this.creationDateTime;
    if (this.creationDay != null) data['creationDay'] = this.creationDay;
    if (this.creationPersianDateTime != null)
      data['creationPersianDateTime'] = this.creationPersianDateTime;
    if (this.modifiedDateTime != null)
      data['modifiedDateTime'] = this.modifiedDateTime;
    if (this.modifiedDay != null) data['modifiedDay'] = this.modifiedDay;
    if (this.modifiedPersianDateTime != null)
      data['modifiedPersianDateTime'] = this.modifiedPersianDateTime;
    if (this.deletedDateTime != null)
      data['deletedDateTime'] = this.deletedDateTime;
    if (this.deletedDay != null) data['deletedDay'] = this.deletedDay;
    if (this.deletedPersianDateTime != null)
      data['deletedPersianDateTime'] = this.deletedPersianDateTime;
    if (this.priority != null) data['priority'] = this.priority;
    if (this.important != null) data['important'] = this.important;
    if (this.status != null) data['status'] = this.status;
    if (this.userCreatedId != null) data['userCreatedId'] = this.userCreatedId;
    if (this.systemTag != null) data['systemTag'] = this.systemTag;
    if (this.systemCategory != null)
      data['systemCategory'] = this.systemCategory;
    if (this.authorize != null) data["authorize"] = this.authorize;
    if (this.refId != null) data["refId"] = this.refId;
    return data;
  }

  List<EnrollOrderVM> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<EnrollOrderVM>((ct) {
        return EnrollOrderVM.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
