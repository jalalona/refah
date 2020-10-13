import 'package:refah/models/EnrollOrderVM.dart';

import 'EnrollOrderMicroVM.dart';

class EnrollMicroVM {
  String fullname;
  int age;
  String gender;
  String avatar;
  String homePhone;
  String nationalId;
  String identityNumber;
  String birthday;
  String fatherName;
  int tall;
  int weight;
  String address;
  String irBank;
  String identityCard;
  String nationalCard;
  String insuranceCard;
  String enrollType;
  List<EnrollOrderMicroVM> enrollOrders;
  int id;
  int priority;
  int important;
  String status;
  String systemTag;
  String systemCategory;
  DateTime startTime;
  DateTime expireTime;

  EnrollMicroVM({
    this.fullname,
    this.age = 30,
    this.gender,
    this.avatar,
    this.homePhone,
    this.nationalId,
    this.identityNumber,
    this.birthday,
    this.fatherName,
    this.tall = 0,
    this.weight = 0,
    this.address,
    this.irBank,
    this.identityCard,
    this.nationalCard,
    this.insuranceCard,
    this.enrollType,
    this.enrollOrders,
    this.id = 0,
    this.priority = 0,
    this.important = 0,
    this.status,
    this.systemTag,
    this.systemCategory,
    this.startTime,
    this.expireTime,
  });

  EnrollMicroVM.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    age = json['age'];
    gender = json['gender'];
    avatar = json['avatar'];
    homePhone = json['homePhone'];
    nationalId = json['nationalId'];
    identityNumber = json['identityNumber'];
    birthday = json['birthday'];
    fatherName = json['fatherName'];
    tall = json['tall'];
    weight = json['weight'];
    address = json['address'];
    irBank = json['irBank'];
    identityCard = json['identityCard'];
    nationalCard = json['nationalCard'];
    insuranceCard = json['insuranceCard'];
    enrollType = json['enrollType'];
    if (json['enrollOrders'] != null) {
      enrollOrders = new List<EnrollOrderMicroVM>();
      json['enrollOrders'].forEach((v) {
        enrollOrders.add(new EnrollOrderMicroVM.fromJson(v));
      });
    }
    id = json['id'];
    priority = json['priority'];
    important = json['important'];
    status = json['status'];
    systemTag = json['systemTag'];
    systemCategory = json['systemCategory'];
    startTime = DateTime.parse(json["startTime"]);
    expireTime = DateTime.parse(json["expireTime"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['avatar'] = this.avatar;
    data['homePhone'] = this.homePhone;
    data['nationalId'] = this.nationalId;
    data['identityNumber'] = this.identityNumber;
    data['birthday'] = this.birthday;
    data['fatherName'] = this.fatherName;
    data['tall'] = this.tall;
    data['weight'] = this.weight;
    data['address'] = this.address;
    data['irBank'] = this.irBank;
    data['identityCard'] = this.identityCard;
    data['nationalCard'] = this.nationalCard;
    data['insuranceCard'] = this.insuranceCard;
    data['enrollType'] = this.enrollType;
    if (this.enrollOrders != null) {
      data['enrollOrders'] = this.enrollOrders.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['priority'] = this.priority;
    data['important'] = this.important;
    data['status'] = this.status;
    data['systemTag'] = this.systemTag;
    data['systemCategory'] = this.systemCategory;
    data["startTime"] = this.startTime;
    data["expireTime"] = this.expireTime;
    return data;
  }

  List<EnrollMicroVM> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<EnrollMicroVM>((ct) {
        return EnrollMicroVM.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
