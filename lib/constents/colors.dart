import 'package:flutter/material.dart';
import 'package:zad_almumin/services/theme_service.dart';

class MyColors {
  // static const Color backgroundLight = Color.fromARGB(255, 241, 240, 228);
  static const Color backgroundLight = Color(0xffdbe2e7);
  static const Color backgroundDark = Color.fromARGB(255, 30, 30, 30);
  static const Color quranBackGroundLight = Color.fromARGB(255, 235, 235, 235);
  static const Color quranBackGroundDark = Color.fromARGB(255, 53, 53, 53);
  static const Color primary_ = Color.fromARGB(255, 2, 111, 111);
  static const Color primaryDark = Color.fromARGB(255, 58, 126, 143);
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
  static const Color _zikrCardDark = Color.fromARGB(255, 37, 37, 37);
  static const Color _zikrCard = Color.fromARGB(255, 243, 243, 243);
  static const Color true_ = Color.fromARGB(255, 37, 159, 53);
  static const Color _trueDark = Color.fromARGB(255, 19, 85, 16);
  static const Color false_ = Color.fromARGB(255, 203, 40, 40);

  static Color background() {
    return ThemeService().getThemeMode() == ThemeMode.dark ? backgroundDark : backgroundLight;
  }

  static Color whiteBlack() {
    return ThemeService().getThemeMode() == ThemeMode.dark ? black : white;
  }

  static Color quranBackGround() {
    return ThemeService().getThemeMode() == ThemeMode.dark ? quranBackGroundDark : quranBackGroundLight;
  }

  static Color primary() {
    return ThemeService().getThemeMode() == ThemeMode.dark ? primaryDark : primary_;
  }

  static Color currect() {
    return ThemeService().getThemeMode() == ThemeMode.dark ? _trueDark : true_;
  }

  static Color second() {
    return ThemeService().getThemeMode() == ThemeMode.dark ? secondDark : second_;
  }

  static Color shadow() {
    return ThemeService().getThemeMode() == ThemeMode.dark ? black : black;
  }

  static Color zikrCard() {
    return ThemeService().getThemeMode() == ThemeMode.dark ? _zikrCardDark : _zikrCard;
  }

  static Color shadowPrimary() {
    return ThemeService().getThemeMode() == ThemeMode.dark ? primaryDark : primary_;
  }
}
