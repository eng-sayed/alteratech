import 'package:shared_preferences/shared_preferences.dart';

class MyShared {
  static late SharedPreferences prefs;
  init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
