import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:refah/api/EndPointService.dart';
import 'package:refah/models/OptionMicroVM.dart';
import 'package:refah/models/OptionVM.dart';
import 'package:refah/models/QueryModel.dart';
import 'package:refah/models/ResponseVM.dart';
import 'package:refah/pages/admin/editation/AdminSettingEditPage.dart';
import 'package:refah/widgets/WDG_BusinessOptionItem.dart';

class OptionService with ChangeNotifier {
  static const String baseName = "Option";
  static List<OptionVM> options;
  static Function(dynamic result) refreshCallback;

  setRefreshCallback(Function(dynamic result) func) {
    refreshCallback = func;
  }

  String getAppVersion(String current) {
    var vr = options.indexWhere((element) => element.type == "version");

    if (vr >= 0 && current != options[vr].name) {
      return options[vr].value;
    }
    return "";
  }

  Future<List<OptionVM>> init() async {
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
      options = OptionVM().listFromJson(json.data);

      return options;
    }

    return null;
  }

  Future<OptionVM> getById(int id) async {
    OptionVM opt = OptionVM(id: id);

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
      options = OptionVM().listFromJson(json.data);

      if (options != null && options.length > 0) {
        return options.first;
      }
    }

    return null;
  }

  Future<OptionVM> getByName(String name) async {
    OptionVM opt;
    if (options != null && options.length > 0) {
      int idx = options.indexWhere((element) => element.name == name);
      if (idx >= 0) opt = options[idx];
    }

    if (opt != null) return opt;

    opt = OptionVM(name: name);

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
      options = OptionVM().listFromJson(json.data);

      if (options != null && options.length > 0) {
        return options.first;
      }
    }

    return null;
  }

  List<OptionVM> getAllLocalByType(String type) {
    return options.where((element) => element.type == "banner").toList();
  }

  Future<List<OptionVM>> getAllByType(String type) async {
    OptionVM opt = OptionVM(type: type);

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
      options = OptionVM().listFromJson(json.data);

      return options;
    }

    return null;
  }

  Future<List<OptionVM>> filter(OptionVM model) async {
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
      options = OptionVM().listFromJson(json.data);

      return options;
    }

    return null;
  }

  Future<List<OptionVM>> search(String text) async {
    ResponseVM json = await EndPointService().setupApi(
      baseName,
      "FilterRange",
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
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (json.isSuccess == true) {
      options = OptionVM().listFromJson(json.data);

      return options;
    }

    return null;
  }

  Future<OptionVM> add(OptionMicroVM model) async {
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
    ).httpPost(
      item,
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (json.isSuccess == true) {
      var option = OptionVM.fromJson(json.data);

      return option;
    }

    return null;
  }

  Future<List<OptionVM>> addRange(List<OptionVM> models) async {
    var items = jsonEncode(models);

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
      var option = OptionVM().listFromJson(json.data);

      return option;
    }

    return null;
  }

  Future<OptionVM> update(OptionVM model) async {
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
      var option = OptionVM.fromJson(json.data);

      return option;
    }

    return null;
  }

  Future<List<OptionVM>> updateRange(List<OptionVM> models) async {
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
      var option = OptionVM().listFromJson(json.data);

      return option;
    }

    return null;
  }

  Future<OptionVM> delete(OptionVM model) async {
    //model.deleted = true;
    //var item = jsonEncode(model);
    try {
      ResponseVM json = await EndPointService().setupApi(
        baseName,
        "DeleteById",
        [
          QueryModel(
            name: "saveNow",
            value: true.toString(),
          ),
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
        var option = OptionVM.fromJson(json.data);

        return option;
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<List<OptionVM>> deleteRange(List<OptionVM> models) async {
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
      var options = OptionVM().listFromJson(json.data);

      return options;
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
          "https://api.refahandishanco.ir/api/v1/Option/UploadFile?id=$id&property=$property";
      var response = await dio.post(url, data: fd);

      if (response != null) {
        return response;
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  List<Widget> getWidgetList(BuildContext context) {
    if (options != null) {
      return options
          .map(
            (e) => WDG_BusinessOptionItem(
              obj: e,
              editRoute: AdminSettingEditPage(
                obj: e,
              ),
              editParam: e,
              deleteOnTapCallback: (result) {
                var alert = AlertDialog(
                  title: Text(e.title),
                  content: Text(
                    "آیا از حذف این مورد مطمئن هستید؟",
                    style: TextStyle(
                      fontFamily: "IRANSans",
                    ),
                  ),
                  actions: [
                    FlatButton(
                      onPressed: () async {
                        var res = await OptionService().delete(
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

  List<Widget> getPresentsWidgetList(BuildContext context) {
    if (options != null) {
      return options
          .where((element) => element.type == "present")
          .map(
            (e) => WDG_BusinessOptionItem(
              obj: e,
              editRoute: AdminSettingEditPage(
                obj: e,
              ),
              editParam: e,
              deleteOnTapCallback: (result) {
                var alert = AlertDialog(
                  title: Text(e.title),
                  content: Text(
                    "آیا از حذف این مورد مطمئن هستید؟",
                    style: TextStyle(
                      fontFamily: "IRANSans",
                    ),
                  ),
                  actions: [
                    FlatButton(
                      onPressed: () async {
                        var res = await OptionService().delete(
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
}
