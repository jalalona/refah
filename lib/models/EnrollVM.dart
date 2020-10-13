import 'package:refah/models/EnrollOrderVM.dart';

class EnrollVM {
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
  List<EnrollOrderVM> enrollOrders;
  int id;
  bool deleted;
  bool isActive;
  DateTime creationDateTime;
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
  DateTime startTime;
  DateTime expireTime;

  EnrollVM({
    this.fullname,
    this.age,
    this.gender,
    this.avatar,
    this.homePhone,
    this.nationalId,
    this.identityNumber,
    this.birthday,
    this.fatherName,
    this.tall,
    this.weight,
    this.address,
    this.irBank,
    this.identityCard,
    this.nationalCard,
    this.insuranceCard,
    this.enrollType,
    this.enrollOrders,
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
    this.startTime,
    this.expireTime,
  });

  EnrollVM.fromJson(Map<String, dynamic> json) {
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
      enrollOrders = new List<EnrollOrderVM>();
      json['enrollOrders'].forEach((v) {
        enrollOrders.add(new EnrollOrderVM.fromJson(v));
      });
    }
    id = json['id'];
    deleted = json['deleted'];
    isActive = json['isActive'];
    creationDateTime = DateTime.parse(json['creationDateTime']);
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
    startTime = DateTime.parse(json["startTime"]);
    expireTime = DateTime.parse(json["expireTime"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fullname != null) data['fullname'] = this.fullname;
    if (this.age != null) data['age'] = this.age;
    if (this.gender != null) data['gender'] = this.gender;
    if (this.avatar != null) data['avatar'] = this.avatar;
    if (this.homePhone != null) data['homePhone'] = this.homePhone;
    if (this.nationalId != null) data['nationalId'] = this.nationalId;
    if (this.identityNumber != null)
      data['identityNumber'] = this.identityNumber;
    if (this.birthday != null) data['birthday'] = this.birthday;
    if (this.fatherName != null) data['fatherName'] = this.fatherName;
    if (this.tall != null) data['tall'] = this.tall;
    if (this.weight != null) data['weight'] = this.weight;
    if (this.address != null) data['address'] = this.address;
    if (this.irBank != null) data['irBank'] = this.irBank;
    if (this.identityCard != null) data['identityCard'] = this.identityCard;
    if (this.nationalCard != null) data['nationalCard'] = this.nationalCard;
    if (this.insuranceCard != null) data['insuranceCard'] = this.insuranceCard;
    if (this.enrollType != null) data['enrollType'] = this.enrollType;
    if (this.enrollOrders != null) {
      data['enrollOrders'] = this.enrollOrders.map((v) => v.toJson()).toList();
    }
    if (this.id != null) data['id'] = this.id;
    if (this.deleted != null) data['deleted'] = this.deleted;
    if (this.isActive != null) data['isActive'] = this.isActive;
    if (this.creationDateTime != null)
      data['creationDateTime'] =
          this.creationDateTime.toString().replaceAll(RegExp(r' '), "T");
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
    if (this.startTime != null)
      data["startTime"] =
          this.startTime.toUtc().toString().replaceAll(RegExp(r' '), "T");
    if (this.expireTime != null)
      data["expireTime"] =
          this.expireTime.toUtc().toString().replaceAll(RegExp(r' '), "T");
    return data;
  }

  List<EnrollVM> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<EnrollVM>((ct) {
        return EnrollVM.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
