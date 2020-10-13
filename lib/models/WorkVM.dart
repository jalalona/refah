class WorkVM {
  String phone;
  String message;
  int id;

  WorkVM({
    this.id,
    this.message,
    this.phone,
  });

  WorkVM.fromJson(Map<String, dynamic> json) {
    if (json["id"] != null) id = json['id'];
    phone = json['phone'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) data['id'] = this.id;
    data['message'] = this.message;
    data['phone'] = this.phone;

    return data;
  }

  List<WorkVM> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<WorkVM>((ct) {
        return WorkVM.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
