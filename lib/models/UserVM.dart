import 'package:refah/models/OrderVM.dart';
import 'package:refah/models/UserCommentVM.dart';
import 'package:refah/models/UserSampleVM.dart';

import 'UserMessageVM.dart';

class UserVM {
  String fullname;
  int age;
  String gender;
  String avatar;
  String lastLoginDate;
  bool isActive;
  bool deleted;
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
  List<UserMessageVM> messages;
  List<UserCommentVM> comments;
  List<OrderVM> orders;
  List<UserSampleVM> samples;
  int id;
  String userName;
  String normalizedUserName;
  String email;
  String normalizedEmail;
  bool emailConfirmed;
  String passwordHash;
  String securityStamp;
  String concurrencyStamp;
  String phoneNumber;
  bool phoneNumberConfirmed;
  bool twoFactorEnabled;
  String lockoutEnd;
  bool lockoutEnabled;
  int accessFailedCount;

  UserVM(
      {this.fullname,
      this.age,
      this.gender,
      this.avatar,
      this.lastLoginDate,
      this.isActive,
      this.deleted,
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
      this.motherId,
      this.fatherId,
      this.officeName,
      this.bio,
      this.representerId,
      this.messages,
      this.comments,
      this.orders,
      this.samples,
      this.id,
      this.userName,
      this.normalizedUserName,
      this.email,
      this.normalizedEmail,
      this.emailConfirmed,
      this.passwordHash,
      this.securityStamp,
      this.concurrencyStamp,
      this.phoneNumber,
      this.phoneNumberConfirmed,
      this.twoFactorEnabled,
      this.lockoutEnd,
      this.lockoutEnabled,
      this.accessFailedCount});

  UserVM.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return;
    }

    fullname = json['fullname'];
    age = json['age'];
    gender = json['gender'];
    avatar = json['avatar'];
    lastLoginDate = json['lastLoginDate'];
    isActive = json['isActive'];
    deleted = json['deleted'];
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
    if (json['messages'] != null) {
      messages = new List<UserMessageVM>();
      json['messages'].forEach((v) {
        messages.add(new UserMessageVM.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = new List<UserCommentVM>();
      json['comments'].forEach((v) {
        comments.add(new UserCommentVM.fromJson(v));
      });
    }
    if (json['orders'] != null) {
      orders = new List<OrderVM>();
      json['orders'].forEach((v) {
        orders.add(new OrderVM.fromJson(v));
      });
    }
    if (json['samples'] != null) {
      samples = new List<UserSampleVM>();
      json['samples'].forEach((v) {
        samples.add(new UserSampleVM.fromJson(v));
      });
    }
    id = json['id'];
    userName = json['userName'];
    normalizedUserName = json['normalizedUserName'];
    email = json['email'];
    normalizedEmail = json['normalizedEmail'];
    emailConfirmed = json['emailConfirmed'];
    passwordHash = json['passwordHash'];
    securityStamp = json['securityStamp'];
    concurrencyStamp = json['concurrencyStamp'];
    phoneNumber = json['phoneNumber'];
    phoneNumberConfirmed = json['phoneNumberConfirmed'];
    twoFactorEnabled = json['twoFactorEnabled'];
    lockoutEnd = json['lockoutEnd'];
    lockoutEnabled = json['lockoutEnabled'];
    accessFailedCount = json['accessFailedCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fullname != null) data['fullname'] = this.fullname;
    if (this.age != null) data['age'] = this.age;
    if (this.gender != null) data['gender'] = this.gender;
    if (this.avatar != null) data['avatar'] = this.avatar;
    if (this.lastLoginDate != null) data['lastLoginDate'] = this.lastLoginDate;
    if (this.isActive != null) data['isActive'] = this.isActive;
    if (this.deleted != null) data['deleted'] = this.deleted;
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
    if (this.motherId != null) data['motherId'] = this.motherId;
    if (this.fatherId != null) data['fatherId'] = this.fatherId;
    if (this.officeName != null) data['officeName'] = this.officeName;
    if (this.bio != null) data['bio'] = this.bio;
    if (this.representerId != null) data['representerId'] = this.representerId;
    if (this.messages != null) {
      data['messages'] = this.messages.map((v) => v.toJson()).toList();
    }
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    if (this.samples != null) {
      data['samples'] = this.samples.map((v) => v.toJson()).toList();
    }
    if (this.id != null) data['id'] = this.id;
    if (this.userName != null) data['userName'] = this.userName;
    if (this.normalizedUserName != null)
      data['normalizedUserName'] = this.normalizedUserName;
    if (this.email != null) data['email'] = this.email;
    if (this.normalizedEmail != null)
      data['normalizedEmail'] = this.normalizedEmail;
    if (this.emailConfirmed != null)
      data['emailConfirmed'] = this.emailConfirmed;
    if (this.passwordHash != null) data['passwordHash'] = this.passwordHash;
    if (this.securityStamp != null) data['securityStamp'] = this.securityStamp;
    if (this.concurrencyStamp != null)
      data['concurrencyStamp'] = this.concurrencyStamp;
    if (this.phoneNumber != null) data['phoneNumber'] = this.phoneNumber;
    if (this.phoneNumberConfirmed != null)
      data['phoneNumberConfirmed'] = this.phoneNumberConfirmed;
    if (this.twoFactorEnabled != null)
      data['twoFactorEnabled'] = this.twoFactorEnabled;
    if (this.lockoutEnd != null) data['lockoutEnd'] = this.lockoutEnd;
    if (this.lockoutEnabled != null)
      data['lockoutEnabled'] = this.lockoutEnabled;
    if (this.accessFailedCount != null)
      data['accessFailedCount'] = this.accessFailedCount;
    return data;
  }

  List<UserVM> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<UserVM>((ct) {
        return UserVM.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
