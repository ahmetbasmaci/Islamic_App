import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppConstants {
  AppConstants._();
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>(); // Create a key to can open drawer
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext get context => navigatorKey.currentState!.context;

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
