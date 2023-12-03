import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyColors {
  static Color get primaryLight => Color(0xFF1A644F);
  static Color get primaryDark => Color(0xFF48A27F);
  static Color get primary => Get.isDarkMode ? primaryDark : primaryLight;
  static Color get quranPrimary => primary;

  static Color get secondLight => Color(0xFF2E41F2);
  static Color get secondDark => Color(0xFF6171F7);
  static Color get second => Get.isDarkMode ? secondDark : secondLight;
  static Color get markedAyah => second;

  static Color get backgroundLight => Color(0xFFFFFFFF);
  static Color get backgroundDark => Color(0xff1e1e1e); //0xff1e1e1e
  static Color get background => Get.isDarkMode ? backgroundDark : backgroundLight;

  static Color get correctLight => Color(0xFF28A034);
  static Color get correctDark => Color(0xFF56C557);
  static Color get correct => Get.isDarkMode ? correctDark : correctLight;

  static Color get wrongLight => Color(0xFFCC1A3E);
  static Color get wrongDark => Color(0xFFCC1A3E);
  static Color get wrong => Get.isDarkMode ? wrongDark : wrongLight;

  static Color get white => Color(0xFFFFFFFF);
  static Color get black => Color(0xFF000000);
  static Color get whiteBlack => Get.isDarkMode ? white : black;
  static Color get blackWhite => Get.isDarkMode ? black : white;

  static Color get quranBackGroundLight => Color(0xFFFFFCFA); // Color(0xFFF7EDE3);
  static Color get quranBackGroundDark => Color(0xff1e1e1e);
  static Color get quranBackGround => Get.isDarkMode ? quranBackGroundDark : quranBackGroundLight;

  static Color get quranItemBackGroundLight => Color(0xFFF7EDE3);
  static Color get quranItemBackGroundDark => Color(0xff1e1e1e);
  static Color get quranItemBackGround => Get.isDarkMode ? quranItemBackGroundDark : quranItemBackGroundLight;

  static Color get _zikrCardDark => Color(0xff1e1e1e);
  static Color get _zikrCardLight => Color(0xFFFFFFFF);
  static Color get zikrCard => Get.isDarkMode ? _zikrCardDark : _zikrCardLight;

  static Color get settingsContentLight => Color(0xFF3B3B3B);
  static Color get settingsContentDark => Color.fromARGB(255, 152, 152, 152);
  static Color get settingsContent => Get.isDarkMode ? settingsContentDark : settingsContentLight;

  static Color get contentLight => Color(0xFF000000);
  static Color get contentDark => Color(0xFFFFFFFF);
  static Color get content => Get.isDarkMode ? contentDark : contentLight;

  static Color get settingsTitle => Color(0xFF000000);

  static Color get quranText => Get.isDarkMode ? quranBackGroundLight : black;

  static Color get quranStatus => background;

  static Color get shadowPrimary => primary;
  static Color get lightModeShadow => Color(0xFF3F3F3F);
  static Color get shadow => Get.isDarkMode ? black : lightModeShadow;

  static void setNewPrimaryColor(Color newColor) {}

  static void updatePrimaryColor(int primaryLight, int primaryDark) {
    // _primary = Color(primaryLight);
    // _primaryDark = Color(primaryDark);
  }
}
