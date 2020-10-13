import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:refah/api/EndPointService.dart';
import 'package:refah/api/ProfileService.dart';
import 'package:refah/models/EnrollVM.dart';
import 'package:refah/models/OrderVM.dart';
import 'package:refah/models/QueryModel.dart';
import 'package:refah/models/ResponseVM.dart';
import 'package:refah/models/ZarrinPalVerifyResponse.dart';
import 'package:refah/pages/admin/editation/AdminEnrollEditPage.dart';
import 'package:refah/widgets/WDG_BusinessEnrollItem.dart';
import 'package:refah/widgets/WDG_BusinessUserItem.dart';

class EnrollService with ChangeNotifier {
  static const String baseName = "Enroll";
  static List<EnrollVM> enrolls;
  static Function(dynamic result) refreshCallback;
  static EnrollVM myCredit;
  static int creditDay;
  static List<EnrollVM> myEnrolls;

  setMyEnroll(EnrollVM en) {
    if (myEnrolls == null) myEnrolls = List<EnrollVM>();
    myEnrolls.add(en);
  }

  List<EnrollVM> getMyEnrolls() {
    return myEnrolls ?? List<EnrollVM>();
  }

  deleteFromList(EnrollVM enl) {
    if (enl != null) {
      var idx = myEnrolls
          .indexWhere((element) => element.nationalId == enl.nationalId);

      if (idx >= 0) myEnrolls.removeAt(idx);
    }
  }

  clearMyEnrolls() {
    if (myEnrolls != null && myEnrolls.length > 0) {
      myEnrolls.clear();
    }
  }

  Future<EnrollVM> getMyActiveEnroll() async {
    ResponseVM json = await EndPointService().setupApi(
      baseName,
      "GetActiveDentistEnroll",
      [
        QueryModel(
          name: "nationalId",
          value: ProfileService().getUserData().nationalId,
        ),
      ],
    ).httpGet(
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (json.isSuccess == true && json.data != null) {
      myCredit = EnrollVM.fromJson(json.data);

      return myCredit;
    }

    return null;
  }

  Future<EnrollVM> getUserActiveEnroll(String nid) async {
    ResponseVM json = await EndPointService().setupApi(
      baseName,
      "GetActiveDentistEnroll",
      [
        QueryModel(
          name: "nationalId",
          value: nid,
        ),
      ],
    ).httpGet(
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (json.isSuccess == true) {
      var crt = EnrollVM.fromJson(json.data);

      return crt;
    }

    return null;
  }

  List<Widget> getEnrollWidgetList(BuildContext context) {
    if (enrolls != null) {
      return enrolls
          .map(
            (e) => WDG_BusinessEnrollItem(
              obj: e,
              editRoute: AdminEnrollEditPage(
                obj: e,
              ),
              editParam: e,
              editOnTapCallback: (result) {
                if (refreshCallback != null) {
                  refreshCallback(result);
                }
              },
              deleteOnTapCallback: (result) {
                var alert = AlertDialog(
                  title: Text(e.fullname),
                  content: Text(
                    "آیا از حذف این مورد مطمئن هستید؟",
                    style: TextStyle(
                      fontFamily: "IRANSans",
                    ),
                  ),
                  actions: [
                    FlatButton(
                      onPressed: () async {
                        var res = await EnrollService().delete(
                          e,
                        );
                        if (refreshCallback != null) {
                          refreshCallback(res);
                        }
                        Navigator.pop(context);
                      },
                      child: Text(
                        "بله",
                        style: TextStyle(
                          fontFamily: "IRANSans",
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "خیر",
                        style: TextStyle(
                          fontFamily: "IRANSans",
                        ),
                      ),
                    ),
                  ],
                );

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              },
            ),
          )
          .toList();
    }

    return List<Widget>();
  }

  List<Widget> getCustomEnrollWidgetList(
      BuildContext context, List<EnrollVM> _enrolls) {
    if (_enrolls != null) {
      return _enrolls
          .map(
            (e) => WDG_BusinessEnrollItem(
              obj: e,
              editRoute: AdminEnrollEditPage(
                obj: e,
              ),
              editParam: e,
              editOnTapCallback: (result) {
                if (refreshCallback != null) {
                  refreshCallback(result);
                }
              },
              deleteOnTapCallback: (result) {
                var alert = AlertDialog(
                  title: Text(e.fullname),
                  content: Text(
                    "آیا از حذف این مورد مطمئن هستید؟",
                    style: TextStyle(
                      fontFamily: "IRANSans",
                    ),
                  ),
                  actions: [
                    FlatButton(
                      onPressed: () async {
                        var res = await EnrollService().delete(
                          e,
                        );
                        if (refreshCallback != null) {
                          refreshCallback(res);
                        }
                        Navigator.pop(context);
                      },
                      child: Text(
                        "بله",
                        style: TextStyle(
                          fontFamily: "IRANSans",
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "خیر",
                        style: TextStyle(
                          fontFamily: "IRANSans",
                        ),
                      ),
                    ),
                  ],
                );

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              },
            ),
          )
          .toList();
    }

    return List<Widget>();
  }

  bool hasActiveEnroll() {
    return myCredit != null ? true : false;
  }

  String calculateCredit() {
    if (myCredit == null) return null;
    creditDay = myCredit.expireTime.difference(DateTime.now()).inDays;
    if (creditDay <= 0) return null;
    return creditDay.toString();
  }

  String calculateUserCredit(EnrollVM en) {
    if (en == null) return null;
    var cDay = en.expireTime.difference(DateTime.now()).inDays;
    if (cDay <= 0) return null;
    return cDay.toString();
  }

  Future getMyAllEnrolls() async {
    enrolls = await filter(
      EnrollVM(
        nationalId: ProfileService().getUserData().nationalId,
      ),
    );
  }

  setRefreshCallback(Function(dynamic result) func) {
    refreshCallback = func;
  }

  Future<List<EnrollVM>> init() async {
    ResponseVM json = await EndPointService().setupApi(
      baseName,
      "",
      [
        QueryModel(
          name: "total",
          value: "0",
        ),
        QueryModel(
          name: "more",
          value: "2147483647",
        ),
      ],
    ).httpGet(
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (json.isSuccess == true) {
      enrolls = EnrollVM().listFromJson(json.data);

      enrolls.sort((a, b) => b.id.compareTo(a.id));

      return enrolls;
    }

    return null;
  }

  Future<EnrollVM> getById(int id) async {
    EnrollVM opt = EnrollVM(id: id);

    var filter = jsonEncode(opt);

    ResponseVM json =
        await EndPointService().setupApi(baseName, "FilterRange", [
      QueryModel(
        name: "total",
        value: "0",
      ),
      QueryModel(
        name: "more",
        value: "2147483647",
      ),
    ]).httpPost(
      filter,
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (json.isSuccess == true) {
      enrolls = EnrollVM().listFromJson(json.data);

      if (enrolls != null && enrolls.length > 0) {
        return enrolls.first;
      }
    }

    return null;
  }

  Future<EnrollVM> getByNationalId(String nid) async {
    EnrollVM opt = EnrollVM(nationalId: nid);

    var filter = jsonEncode(opt);

    ResponseVM json =
        await EndPointService().setupApi(baseName, "FilterRange", [
      QueryModel(
        name: "total",
        value: "0",
      ),
      QueryModel(
        name: "more",
        value: "2147483647",
      ),
    ]).httpPost(
      filter,
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (json.isSuccess == true) {
      enrolls = EnrollVM().listFromJson(json.data);

      if (enrolls != null && enrolls.length > 0) {
        return enrolls.first;
      }
    }

    return null;
  }

  Future<List<EnrollVM>> filter(EnrollVM model) async {
    var filter = jsonEncode(model);

    ResponseVM json =
        await EndPointService().setupApi(baseName, "FilterRange", [
      QueryModel(
        name: "total",
        value: "0",
      ),
      QueryModel(
        name: "more",
        value: "2147483647",
      ),
    ]).httpPost(
      filter,
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (json.isSuccess == true) {
      enrolls = EnrollVM().listFromJson(json.data);

      return enrolls;
    }

    return null;
  }

  Future<List<EnrollVM>> search(String text) async {
    ResponseVM json = await EndPointService().setupApi(
      baseName,
      "SearchRange",
      [
        QueryModel(
          name: "text",
          value: text,
        ),
        QueryModel(
          name: "total",
          value: "0",
        ),
        QueryModel(
          name: "more",
          value: "2147483647",
        ),
      ],
    ).httpPost(
      "{}",
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (json.isSuccess == true) {
      enrolls = EnrollVM().listFromJson(json.data);

      return enrolls;
    }

    return null;
  }

  Future<EnrollVM> add(EnrollVM model) async {
    try {
      if (model != null && (model.status == null || model.status.isEmpty)) {
        model.status = "people";
      }
      var item = jsonEncode(model.toJson());
      print(item);
      ResponseVM json = await EndPointService().setupApi(
        baseName,
        "AddEnroll",
        [
          QueryModel(
            name: "saveNow",
            value: true.toString(),
          ),
        ],
      ).httpPost(
        item,
        HeaderEnum.BasicHeaderEnum,
        ResponseEnum.ResponseModelEnum,
      );

      if (json.isSuccess == true) {
        var option = EnrollVM.fromJson(json.data);

        return option;
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<List<EnrollVM>> addRange(List<EnrollVM> models) async {
    var items = jsonEncode(models);

    for (int i = 0; i < models.length; i++) {
      if (models[i].status == null || models[i].status.isEmpty) {
        models[i].status = "people";
      }
    }
    ResponseVM json = await EndPointService().setupApi(
      baseName,
      "AddRange",
      [
        QueryModel(
          name: "saveNow",
          value: true.toString(),
        ),
      ],
    ).httpPost(
      items,
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (json.isSuccess == true) {
      var option = EnrollVM().listFromJson(json.data);

      return option;
    }

    return null;
  }

  Future<EnrollVM> update(EnrollVM model) async {
    var item = jsonEncode(model);

    ResponseVM json = await EndPointService().setupApi(
      baseName,
      "",
      [
        QueryModel(
          name: "saveNow",
          value: true.toString(),
        ),
      ],
    ).httpPut(
      item,
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (json.isSuccess == true) {
      var option = EnrollVM.fromJson(json.data);

      return option;
    }

    return null;
  }

  Future<List<EnrollVM>> updateRange(List<EnrollVM> models) async {
    var items = jsonEncode(models);

    ResponseVM json = await EndPointService().setupApi(
      baseName,
      "UpdateRange",
      [
        QueryModel(
          name: "saveNow",
          value: true.toString(),
        ),
      ],
    ).httpPut(
      items,
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (json.isSuccess == true) {
      var option = EnrollVM().listFromJson(json.data);

      return option;
    }

    return null;
  }

  Future<EnrollVM> delete(EnrollVM model) async {
    //model.deleted = true;
    //var item = jsonEncode(model);
    try {
      ResponseVM json = await EndPointService().setupApi(
        baseName,
        "DeleteById",
        [
          QueryModel(
            name: "id",
            value: model.id.toString(),
          ),
        ],
      ).httpPost(
        "{}",
        HeaderEnum.BasicHeaderEnum,
        ResponseEnum.ResponseModelEnum,
      );

      if (json.isSuccess == true) {
        var option = EnrollVM.fromJson(json.data);

        return option;
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<List<EnrollVM>> deleteRange(List<EnrollVM> models) async {
    var items = jsonEncode(models);

    ResponseVM json = await EndPointService().setupApi(
      baseName,
      "DeleteRange",
      [
        QueryModel(
          name: "saveNow",
          value: true.toString(),
        ),
      ],
    ).httpDelete(
      items,
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (json.isSuccess == true) {
      var enrolls = EnrollVM().listFromJson(json.data);

      return enrolls;
    }

    return null;
  }

  Future<File> getImageFromCamera(int id, String property) async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 70,
    );

    var result = await uploadFile(image, id, property);

    if (result != null) {
      return image;
    }

    return null;
  }

  Future<File> getImageFromGallery(int id, String property) async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 70,
    );

    var result = await uploadFile(image, id, property);

    if (result != null) {
      return image;
    }

    return null;
  }

  Future<File> returnImageFromCamera() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 70,
    );

    return image;
  }

  Future<File> returnImageFromGallery() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 70,
    );

    return image;
  }

  Future<dynamic> uploadFile(File data, int id, String property) async {
    try {
      Dio dio = new Dio();

      var fd = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          data.path,
          filename: path.basename(data.path),
        ),
      });
      String url =
          "https://api.refahandishanco.ir/api/v1/Enroll/UploadFile?id=$id&property=$property";
      var response = await dio.post(url, data: fd);

      if (response != null) {
        return response;
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<EnrollVM> uploadEnrollAndFile(File data, EnrollVM model) async {
    try {
      Dio dio = new Dio();

      FormData fd;

      if (data == null) {
        fd = FormData.fromMap({
          "fullname": model.fullname,
          "homePhone": model.homePhone,
          "systemTag": model.systemTag,
          "identityNumber": model.identityNumber,
          "nationalId": model.nationalId,
          "fatherName": model.fatherName,
          "birthday": model.birthday,
          "address": model.address,
          "enrollType": model.enrollType,
          "startTime": model.startTime,
          "expireTime": model.expireTime,
        });
      } else {
        fd = FormData.fromMap({
          "fullname": model.fullname,
          "homePhone": model.homePhone,
          "systemTag": model.systemTag,
          "identityNumber": model.identityNumber,
          "nationalId": model.nationalId,
          "fatherName": model.fatherName,
          "birthday": model.birthday,
          "address": model.address,
          "enrollType": model.enrollType,
          "startTime": model.startTime,
          "expireTime": model.expireTime,
          "file": await MultipartFile.fromFile(
            data?.path ?? "",
            filename: path.basename(data?.path ?? ""),
          ),
        });
      }

      String url =
          "https://api.refahandishanco.ir/api/v1/Enroll/AddEnrollWithAvatar";
      var response = await dio.post(url, data: fd);

      if (response != null && response.statusCode == 200) {
        if (myEnrolls == null) myEnrolls = List<EnrollVM>();
        myEnrolls.add(EnrollVM.fromJson(response.data["data"]));
        return EnrollVM.fromJson(response.data["data"]);
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<OrderVM> Payment(bool retry) async {
    try {
      String url = "https://api.refahandishanco.ir/Refah/Payment?userId=";
      String id = ProfileService().getUserData().id.toString();
      String ret = retry ? "&retry=true" : "";
      var mye = List<EnrollVM>();
      myEnrolls.forEach((element) {
        element.startTime = null;
        element.expireTime = null;

        mye.add(element);
      });
      dynamic enco = mye.map((e) => e.toJson()).toList();
      String body = jsonEncode(enco);
      var respo = await http.post(
        "$url$id$ret",
        headers: EndPointService().basicHeader,
        body: body,
      );

      String data = utf8.decode(respo.bodyBytes);

      return OrderVM.fromJson(jsonDecode(data));
      // var result = EndPointService().responseGetter(
      //   EndPointService().getResponse(),
      //   respo,
      // );
      // return result;
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<ZarrinPalVerifyResponseModel> Verify(String auth) async {
    try {
      String url =
          "https://api.refahandishanco.ir/Refah/PaymentVerify?Authority=$auth&Status=OK";
      var respo = await http.get(
        url,
        headers: EndPointService().basicHeader,
      );

      String data = utf8.decode(respo.bodyBytes);

      return ZarrinPalVerifyResponseModel.fromJson(jsonDecode(data));
    } catch (e) {
      print(e);
    }

    return null;
  }
}
