import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:refah/models/QueryModel.dart';
import 'package:refah/models/ResponseVM.dart';
import 'package:refah/models/UserVM.dart';

import 'EndPointService.dart';
import 'SharedPrefrenceProvider.dart';

class ProfileService with ChangeNotifier {
  // consts
  static const String userKey = "user-data";
  static const String userTypeKey = "type-data";

  // models
  static UserVM user;
  static bool logedIn;
  static bool wellcomed;
  static String userType;

  // widgets
  static Widget profileIconWidget;
  static Widget avatarWidget;

  // references
  setWellcome(bool wl) {
    wellcomed = wl;
  }

  bool getWellcome() {
    return wellcomed ?? false;
  }

  // callbacks
  static Function(dynamic result) refreshCallback;
  static Function(dynamic result) displayModeChangeCallback;

  // resources
  static TextEditingController passwordController = TextEditingController();
  static String profileIconSvg =
      '<svg viewBox="10.5 8.0 13.5 9.0" ><path transform="translate(10.49, 7.99)" d="M 0 4.504886150360107 C 0 4.504886150360107 4.503236293792725 8.999323844909668 4.504886150360107 9.009772300720215 C 4.50653600692749 9.020220756530762 13.51465797424316 0 13.51465797424316 0" fill="none" stroke="#8d4399" stroke-width="3" stroke-miterlimit="4" stroke-linecap="round" /></svg>';

// user model part
  Future<UserVM> initialization() async {
    user = await loadUserDataLocaly();
    userType = await loadUserTypeLocaly();
  }

  //GetUserByPhoneAndUserName

  Future<UserVM> login(UserVM model) async {
    var _responseData = await EndPointService().setupApi(
      "Users",
      "Token",
      [],
    ).httpPost(
      model.toJson(),
      HeaderEnum.EmptyHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (_responseData.isSuccess) {
      UserVM us = UserVM.fromJson(_responseData.data);

      user = us;
      saveUserDataLocaly(user);

      return user;
    } else {
      return null;
    }
  }

  Future<UserVM> CheckUser(String _user, String _pass) async {
    if (_user != null &&
        _pass != null &&
        _user.isNotEmpty &&
        _pass.isNotEmpty) {
      var _responseData = await EndPointService().setupApi(
        "Users",
        "GetUserByPhoneAndUserName",
        [
          QueryModel(
            name: "userName",
            value: _user,
          ),
          QueryModel(
            name: "phone",
            value: _pass,
          ),
        ],
      ).httpGet(
        HeaderEnum.EmptyHeaderEnum,
        ResponseEnum.ResponseModelEnum,
      );
      if (_responseData.isSuccess) {
        UserVM us = UserVM.fromJson(_responseData.data);

        user = us;

        return us;
      }
    }
    return null;
  }

  Future<UserVM> autoLogin() {
    if (user != null && user.userName != null && user.phoneNumber != null) {
      return login(
        UserVM(userName: user.userName, phoneNumber: user.phoneNumber),
      );
    }
  }

  Future<bool> register(UserVM model) async {
    String jsn = jsonEncode(model);
    var _responseData = await EndPointService().setupApi(
      "Users",
      "",
      [QueryModel(name: "password", value: model.phoneNumber)],
    ).httpPost(
      jsn,
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (_responseData.isSuccess) {
      return true;
    }

    return false;
  }

  Future<bool> reset(UserVM model) async {
    var _response = await EndPointService().setupApi(
      "Users",
      "",
      [
        QueryModel(
          name: "userName",
          value: model.userName,
        ),
      ],
    ).httpDelete(
      HeaderEnum.EmptyHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (_response.isSuccess) {
      return true;
    }

    return false;
  }

  Future<bool> validation(String code, UserVM model) async {
    var _responseData = await EndPointService().setupApi(
      "Users",
      "ValidPhone",
      [
        QueryModel(
          name: "username",
          value: model.userName,
        ),
        QueryModel(
          name: "code",
          value: code,
        )
      ],
    ).httpPost(
      "",
      HeaderEnum.EmptyHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (_responseData.isSuccess) {
      return true;
    }

    return false;
  }

  Future resendSms(UserVM model) async {
    var _response = await EndPointService().setupApi(
      "Users",
      "AgainSendValidCode",
      [
        QueryModel(
          name: "username",
          value: model.userName,
        ),
      ],
    ).httpGet(
      HeaderEnum.EmptyHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (_response.isSuccess) {
      // method
    }
  }

  Future setUserVM(UserVM model) {
    user = model;
  }

  Future saveUserDataLocaly(UserVM model) async {
    await SharedPrefrenceProvider()
        .setUserDataInSharePrefrences(jsonEncode(model), userKey);
  }

  Future<UserVM> loadUserDataLocaly() async {
    var json = jsonDecode(
        await SharedPrefrenceProvider().getUserDataInSharePrefrences(userKey));

    user = UserVM.fromJson(json);

    return user;
  }

  Future deleteUserDataLocaly() async {
    await SharedPrefrenceProvider().setUserDataInSharePrefrences("", userKey);
    user = null;
  }

  Future<bool> updateUserData(UserVM model) async {
    var response = await EndPointService().setupApi(
      "Users",
      "",
      [
        QueryModel(
          name: "id",
          value: model.id.toString(),
        ),
      ],
    ).httpPut(
      jsonEncode(model),
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (response.isSuccess) {
      return true;
    }

    return false;
  }

  Future<UserVM> getUserByUsername(String username, String phone) async {
    var response = await EndPointService().setupApi(
      "Users",
      "GetUserByPhoneAndUserName",
      [
        QueryModel(
          name: "userName",
          value: username,
        ),
        QueryModel(
          name: "phone",
          value: phone,
        ),
      ],
    ).httpGet(
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (response.isSuccess) {
      UserVM _user = UserVM.fromJson(response.data);
      user = _user;
      return _user;
    }

    return null;
  }

  Future<UserVM> getUserById(int id) {}

  UserVM getUserData() {
    return user;
  }

  // user type
  Future saveUserTypeLocaly(String type) async {
    await SharedPrefrenceProvider()
        .setUserDataInSharePrefrences(type, userTypeKey);
  }

  Future setUserType(String type) {
    userType = type;
  }

  Future loadUserTypeLocaly() async {
    var ut = await SharedPrefrenceProvider()
        .getUserDataInSharePrefrences(userTypeKey);

    return ut ?? "";
  }

  String getUserType() {
    return userKey;
  }

// other tools
  Future<bool> sendShareSMS(String text) async {
    try {
      var _responseData = await EndPointService().setupApi(
        "Users",
        "SendSMSAll",
        [
          QueryModel(
            name: "text",
            value: text,
          ),
        ],
      ).httpPost(
        "",
        HeaderEnum.EmptyHeaderEnum,
        ResponseEnum.ResponseModelEnum,
      );

      if (_responseData.isSuccess) {
        return true;
      }
    } catch (e) {
      print(e);
    }

    return false;
  }

// future builders
  Widget profileIcon() {
    return FutureBuilder(
      future: loadUserDataLocaly(),
      builder: (context, snapshot) {
        return Container();
      },
    );
  }

  Widget avatar() {}

  Widget shareApp(String phone) {}

  // Widget displayModeWidget() {
  //   return FutureBuilder(
  //     future: loadDisplayModeLocaly(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         return ViewTypeToolsWidget(
  //           callback: displayModeChangeCallback,
  //         );
  //       } else if (snapshot.hasError) {
  //         return Container();
  //       } else {
  //         return CircularProgressIndicator();
  //       }
  //     },
  //   );
  // }
}
