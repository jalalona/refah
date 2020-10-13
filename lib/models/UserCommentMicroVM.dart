class UserCommentMicroVM {
  int userId;
  int rate;
  String description;
  int id;
  int priority;
  int important;
  String status;
  int userCreatedId;
  String systemTag;
  String systemCategory;

  UserCommentMicroVM({
    this.userId = 0,
    this.rate = 0,
    this.description,
    this.id = 0,
    this.priority = 0,
    this.important = 0,
    this.status,
    this.userCreatedId = 0,
    this.systemTag,
    this.systemCategory,
  });

  UserCommentMicroVM.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    rate = json['rate'];
    description = json['description'];
    id = json['id'];
    priority = json['priority'];
    important = json['important'];
    status = json['status'];
    userCreatedId = json['userCreatedId'];
    systemTag = json['systemTag'];
    systemCategory = json['systemCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userId != null) data['userId'] = this.userId;
    if (this.rate != null) data['rate'] = this.rate;
    if (this.description != null) data['description'] = this.description;
    if (this.id != null) data['id'] = this.id;
    if (this.priority != null) data['priority'] = this.priority;
    if (this.important != null) data['important'] = this.important;
    if (this.status != null) data['status'] = this.status;
    if (this.userCreatedId != null) data['userCreatedId'] = this.userCreatedId;
    if (this.systemTag != null) data['systemTag'] = this.systemTag;
    if (this.systemCategory != null)
      data['systemCategory'] = this.systemCategory;
    return data;
  }

  List<UserCommentMicroVM> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<UserCommentMicroVM>((ct) {
        return UserCommentMicroVM.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
