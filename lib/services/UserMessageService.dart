import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:refah/api/EndPointService.dart';
import 'package:refah/api/ProfileService.dart';
import 'package:refah/models/QueryModel.dart';
import 'package:refah/models/ResponseVM.dart';
import 'package:refah/models/UserMessageMicroVM.dart';
import 'package:refah/models/UserMessageVM.dart';
import 'package:refah/services/UserService.dart';
import 'package:refah/widgets/WDG_AdminUserMessageWidget.dart';

class UserMessageService with ChangeNotifier {
  static const String baseName = "UserMessage";
  static List<UserMessageVM> options;
  static Function(dynamic result) refreshCallback;

  setRefreshCallback(Function(dynamic result) func) {
    refreshCallback = func;
  }

  Future<List<UserMessageVM>> init() async {
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
      options = UserMessageVM().listFromJson(json.data);

      return options;
    }

    return null;
  }

// /api/v1/UserMessage/GetUserChats
  Future<List<UserMessageVM>> getUserMessages(int _id) async {
    ResponseVM json = await EndPointService().setupApi(
      baseName,
      "GetUserChats",
      [
        QueryModel(
          name: "id",
          value: _id.toString(),
        ),
        QueryModel(
          name: "myId",
          value: ProfileService().getUserData().id.toString(),
        ),
      ],
    ).httpGet(
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (json.isSuccess == true) {
      options = UserMessageVM().listFromJson(json.data);

      return options;
    }

    return null;
  }

  Future<UserMessageVM> getById(int id) async {
    UserMessageVM opt = UserMessageVM(id: id);

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
      options = UserMessageVM().listFromJson(json.data);

      if (options != null && options.length > 0) {
        return options.first;
      }
    }

    return null;
  }

  Future<List<UserMessageVM>> filter(UserMessageVM model) async {
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
      options = UserMessageVM().listFromJson(json.data);

      return options;
    }

    return null;
  }

  Future<List<UserMessageVM>> search(String text) async {
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
      options = UserMessageVM().listFromJson(json.data);

      return options;
    }

    return null;
  }

  Future<UserMessageVM> add(UserMessageMicroVM model) async {
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
      var option = UserMessageVM.fromJson(json.data);

      return option;
    }

    return null;
  }

  Future<List<UserMessageVM>> addRange(List<UserMessageVM> models) async {
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
      var option = UserMessageVM().listFromJson(json.data);

      return option;
    }

    return null;
  }

  Future<UserMessageVM> update(UserMessageVM model) async {
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
      var option = UserMessageVM.fromJson(json.data);

      return option;
    }

    return null;
  }

  Future<List<UserMessageVM>> updateRange(List<UserMessageVM> models) async {
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
      var option = UserMessageVM().listFromJson(json.data);

      return option;
    }

    return null;
  }

  Future<UserMessageVM> delete(UserMessageVM model) async {
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
        var option = UserMessageVM.fromJson(json.data);

        return option;
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<List<UserMessageVM>> deleteRange(List<UserMessageVM> models) async {
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
      var options = UserMessageVM().listFromJson(json.data);

      return options;
    }

    return null;
  }

  Future<String> uploadFile(FormData data) async {
    ResponseVM json =
        await EndPointService().setupApi(baseName, "UpdateRange", []).httpPut(
      data,
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (json.isSuccess == true) {}

    return null;
  }

  List<Widget> getWidgetList(BuildContext context) {
    List<Widget> items = List<Widget>();

    if (options != null) {
      options.forEach((e) {
        var user = UserService().getUserById(e.userId);
        items.add(WDG_AdminUserMessageWidget(
          targetAvatar: user?.avatar,
          targetName: user?.fullname,
          obj: e,
          editParam: e,
        ));
      });
      return items;
    }

    return List<Widget>();
  }
}
