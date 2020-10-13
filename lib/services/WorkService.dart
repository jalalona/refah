import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:refah/api/EndPointService.dart';
import 'package:refah/models/WorkVM.dart';
import 'package:refah/models/QueryModel.dart';
import 'package:refah/models/ResponseVM.dart';
import 'package:refah/models/WorkVM.dart';

class WorkService with ChangeNotifier {
  static const String baseName = "WorkWithUs";
  static List<WorkVM> works;
  static Function(dynamic result) refreshCallback;

  setRefreshCallback(Function(dynamic result) func) {
    refreshCallback = func;
  }

  Future<List<WorkVM>> init() async {
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
      works = WorkVM().listFromJson(json.data);

      return works;
    }

    return null;
  }

  Future<WorkVM> getById(int id) async {
    WorkVM opt = WorkVM(id: id);

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
      works = WorkVM().listFromJson(json.data);

      if (works != null && works.length > 0) {
        return works.first;
      }
    }

    return null;
  }

  Future<List<WorkVM>> filter(WorkVM model) async {
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
      works = WorkVM().listFromJson(json.data);

      return works;
    }

    return null;
  }

  Future<List<WorkVM>> search(String text) async {
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
      works = WorkVM().listFromJson(json.data);

      return works;
    }

    return null;
  }

  Future<WorkVM> add(WorkVM model) async {
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
      var option = WorkVM.fromJson(json.data);

      return option;
    }

    return null;
  }

  Future<List<WorkVM>> addRange(List<WorkVM> models) async {
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
      var option = WorkVM().listFromJson(json.data);

      return option;
    }

    return null;
  }

  Future<WorkVM> update(WorkVM model) async {
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
      var option = WorkVM.fromJson(json.data);

      return option;
    }

    return null;
  }

  Future<List<WorkVM>> updateRange(List<WorkVM> models) async {
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
      var option = WorkVM().listFromJson(json.data);

      return option;
    }

    return null;
  }

  Future<WorkVM> delete(WorkVM model) async {
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
        var option = WorkVM.fromJson(json.data);

        return option;
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<List<WorkVM>> deleteRange(List<WorkVM> models) async {
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
      var works = WorkVM().listFromJson(json.data);

      return works;
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
}
