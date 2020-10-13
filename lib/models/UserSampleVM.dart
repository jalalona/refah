class UserSampleVM {
  int userId;
  String filePath;
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

  UserSampleVM(
      {this.userId,
      this.filePath,
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
      this.systemCategory});

  UserSampleVM.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    filePath = json['filePath'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['filePath'] = this.filePath;
    data['id'] = this.id;
    data['deleted'] = this.deleted;
    data['isActive'] = this.isActive;
    data['creationDateTime'] = this.creationDateTime;
    data['creationDay'] = this.creationDay;
    data['creationPersianDateTime'] = this.creationPersianDateTime;
    data['modifiedDateTime'] = this.modifiedDateTime;
    data['modifiedDay'] = this.modifiedDay;
    data['modifiedPersianDateTime'] = this.modifiedPersianDateTime;
    data['deletedDateTime'] = this.deletedDateTime;
    data['deletedDay'] = this.deletedDay;
    data['deletedPersianDateTime'] = this.deletedPersianDateTime;
    data['priority'] = this.priority;
    data['important'] = this.important;
    data['status'] = this.status;
    data['userCreatedId'] = this.userCreatedId;
    data['systemTag'] = this.systemTag;
    data['systemCategory'] = this.systemCategory;
    return data;
  }

  List<UserSampleVM> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<UserSampleVM>((ct) {
        return UserSampleVM.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
