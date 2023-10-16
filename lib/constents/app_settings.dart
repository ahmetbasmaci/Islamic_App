import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'my_colors.dart';

class AppSettings {
  AppSettings() {
    setFileDir();
  }
  static SystemUiOverlayStyle systemUiOverlayStyleQuran = SystemUiOverlayStyle(
    statusBarColor: MyColors.quranStatus,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: MyColors.quranStatus,
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
  static String basmalahTxt = "بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ";
  static FocusScopeNode focusScopeNode = FocusScopeNode();
  static NumberFormat formatInt3 = NumberFormat('000');
  static NumberFormat formatInt2 = NumberFormat('00');

  static double quranUpPartHeight = Get.size.height * .05;

  static String machineCode = '';
  static String developerMachineCode = 'RP1A.200720.011';
  static bool get isArabicLang => Get.locale!.languageCode == 'ar';
  static String get selectedLangCode => Get.locale!.languageCode;

  void setFileDir() async => filesDir = (await getApplicationDocumentsDirectory()).path;
  static String filesDir = "";

  static Future setMechineCode() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      machineCode = iosDeviceInfo.identifierForVendor!; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      machineCode = androidDeviceInfo.id; // unique ID on Android
    }
    //TODO create immutable class for device info
    print((await deviceInfo.androidInfo));
    print((await deviceInfo.androidInfo).id);
    print((await deviceInfo.androidInfo).model);
  }

  //write method take arabic name  as paraemter and return that string without every tashkil char and hamza
  static String removeTashkil(String text) {
    String withOutTashkill = text
        .replaceAll('َ', '')
        .replaceAll('ً', '')
        .replaceAll('ُ', '')
        .replaceAll('ٌ', '')
        .replaceAll('ِ', '')
        .replaceAll('ٍ', '')
        .replaceAll('ْ', '')
        .replaceAll('ّ', '')
        .replaceAll('ٰ', '')
        .replaceAll('ۡ', '')
        .replaceAll('ٓ', '')
        .replaceAll('آ', 'ا')
        .replaceAll('ٱ', 'ا');
    return withOutTashkill;
  }
}
