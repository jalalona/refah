class OptionVM {
  String title;
  String name;
  String type;
  String value;
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

  OptionVM(
      {this.title,
      this.name,
      this.type,
      this.value,
      this.id = 0,
      this.deleted = false,
      this.isActive = true,
      this.creationDateTime,
      this.creationDay,
      this.creationPersianDateTime,
      this.modifiedDateTime,
      this.modifiedDay,
      this.modifiedPersianDateTime,
      this.deletedDateTime,
      this.deletedDay,
      this.deletedPersianDateTime,
      this.priority = 0,
      this.important = 0,
      this.status,
      this.userCreatedId = 0,
      this.systemTag,
      this.systemCategory});

  OptionVM.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    name = json['name'];
    type = json['type'];
    value = json['value'];
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
    if (this.title != null) data['title'] = this.title;
    if (this.name != null) data['name'] = this.name;
    if (this.type != null) data['type'] = this.type;
    if (this.value != null) data['value'] = this.value;
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
    return data;
  }

  List<OptionVM> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<OptionVM>((ct) {
        return OptionVM.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
