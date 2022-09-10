import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/services/theme_service.dart';

import '../pages/settings_page.dart';

class MyColors {
  static final SettingsCtr _settingsCtr = Get.find<SettingsCtr>();

  // static const Color backgroundLight = Color.fromARGB(255, 241, 240, 228);
  static const Color backgroundLight = Color(0xffdbe2e7);
  // static const Color backgroundDark = Color.fromARGB(255, 34, 34, 34);
  static const Color backgroundDark = Color(0xff222222);
  static const Color _quranSecond = Color.fromARGB(255, 185, 121, 31);
  static const Color _quranSecondDark = Color.fromARGB(255, 172, 115, 36);
  static const Color quranBackGroundLight = Color.fromARGB(255, 239, 237, 227);
  static const Color quranBackGroundDark = Color.fromARGB(255, 25, 25, 25);
  static const Color quranItemBackGroundLight = Color.fromARGB(255, 239, 237, 227);
  static const Color quranItemBackGroundDark = Color.fromARGB(255, 0, 0, 0);
  static const Color primary_ = Color.fromARGB(255, 2, 111, 111);
  static const Color primaryDark = Color.fromARGB(255, 2, 111, 111);
  static const Color lightModeShadow = Color.fromARGB(255, 63, 63, 63);
  static const Color second_ = Color.fromARGB(255, 223, 40, 40);
  static const Color secondDark = Color.fromARGB(255, 223, 40, 40);
  static const Color content = Color.fromARGB(255, 0, 0, 0);
  static const Color contentDark = Color.fromARGB(255, 255, 255, 255);
  static const Color info = Color(0xfff68162);
  static const Color settingsTitle = Color(0xff000000);
  static const Color settingsContent = Color.fromARGB(255, 59, 59, 59);
  static const Color settingsContentDark = Color(0xff7f8081);
  static const Color white = Color(0xffffffff);
  static const Color black = Color.fromARGB(255, 0, 0, 0);
  static const Color _zikrCardDark = Color(0xff293539);
  static const Color _zikrCard = Color.fromARGB(255, 243, 243, 243);
  static const Color true_ = Color.fromARGB(255, 37, 159, 53);
  static const Color _trueDark = Color.fromARGB(255, 19, 85, 16);
  static const Color false_ = Color.fromARGB(255, 203, 40, 40);

  static Color background() => ThemeService().getThemeMode() == ThemeMode.dark ? backgroundDark : backgroundLight;

  static Color whiteBlack() => ThemeService().getThemeMode() == ThemeMode.dark ? white : black;

  static Color quranText() => ThemeService().getThemeMode() == ThemeMode.dark ? quranBackGroundLight : black;
  static Color quranSecond() => ThemeService().getThemeMode() == ThemeMode.dark ? _quranSecondDark : _quranSecond;
  static Color quranStatus() => ThemeService().getThemeMode() == ThemeMode.dark
      ? Color.fromARGB(255, 0, 0, 0)
      : Color.fromARGB(255, 210, 195, 174);

  static Color quranBackGround() =>
      ThemeService().getThemeMode() == ThemeMode.dark ? quranBackGroundDark : quranBackGroundLight;
  static Color quranItemBackGround() =>
      ThemeService().getThemeMode() == ThemeMode.dark ? quranItemBackGroundDark : quranItemBackGroundLight;

  static Color primary() => ThemeService().getThemeMode() == ThemeMode.dark ? primaryDark : primary_;

  static Color currect() => ThemeService().getThemeMode() == ThemeMode.dark ? _trueDark : true_;

  static Color second() => ThemeService().getThemeMode() == ThemeMode.dark ? secondDark : second_;

  static Color shadow() => ThemeService().getThemeMode() == ThemeMode.dark ? black : black;

  static Color zikrCard() => _settingsCtr.isDarkMode.value ? _zikrCardDark : _zikrCard;

  static Color shadowPrimary() => ThemeService().getThemeMode() == ThemeMode.dark ? primaryDark : primary_;
}
