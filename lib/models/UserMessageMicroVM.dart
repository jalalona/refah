class UserMessageMicroVM {
  int userId;
  String message;
  int parentId;
  int id;
  int important;
  String status;
  int userCreatedId;
  String systemTag;
  String systemCategory;

  UserMessageMicroVM({
    this.userId = 0,
    this.message,
    this.parentId = 0,
    this.id = 0,
    this.important = 0,
    this.status,
    this.userCreatedId = 0,
    this.systemTag,
    this.systemCategory,
  });

  UserMessageMicroVM.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    message = json['message'];
    parentId = json['parentId'];
    id = json['id'];
    important = json['important'];
    status = json['status'];
    userCreatedId = json['userCreatedId'];
    systemTag = json['systemTag'];
    systemCategory = json['systemCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userId != null) data['userId'] = this.userId;
    if (this.message != null) data['message'] = this.message;
    if (this.parentId != null) data['parentId'] = this.parentId;
    if (this.id != null) data['id'] = this.id;
    if (this.important != null) data['important'] = this.important;
    if (this.status != null) data['status'] = this.status;
    if (this.userCreatedId != null) data['userCreatedId'] = this.userCreatedId;
    if (this.systemTag != null) data['systemTag'] = this.systemTag;
    if (this.systemCategory != null)
      data['systemCategory'] = this.systemCategory;
    return data;
  }

  List<UserMessageMicroVM> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<UserMessageMicroVM>((ct) {
        return UserMessageMicroVM.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
