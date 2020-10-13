class ZarrinPalVerifyResponseModel {
  ZPVData data;
  List<dynamic> errors;

  ZarrinPalVerifyResponseModel({
    this.data,
    this.errors,
  });

  ZarrinPalVerifyResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      this.data = ZPVData.fromJson(json["data"]);
    }
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) data['data'] = this.data.toJson();
    if (this.errors != null) data['errors'] = this.errors;
    return data;
  }

  List<ZarrinPalVerifyResponseModel> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<ZarrinPalVerifyResponseModel>((ct) {
        return ZarrinPalVerifyResponseModel.fromJson(ct);
      }).toList();
    }

    return null;
  }
}

class ZPVData {
  int code;
  String message;
  String card_hash;
  String card_pan;
  int ref_id;
  String fee_type;
  int fee;

  ZPVData({
    this.card_hash,
    this.card_pan,
    this.code,
    this.fee,
    this.fee_type,
    this.message,
    this.ref_id,
  });

  ZPVData.fromJson(Map<String, dynamic> json) {
    this.card_hash = json["card_hash"];
    this.card_pan = json["card_pan"];
    this.code = json["code"];
    this.fee = json["fee"];
    this.fee_type = json["fee_type"];
    this.message = json["message"];
    this.ref_id = json["ref_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.card_hash != null) data["card_hash"] = this.card_hash;
    if (this.card_pan != null) data["card_pan"] = this.card_pan;
    if (this.code != null) data["code"] = this.code;
    if (this.fee != null) data["fee"] = this.fee;
    if (this.fee_type != null) data["fee_type"] = this.fee_type;
    if (this.message != null) data["message"] = this.message;
    if (this.ref_id != null) data["ref_id"] = this.ref_id;
    return data;
  }

  List<ZPVData> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<ZPVData>((ct) {
        return ZPVData.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
