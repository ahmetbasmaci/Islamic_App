import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

class Constants {
  static SystemUiOverlayStyle systemUiOverlayStyleQuran = SystemUiOverlayStyle(
    statusBarColor: MyColors.quranStatus(),
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: MyColors.quranStatus(),
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
  static SystemUiOverlayStyle systemUiOverlayStyleDefault = SystemUiOverlayStyle(
    statusBarColor: MyColors.black,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: MyColors.black,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
  );
}
