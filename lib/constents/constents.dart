import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:zad_almumin/pages/home_page.dart';
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

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>(); // Create a key to can open drawer

  static NumberFormat format3 = NumberFormat('000');
  static NumberFormat format2 = NumberFormat('00');

  static void setNewOpendPageId(String id) => GetStorage().write('lastOpendPageId', id);
  static String getNewOpendPageId() => GetStorage().read<String>('lastOpendPageId')??HomePage.id;
}
