import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyLocalCtr extends GetxController {
//write getter
  String? get _savedLang => GetStorage().read("currentLang");

  Locale get currentLocal => _savedLang == null ? Get.deviceLocale! : Locale(_savedLang ?? "");
  void updateLanguage(String lang) {
    GetStorage().write("currentLang", lang);
    Get.updateLocale(Locale(lang));
  }
}
