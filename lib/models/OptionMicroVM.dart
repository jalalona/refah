class OptionMicroVM {
  int id;
  String title;
  String name;
  String type;
  String value;
  int priority;
  int important;
  String status;
  int userCreatedId;
  String systemTag;
  String systemCategory;

  OptionMicroVM(
      {this.id = 0,
      this.title,
      this.name,
      this.type,
      this.value,
      this.priority = 0,
      this.important = 0,
      this.status,
      this.userCreatedId = 0,
      this.systemTag,
      this.systemCategory});

  OptionMicroVM.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json['title'];
    name = json['name'];
    type = json['type'];
    value = json['value'];
    priority = json['priority'];
    important = json['important'];
    status = json['status'];
    userCreatedId = json['userCreatedId'];
    systemTag = json['systemTag'];
    systemCategory = json['systemCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data['title'] = this.title;
    data['name'] = this.name;
    data['type'] = this.type;
    data['value'] = this.value;
    data['priority'] = this.priority;
    data['important'] = this.important;
    data['status'] = this.status;
    data['userCreatedId'] = this.userCreatedId;
    data['systemTag'] = this.systemTag;
    data['systemCategory'] = this.systemCategory;
    return data;
  }

  List<OptionMicroVM> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<OptionMicroVM>((ct) {
        return OptionMicroVM.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
