import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class Alerts {
  static snak({ContentType? type, title, message, context}) {
    var snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title ?? '',
        message: message ?? '',
        contentType: type!,
      ),
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
