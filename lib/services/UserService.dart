import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:refah/api/EndPointService.dart';
import 'package:refah/api/ProfileService.dart';
import 'package:refah/models/QueryModel.dart';
import 'package:refah/models/ResponseVM.dart';
import 'package:refah/models/UserMicroVM.dart';
import 'package:refah/models/UserVM.dart';
import 'package:refah/pages/admin/editation/AdminDoctorEditPage.dart';
import 'package:refah/pages/admin/editation/AdminUserEditPage.dart';
import 'package:refah/widgets/WDG_BusinessOfficeItem.dart';
import 'package:refah/widgets/WDG_BusinessUserItem.dart';

class UserService with ChangeNotifier {
  static String baseName = "Users";
  static UserVM myProfile;
  static List<UserVM> usersData = List<UserVM>();
  static List<UserVM> parents = List<UserVM>();

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static Random _rnd = Random();

  static Function(dynamic result) refreshCallback;

  setRefreshCallback(Function(dynamic result) func) {
    refreshCallback = func;
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<List<UserVM>> init() async {
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
      usersData = UserVM().listFromJson(json.data);

      //usersData.sort((a, b) => a.priority.compareTo(b.priority));

      return usersData;
    }

    return null;
  }

  Future<UserVM> getById(int id) async {
    UserVM opt = UserVM(id: id);

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
      usersData = UserVM().listFromJson(json.data);

      if (usersData != null && usersData.length > 0) {
        return usersData.first;
      }
    }

    return null;
  }

  Future<UserVM> getByName(String name) async {
    UserVM opt = UserVM(userName: name);

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
      usersData = UserVM().listFromJson(json.data);

      if (usersData != null && usersData.length > 0) {
        return usersData.first;
      }
    }

    return null;
  }

  Future<List<UserVM>> getAllByType(String type) async {
    // UserVM opt = UserVM(status: type);

    // var filter = jsonEncode(opt);

    // ResponseVM json =
    //     await EndPointService().setupApi(baseName, "FilterRange", [
    //   QueryModel(
    //     name: "total",
    //     value: "0",
    //   ),
    //   QueryModel(
    //     name: "more",
    //     value: "2147483647",
    //   ),
    // ]).httpPost(
    //   filter,
    //   HeaderEnum.BasicHeaderEnum,
    //   ResponseEnum.ResponseModelEnum,
    // );

    // if (json.isSuccess == true) {
    //   usersData = UserVM().listFromJson(json.data);

    //   return usersData;
    // }

    return null;
  }

  Future<List<UserVM>> filter(String _status) async {
    ResponseVM json =
        await EndPointService().setupApi(baseName, "FilterByStatus", [
      QueryModel(
        name: "status",
        value: _status,
      ),
    ]).httpGet(
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (json.isSuccess == true) {
      usersData = UserVM().listFromJson(json.data);

      //usersData.sort((a, b) => a.priority.compareTo(b.priority));

      return usersData;
    }

    return null;
  }

  Future<List<UserVM>> search(String text) async {
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
      "",
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (json.isSuccess == true) {
      usersData = UserVM().listFromJson(json.data);

      // usersData.sort((a, b) => a.priority.compareTo(b.priority));

      return usersData;
    }

    return null;
  }

  Future<bool> add(UserMicroVM model, String password) async {
    var item = jsonEncode(model);

    ResponseVM json = await EndPointService().setupApi(
      baseName,
      "",
      [
        QueryModel(
          name: "saveNow",
          value: true.toString(),
        ),
        QueryModel(
          name: "password",
          value: password,
        ),
      ],
    ).httpPost(
      item,
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (json.isSuccess == true) {
      return true;
    }

    return false;
  }

  Future<List<UserVM>> addRange(List<UserVM> models) async {
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
      var option = UserVM().listFromJson(json.data);

      return option;
    }

    return null;
  }

  Future<bool> update(UserVM model) async {
    var item = jsonEncode(model);

    ResponseVM json = await EndPointService().setupApi(
      baseName,
      "",
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
    ).httpPut(
      item,
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (json.isSuccess == true) {
      return true;
    }

    return false;
  }

  Future<List<UserVM>> updateRange(List<UserVM> models) async {
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
      var option = UserVM().listFromJson(json.data);

      return option;
    }

    return null;
  }

  Future<UserVM> delete(UserVM model) async {
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
        var option = UserVM.fromJson(json.data);

        return option;
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<List<UserVM>> deleteRange(List<UserVM> models) async {
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
      var options = UserVM().listFromJson(json.data);

      return options;
    }

    return null;
  }

  Future getImage() async {
    if (await Permission.camera.request().isGranted) {
      // ignore: deprecated_member_use
      var image = await ImagePicker.pickImage(
        source: ImageSource.camera,
      );
    } else {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
      ].request();
    }
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
          "https://api.refahandishanco.ir/api/v1/Users/UploadUserAvatar?id=$id";
      var response = await dio.put(url, data: fd);

      if (response != null) {
        return response;
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  List<Widget> getWidgetList(BuildContext context) {
    if (usersData != null) {
      return usersData
          .map(
            (e) => WDG_BusinessOfficeItem(
              obj: e,
              editRoute: AdminDoctorEditPage(
                obj: e,
              ),
              editParam: e,
              deleteOnTapCallback: (result) {
                var alert = AlertDialog(
                  title: Text(e.officeName),
                  content: Text(
                    "آیا از حذف این مورد مطمئن هستید؟",
                    style: TextStyle(
                      fontFamily: "IRANSans",
                    ),
                  ),
                  actions: [
                    FlatButton(
                      onPressed: () async {
                        var res = await UserService().delete(
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

  List<Widget> getOfficeWidgetList(BuildContext context) {
    if (usersData != null) {
      return usersData
          .where((element) =>
              element.officeName != null && element.officeName.isNotEmpty)
          .map(
            (e) => WDG_BusinessOfficeItem(
              obj: e,
              editRoute: AdminDoctorEditPage(
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
                  title: Text(e.officeName),
                  content: Text(
                    "آیا از حذف این مورد مطمئن هستید؟",
                    style: TextStyle(
                      fontFamily: "IRANSans",
                    ),
                  ),
                  actions: [
                    FlatButton(
                      onPressed: () async {
                        var res = await UserService().delete(
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

  List<Widget> getUserWidgetList(BuildContext context) {
    if (usersData != null) {
      return usersData
          .map(
            (e) => WDG_BusinessUserItem(
              obj: e,
              editRoute: AdminUserEditPage(
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
                        var res = await UserService().delete(
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

  List<Widget> getCustomUserWidgetList(
      BuildContext context, List<UserVM> users) {
    if (users != null) {
      return users
          .map(
            (e) => WDG_BusinessUserItem(
              obj: e,
              editRoute: AdminUserEditPage(
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
                        var res = await UserService().delete(
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

  UserVM getUserById(int _id) {
    var index = usersData.indexWhere((element) => element.id == _id);

    if (index >= 0) {
      return usersData[index];
    }

    return null;
  }

  Future<List<UserVM>> getAllUsers() async {
    ResponseVM json =
        await EndPointService().setupApi(baseName, "", []).httpGet(
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (json.isSuccess == true) {
      usersData = UserVM().listFromJson(json.data);

      return usersData;
    }

    return null;
  }

  Future<List<UserVM>> getAllMessagedUsers() async {
    ResponseVM json =
        await EndPointService().setupApi(baseName, "GetMessagedUsers", [
      QueryModel(
        name: "id",
        value: ProfileService().getUserData().id.toString(),
      ),
    ]).httpGet(
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (json.isSuccess == true) {
      usersData = UserVM().listFromJson(json.data);

      return usersData;
    }

    return null;
  }

  Future<UserVM> getUserByMobile(String phone, String nid) async {
    ResponseVM json = await EndPointService().setupApi(baseName, "GetByData", [
      QueryModel(
        name: "nid",
        value: nid,
      ),
      QueryModel(
        name: "mobile",
        value: phone,
      ),
    ]).httpGet(
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (json.isSuccess == true) {
      var ud = UserVM.fromJson(json.data);
      usersData.add(ud);

      return ud;
    }

    return null;
  }

  Future<UserVM> getUserByIdentity(String phone) {
    // method
  }

  Future<UserVM> login(UserVM model) {
    // method
  }

  Future<UserVM> register(UserMicroVM model) async {
    String json = jsonEncode(model);
    ResponseVM res =
        await EndPointService().setupApi(baseName, "", []).httpPost(
      json,
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (res.isSuccess == true) {
      myProfile = UserVM.fromJson(res.data);

      return myProfile;
    }

    return null;
  }

  Future<UserVM> reset(UserVM model) {
    // method
  }
}
