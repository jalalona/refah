import 'package:refah/models/OrderVM.dart';
import 'package:refah/models/UserCommentVM.dart';
import 'package:refah/models/UserSampleVM.dart';

import 'UserMessageVM.dart';

class UserMicroVM {
  String fullname;
  int age;
  String gender;
  String avatar;
  bool isActive;
  int priority;
  int important;
  String status;
  String systemTag;
  String systemCategory;
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
  int motherId;
  int fatherId;
  String officeName;
  String bio;
  int representerId;
  String userName;
  String email;
  String phoneNumber;

  UserMicroVM({
    this.fullname,
    this.age = 30,
    this.gender = "MALE",
    this.avatar,
    this.isActive,
    this.priority = 0,
    this.important = 0,
    this.status,
    this.systemTag,
    this.systemCategory,
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
    this.motherId = 0,
    this.fatherId = 0,
    this.officeName,
    this.bio,
    this.representerId = 0,
    this.userName,
    this.email,
    this.phoneNumber,
  });

  UserMicroVM.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    age = json['age'];
    gender = json['gender'];
    avatar = json['avatar'];
    isActive = json['isActive'];
    priority = json['priority'];
    important = json['important'];
    status = json['status'];
    systemTag = json['systemTag'];
    systemCategory = json['systemCategory'];
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
    motherId = json['motherId'];
    fatherId = json['fatherId'];
    officeName = json['officeName'];
    bio = json['bio'];
    representerId = json['representerId'];
    userName = json['userName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['avatar'] = this.avatar;
    data['isActive'] = this.isActive;
    data['priority'] = this.priority;
    data['important'] = this.important;
    data['status'] = this.status;
    data['systemTag'] = this.systemTag;
    data['systemCategory'] = this.systemCategory;
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
    data['motherId'] = this.motherId;
    data['fatherId'] = this.fatherId;
    data['officeName'] = this.officeName;
    data['bio'] = this.bio;
    data['representerId'] = this.representerId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }

  List<UserMicroVM> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<UserMicroVM>((ct) {
        return UserMicroVM.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
