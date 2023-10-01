import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/main.dart';
import 'package:zad_almumin/moduls/enums.dart';

import '../../services/theme_service.dart';

class SettingsCtr extends GetxController {
  RxBool isNotificationSoundOn = true.obs;
  final getStorage = GetStorage();
  RxString defaultFontMain = MyFonts.uthmanic.name.obs;
  RxString defaultFontQuran = MyFonts.uthmanic.name.obs;
  SettingsCtr() {
    isNotificationSoundOn.value = getStorage.read('isNotificationSoundOn') ?? true;

    defaultFontMain.value = getStorage.read<String>('defaultFontMain') ?? defaultFontMain.value;
    defaultFontQuran.value = getStorage.read<String>('defaultFontQuran') ?? defaultFontQuran.value;
  }
  changeDarkModeState(bool newValue) async {
    Get.find<ThemeCtr>().changeThemeMode(newValue);
  }

  changeNotificationSoundMode(bool newValue) async {
    isNotificationSoundOn.value = newValue;
    getStorage.write('isNotificationSoundOn', newValue);
  }

  changeThemeColor(Color newColor, VoidCallback? setState) async {
    MyColors.setNewPrimaryColor(newColor);

    getStorage.write("primary_", newColor.value);
    getStorage.write("primaryDark", newColor.value);
    Get.find<ThemeCtr>().updateThemes();

    runApp(MyApp());
    await Future.delayed(Duration(milliseconds: 200));
    if (setState != null) setState.call();
  }

  void changeMainFont(String newFont, {VoidCallback? setState}) {
    defaultFontMain.value = newFont;
    getStorage.write('defaultFontMain', defaultFontMain.value);
    fontChanged(setState);
  }

  void changeQuranFont(String newFont, {VoidCallback? setState}) {
    defaultFontQuran.value = newFont;
    getStorage.write('defaultFontQuran', defaultFontQuran.value);
    fontChanged(setState);
  }

  void fontChanged(VoidCallback? setState) async {
    Get.find<ThemeCtr>().updateThemes();

    runApp(MyApp());
    await Future.delayed(Duration(milliseconds: 200));
    if (setState != null) setState.call();
  }
}
