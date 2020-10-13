class ResponseVM {
  dynamic data;
  bool isSuccess;
  dynamic statusCode;
  String message;

  ResponseVM.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    isSuccess = json['isSuccess'];
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['isSuccess'] = this.isSuccess;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}
