import 'package:refah/models/EnrollOrderVM.dart';

class OrderVM {
  int userId;
  String orderCode;
  int totalPayment;
  String transactionCode;
  String authority;
  String refId;
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

  OrderVM(
      {this.userId,
      this.orderCode,
      this.totalPayment,
      this.transactionCode,
      this.authority,
      this.refId,
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
      this.systemCategory});

  OrderVM.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    orderCode = json['orderCode'];
    totalPayment = json['totalPayment'];
    transactionCode = json['transactionCode'];
    authority = json['authority'];
    refId = json['refId'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userId != null) data['userId'] = this.userId;
    if (this.orderCode != null) data['orderCode'] = this.orderCode;
    if (this.totalPayment != null) data['totalPayment'] = this.totalPayment;
    if (this.transactionCode != null)
      data['transactionCode'] = this.transactionCode;
    if (this.authority != null) data['authority'] = this.authority;
    if (this.refId != null) data['refId'] = this.refId;
    if (this.enrollOrders != null) if (this.enrollOrders != null) {
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
    return data;
  }

  List<OrderVM> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<OrderVM>((ct) {
        return OrderVM.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
