import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:refah/api/EndPointService.dart';
import 'package:refah/models/QueryModel.dart';
import 'package:refah/models/ResponseVM.dart';
import 'package:refah/models/UserCommentMicroVM.dart';
import 'package:refah/models/UserCommentVM.dart';
import 'package:refah/pages/admin/editation/AdminCommentEditPage.dart';
import 'package:refah/services/UserService.dart';
import 'package:refah/widgets/WDG_AdminCommentWidget.dart';

class UserCommentService with ChangeNotifier {
  static const String baseName = "UserComment";
  static List<UserCommentVM> comments;
  static Function(dynamic result) refreshCallback;

  setRefreshCallback(Function(dynamic result) func) {
    refreshCallback = func;
  }

  Future<List<UserCommentVM>> init() async {
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
      comments = UserCommentVM().listFromJson(json.data);

      return comments;
    }

    return null;
  }

  Future<UserCommentVM> getById(int id) async {
    UserCommentVM opt = UserCommentVM(id: id);

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
      comments = UserCommentVM().listFromJson(json.data);

      if (comments != null && comments.length > 0) {
        return comments.first;
      }
    }

    return null;
  }

  Future<List<UserCommentVM>> filter(UserCommentVM model) async {
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
      comments = UserCommentVM().listFromJson(json.data);

      return comments;
    }

    return null;
  }

  Future<List<UserCommentVM>> search(String text) async {
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
      comments = UserCommentVM().listFromJson(json.data);

      return comments;
    }

    return null;
  }

  Future<UserCommentVM> add(UserCommentMicroVM model) async {
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
      var option = UserCommentVM.fromJson(json.data);

      return option;
    }

    return null;
  }

  Future<List<UserCommentVM>> addRange(List<UserCommentVM> models) async {
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
      var option = UserCommentVM().listFromJson(json.data);

      return option;
    }

    return null;
  }

  Future<UserCommentVM> update(UserCommentVM model) async {
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
      var option = UserCommentVM.fromJson(json.data);

      return option;
    }

    return null;
  }

  Future<List<UserCommentVM>> updateRange(List<UserCommentVM> models) async {
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
      var option = UserCommentVM().listFromJson(json.data);

      return option;
    }

    return null;
  }

  Future<UserCommentVM> delete(UserCommentVM model) async {
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
        var option = UserCommentVM.fromJson(json.data);

        return option;
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<List<UserCommentVM>> deleteRange(List<UserCommentVM> models) async {
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
      var options = UserCommentVM().listFromJson(json.data);

      return options;
    }

    return null;
  }

  List<Widget> getWidgetList(BuildContext context) {
    List<Widget> items = List<Widget>();
    if (comments != null) {
      comments.forEach((e) {
        var target = UserService().getUserById(e.userId);
        items.add(WDG_AdminCommentWidget(
          obj: e,
          editRoute: AdminCommentEditPage(
            obj: e,
          ),
          editParam: e,
          rejectOnTapCallback: (result) {
            var alert = AlertDialog(
              title: Text(e.description),
              content: Text(
                "آیا از رد کردن این مورد مطمئن هستید؟",
                style: TextStyle(
                  fontFamily: "IRANSans",
                ),
              ),
              actions: [
                FlatButton(
                  onPressed: () async {
                    e.isActive = false;
                    var res = await UserCommentService().update(
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
          rejectParam: e,
          confirmOnTapCallback: (result) async {
            e.isActive = true;
            var res = await UserCommentService().update(
              e,
            );
            if (refreshCallback != null) {
              refreshCallback(res);
            }
            Navigator.pop(context);
          },
          confirmParam: e,
          originAvatar: "",
          originName: "",
          targetAvatar: target?.avatar,
          targetName: target?.fullname,
        ));
      });
      return items;
    }

    return List<Widget>();
  }
}
