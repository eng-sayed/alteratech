import 'package:shared_preferences/shared_preferences.dart';

class MyShared {
  static late SharedPreferences prefs;
  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static saveData({required String key, required value}) async {
    if (value is String) await prefs.setString(key, value);
    if (value is double) await prefs.setDouble(key, value);
    if (value is bool) await prefs.setBool(key, value);
    if (value is int) await prefs.setInt(key, value);
  }

  static getData({required String key}) async {
    return prefs.get(key);
  }

  static removeData({required String key}) async {
    return await prefs.remove(key);
  }
}
