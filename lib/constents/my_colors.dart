import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyColors {
  // static final List<Color> primaryColors = [Color.fromARGB(255, 2, 111, 111), Color.fromARGB(255, 172, 17, 94)];
  static const Color backgroundLight = Color(0xFFFFFFFF); //Color(0xffdbe2e7);
  static const Color backgroundDark = Color(0xff222222);
  static const Color _quranPrimary = Color(0xFF0A8468); // Color(0xFFB9791F);
  static const Color _quranPrimaryDark = Color(0xFF0A8468); // Color(0xFFAC7324);
  static const Color quranBackGroundLight = Color(0xFFF7EDE3);
  static const Color quranBackGroundDark = Color(0xFF191919);
  static const Color quranItemBackGroundLight = Color(0xFFF7EDE3);
  static const Color quranItemBackGroundDark = Color(0xFF000000);
// static const Color quranSelectedAyahBackColor = Color(0xFFF7EDE3);
// static const Color quranSelectedAyahBackColorDark = Color(0xFF000000);
  static Color primary_ = Color(0xFF1A644F);
  static Color primaryDark = Color(0xFF0A8468);
  static const Color lightModeShadow = Color(0xFF3F3F3F);
  static const Color second_ = Color(0xFF2AB58D);
  static const Color secondDark = Color(0xFF2AB58D);
  static const Color content = Color(0xFF000000);
  static const Color contentDark = Color(0xFFFFFFFF);
  static const Color info = Color(0xFF2AB58D);
  static const Color settingsTitle = Color(0xFF000000);
  static const Color settingsContent = Color(0xFF3B3B3B);
  static const Color settingsContentDark = Color(0xFF7F8081);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color _zikrCardDark = Color(0xff222222);
  static const Color _zikrCard = Color(0xFFFFFFFF);
  static const Color _trueDark = Color(0xFF2AD540);
  static const Color true_ = Color(0xFF2AD540);
  static const Color false_ = Color(0xFFCB2828);

  static Color background() => Get.isDarkMode ? backgroundDark : backgroundLight;

  static Color whiteBlack() => Get.isDarkMode ? white : black;
  static Color whiteBlackReversed() => Get.isDarkMode ? black : white;

  static Color quranText() => Get.isDarkMode ? quranBackGroundLight : black;
  static Color quranPrimary() => Get.isDarkMode ? _quranPrimaryDark : _quranPrimary;
  static Color quranStatus() => Get.isDarkMode ? Color.fromARGB(255, 0, 0, 0) : Color.fromARGB(255, 210, 195, 174);

  static Color quranBackGround() => Get.isDarkMode ? quranBackGroundDark : quranBackGroundLight;
  static Color quranItemBackGround() => Get.isDarkMode ? quranItemBackGroundDark : quranItemBackGroundLight;
  //static Color quranSelectedAyahBackColor() => Get.isDarkMode ? quranItemBackGroundDark : quranItemBackGroundLight;

  static Color primary() => Get.isDarkMode ? primaryDark : primary_;

  static Color currect() => Get.isDarkMode ? _trueDark : true_;

  static Color second() => Get.isDarkMode ? secondDark : second_;

  static Color shadow() => Get.isDarkMode ? black : black;

  static Color zikrCard() => Get.isDarkMode ? _zikrCardDark : _zikrCard;
  static Color zikrCard2() => Get.isDarkMode ? MyColors.black : MyColors.lightModeShadow;

  static Color shadowPrimary() => Get.isDarkMode ? primaryDark : primary_;
}
