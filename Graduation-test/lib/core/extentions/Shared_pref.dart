import 'dart:core';

import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPref {
  static late SharedPreferences _prefs;
  static String namekey = "name";
  static String Imagekey = "path";

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setUserData(String Name, String Image) async {
    await setString(namekey, Name);
    await setString(Imagekey, Image);
  }

  static Future<void> setString(String Key, String value) async {
    await _prefs.setString(Key, value);
  }

  static String getString(String Key) {
    return _prefs.getString(Key) ?? "";
  }
}
