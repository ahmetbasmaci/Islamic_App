import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rename/enums.dart';

class AppConstants {
  AppConstants._();
  static const String developerEmail = 'engahmet10@gmail.com';
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>(); // Create a key to can open drawer
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext get context => navigatorKey.currentState!.context;
  static FocusScopeNode focusScopeNode = FocusScopeNode();

  static RenamePlatform get currentPlatform {
    if (Platform.isAndroid) {
      return RenamePlatform.android;
    } else if (Platform.isIOS) {
      return RenamePlatform.ios;
    } else if (Platform.isMacOS) {
      return RenamePlatform.macOS;
    } else if (Platform.isWindows) {
      return RenamePlatform.windows;
    } else if (Platform.isLinux) {
      return RenamePlatform.linux;
    }
    return RenamePlatform.android;
  }

  static SystemUiOverlayStyle systemUiOverlayStyleQuran = const SystemUiOverlayStyle(
      // statusBarColor: MyColors.quranStatus,
      // statusBarIconBrightness: Brightness.dark,
      // systemNavigationBarColor: MyColors.quranStatus,
      // systemNavigationBarDividerColor: Colors.transparent,
      // systemNavigationBarIconBrightness: Brightness.dark,
      );

  static SystemUiOverlayStyle systemUiOverlayStyleDefault = const SystemUiOverlayStyle(
      // statusBarColor: MyColors.black,
      // statusBarIconBrightness: Brightness.light,
      // systemNavigationBarColor: MyColors.black,
      // systemNavigationBarIconBrightness: Brightness.dark,
      // systemNavigationBarDividerColor: Colors.transparent,
      // statusBarBrightness: Brightness.dark,
      );
}
