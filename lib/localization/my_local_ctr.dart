import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/services/theme_service.dart';

class MyLocalCtr extends GetxController {
//write getter
  String? get _savedLang => GetStorage().read("currentLang");

  Locale get currentLocal => _savedLang == null ? Get.deviceLocale! : Locale(_savedLang ?? "");
  Future<void> updateLanguage(String lang) async {
    GetStorage().write("currentLang", lang);
    Get.find<ThemeCtr>().updateThemes();
    await Get.updateLocale(Locale(lang));
  }
}
