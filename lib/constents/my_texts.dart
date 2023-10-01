import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/app_settings.dart';

import 'my_colors.dart';

class MyTexts {
  //static BuildContext context = AppSettings.navigatorKey.currentState!.context;

  static Text outsideHeader({String title = "", TextAlign? textAlign, Color? color}) {
    return Text(
      title,
      textAlign: textAlign,
      style: Get.textTheme.titleLarge!.copyWith(color: color),
    );
  }

  static Text zikrTitle({String title = "", Color? color}) {
    return Text(
      title,
      style: Get.textTheme.bodyMedium!.copyWith(color: color),
      textAlign: TextAlign.center,
    );
  }

  static Text blockTitle({String title = "", Color? color}) {
    return Text(
      title,
      style: Get.textTheme.bodyLarge!.copyWith(color: color),
    );
  }

  static Text content({String title = "", double? size, TextAlign? textAlign, FontWeight? fontWeight, Color? color}) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.center,
      style: Get.textTheme.displaySmall!.copyWith(fontWeight: fontWeight, color: color),
    );
  }

  static Text main({
    String title = "",
    TextAlign textAlign = TextAlign.center,
    TextOverflow? overflow,
    FontWeight? fontWeight,
    Color? color,
    double? size,
    String? fontFamily,
  }) {
    return Text(
      title,
      textAlign: textAlign,
      overflow: overflow,
      style: Get.textTheme.bodySmall!.copyWith(fontWeight: fontWeight, color: color, fontFamily: fontFamily),
    );
  }

  static Text quran({
    String title = "",
    TextAlign textAlign = TextAlign.center,
    TextOverflow? overflow,
    FontWeight? fontWeight,
    Color? color,
    double? fontSize,
  }) {
    return Text(
      title,
      textAlign: textAlign,
      overflow: overflow,
      style: Get.textTheme.titleMedium!.copyWith(fontWeight: fontWeight, color: color, fontSize: fontSize),
    );
  }

  static Text info({String title = ""}) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: Get.textTheme.displayMedium,
    );
  }

  static Text settingsTitle({String title = "", Color? color, double? size}) {
    return Text(
      title,
      textAlign: AppSettings.isArabicLang ? TextAlign.right : TextAlign.left,
      style: Get.textTheme.labelSmall!.copyWith(
        color: color,
        // fontSize: size,
      ),
    );
  }

  static Text settingsContent({String title = ""}) {
    return Text(
      title,
      style: Get.textTheme.labelMedium,
    );
  }

  static Text drawerTitle({String title = ""}) {
    return Text(
      title,
      style: Get.textTheme.labelLarge,
    );
  }

  static Text dropDownMenuItem(
      {String title = "", required, double size = 17, FontWeight? fontWeight = FontWeight.normal}) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: Get.textTheme.displayLarge!.copyWith(fontWeight: fontWeight, fontSize: size),
    );
  }

  static Text dropDownMenuTitle({String title = "", double? size, FontWeight? fontWeight}) {
    return Text(
      title,
      style: Get.textTheme.titleSmall!.copyWith(fontWeight: fontWeight),
    );
  }

  static Text quranSecondTitle({String title = "", double? size, FontWeight? fontWeight, Color? color}) {
    return main(
        title: title, size: size, fontWeight: fontWeight, color: color ?? MyColors.primary, textAlign: TextAlign.right);
    // Text(
    //   title,
    //   textAlign: TextAlign.right,
    //   style: Get.textTheme.bodySmall!.copyWith(fontWeight: fontWeight, color: color, fontSize: size),
    // );
  }

  static TextStyle quranStyle({
    double? fontSize,
    Color? color,
  }) {
    return MyTexts.quran().style!.copyWith(fontSize: fontSize, color: color);
  }

  static TextStyle mainStyle() {
    return MyTexts.main().style!.copyWith();
  }
}
