import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/constents/colors.dart';

import '../../services/theme_service.dart';

class SettingsCtr extends GetxController {
  RxBool isNotificationSoundOn = true.obs;
  final getStorage = GetStorage();
  SettingsCtr() {
    // isDarkMode.value = getStorage.read('isDarkMode') ?? false;

    isNotificationSoundOn.value = getStorage.read('isNotificationSoundOn') ?? true;

    int primaryColor = getStorage.read<int>('primary_') ?? MyColors.primary_.value;
    int primaryDarkColor = getStorage.read<int>('primaryDark') ?? MyColors.primary_.value;
    MyColors.primary_ = Color(primaryColor);
    MyColors.primaryDark = Color(primaryDarkColor);
  }
  changeDarkModeState(bool newValue) async {
    // isDarkMode.value = newValue;
    Get.find<ThemeCtr>().changeThemeMode(newValue);
  }
  changeNotificationSoundMode(bool newValue) async {
    isNotificationSoundOn.value = newValue;
    getStorage.write('isNotificationSoundOn', newValue);
  }
  changeThemeColor(Color newColor) {
    MyColors.primary_ = newColor;
    MyColors.primaryDark = newColor;

    getStorage.write("primary_", newColor.value);
    getStorage.write("primaryDark", newColor.value);
    Get.find<ThemeCtr>().updateThemes();
  }
}
