import 'package:flutter/material.dart';

class AppColors {
  static ThemeMode appMode = ThemeMode.light;

  static Color get primiry =>
      appMode == ThemeMode.light ? Color(0xFFfc6703) : Colors.white;
  static Color get secondary =>
      appMode == ThemeMode.light ? Color(0xff8EC045) : Colors.white;
  static Color get black =>
      appMode == ThemeMode.light ? Colors.black : Colors.white;
  static Color get white =>
      appMode == ThemeMode.light ? Colors.white : Colors.black;
  static Color get grey =>
      appMode == ThemeMode.light ? Color(0xff7A7A7A) : Colors.black;
  static Color get lightGrey =>
      appMode == ThemeMode.light ? Color(0xffE2E0E0) : Colors.black;
  static Color get lightGreybackgound =>
      appMode == ThemeMode.light ? Color(0xffF9F9F9) : Colors.black;
  static Color get darkGrey =>
      appMode == ThemeMode.light ? Color(0xff707070) : Colors.black;
  static Color get greyText =>
      appMode == ThemeMode.light ? Color(0xff7A7A7A) : Colors.black;
  static Color get buttonColor =>
      appMode == ThemeMode.light ? Color(0xff30B9BB) : Colors.black;
  static Color get red =>
      appMode == ThemeMode.light ? Color(0xffFF0000) : Colors.black;
  static Color get yellow =>
      appMode == ThemeMode.light ? Color(0xffFFCC00) : Colors.black;
  static Color get green =>
      appMode == ThemeMode.light ? Color(0xff06C88A) : Colors.black;
}
