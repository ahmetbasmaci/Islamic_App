import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToatsHelper {
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
    Fluttertoast.showToast(msg: msg, backgroundColor: Colors.red);
  }
}
