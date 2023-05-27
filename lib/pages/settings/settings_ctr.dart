import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/classes/helper_methods.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/main.dart';
import 'package:zad_almumin/moduls/enums.dart';

import '../../services/theme_service.dart';

class SettingsCtr extends GetxController {
  RxBool isNotificationSoundOn = true.obs;
  final getStorage = GetStorage();

  var defaultFont = MyFonts.uthmanic.name;
  SettingsCtr() {
    // isDarkMode.value = getStorage.read('isDarkMode') ?? false;

    isNotificationSoundOn.value = getStorage.read('isNotificationSoundOn') ?? true;

    int primaryColor = getStorage.read<int>('primary_') ?? MyColors.primary_.value;
    int primaryDarkColor = getStorage.read<int>('primaryDark') ?? MyColors.primaryDark.value;
    MyColors.primary_ = Color(primaryColor);
    MyColors.primaryDark = Color(primaryDarkColor);

    defaultFont = getStorage.read<String>('defaultFont') ?? defaultFont;
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

  changeFont(String newFont, VoidCallback setState) async {
    defaultFont = newFont;
    getStorage.write('defaultFont', defaultFont);
    Get.find<ThemeCtr>().updateThemes();

    runApp(MyApp());
    await Future.delayed(Duration(milliseconds: 100));
    setState.call();
    // Get.offAll(() => HelperMethods.getNewOpendPage(), transition: Transition.fadeIn);
  }
}
