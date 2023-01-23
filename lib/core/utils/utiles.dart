import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Utiles {
  static ThemeMode appMode = ThemeMode.light;
  static String token = "";
  static String UserId = "";
  static String Username = "";
  static String x_WC_Store = "";
  static String wishListKey = "";
  static String consumer_key = "ck_d5f8649bb3448e0c9361b9decff736ca82f33c32";
  static String consumer_secret = "cs_52fd8dad5bacf1642721be6a7abf1fbf8a40ddce";

  openwhatsapp(context) async {
    var whatsapp = "+201140034316";
    var whatsappURl_android = "whatsapp://send?phone=" + whatsapp + "&text= ";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse(" ")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("whatsapp no installed".tr())));
      }
    } else {
      // android , web
      if (await launchUrl(Uri.parse(whatsappURl_android))) {
        await launch(whatsappURl_android);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("whatsapp no installed".tr())));
      }
    }
  }
}
