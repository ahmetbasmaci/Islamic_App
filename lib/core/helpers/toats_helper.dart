import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import 'package:zad_almumin/core/utils/resources/app_constants.dart';

class ToatsHelper {
  ToatsHelper._();
  static void show(String msg) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(msg: msg);
  }

  static void showSuccess(String msg) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(msg: msg, backgroundColor: Colors.green);
  }

  static void showError(String msg) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: AppConstants.context.theme.colorScheme.error,
    );
  }
}
