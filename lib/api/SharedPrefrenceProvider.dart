import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrenceProvider {
  Future<void> setUserDataInSharePrefrences(String value, String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(key, value);
      return;
    } catch (e) {
      return;
    }
  }

  Future<void> setDefault(String key, String value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(key, value);
      return;
    } catch (e) {
      return;
    }
  }

  Future<String> getUserDataInSharePrefrences(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String data = prefs.getString(key);
      return data;
    } catch (e) {
      return null;
    }
  }
}
