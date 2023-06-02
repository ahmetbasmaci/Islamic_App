import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'my_colors.dart';

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

  static FocusScopeNode focusScopeNode = FocusScopeNode();
  static NumberFormat formatInt3 = NumberFormat('000');
  static NumberFormat formatInt2 = NumberFormat('00');

  static double quranUpPartHeight = Get.size.height * .07;

  static String machineCode = '';
  static String developerMachineCode = 'RP1A.200720.011';
  static get isArabicLang=>Get.locale!.languageCode=='ar';
  static Future setMechineCode() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      machineCode = iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      machineCode = androidDeviceInfo.id; // unique ID on Android
    }
  }
}
