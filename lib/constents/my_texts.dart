import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/app_settings.dart';

import 'my_colors.dart';

class MyTexts {
  static BuildContext context = AppSettings.navigatorKey.currentState!.context;

  static Text outsideHeader({required String title, TextAlign? textAlign, Color? color}) {
    return Text(
      title,
      textAlign: textAlign,
      style: Theme.of(Get.context ?? context)
          .textTheme
          .labelLarge!
          .copyWith(fontSize: 18, color: color ?? MyColors.primary()),
    );
  }

  static Text zikrTitle({required String title, Color? color}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: color),
      textAlign: TextAlign.center,
    );
  }

  static Text blockTitle({required String title}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  static Text content(
      {required String title, double? size, TextAlign? textAlign, FontWeight? fontWeight, Color? color}) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.center,
      style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: fontWeight, fontSize: size, color: color),
    );
  }

  static Text main({
    required String title,
    TextAlign textAlign = TextAlign.center,
    TextOverflow? overflow,
    FontWeight? fontWeight,
    Color? color,
    double? size,
  }) {
    return Text(
      title,
      textAlign: textAlign,
      overflow: overflow,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: fontWeight, color: color, fontSize: size),
    );
  }

  static Text quran({
    required String title,
    TextAlign textAlign = TextAlign.center,
    TextOverflow? overflow,
    FontWeight? fontWeight,
    Color? color,
    double? size,
  }) {
    return Text(
      title,
      textAlign: textAlign,
      overflow: overflow,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: fontWeight, color: color, fontSize: size),
    );
  }

  static Text info({required String title}) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.displayMedium,
    );
  }

  static Text settingsTitle({required String title, Color? color, double? size}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.labelSmall!.copyWith(color: color, fontSize: size),
    );
  }

  static Text settingsContent({required String title}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.labelMedium,
    );
  }

  static Text drawerTitle({required String title}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.labelLarge,
    );
  }

  static Text dropDownMenuItem({required String title, required, double size = 20, FontWeight? fontWeight}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.displayLarge!.copyWith(fontWeight: fontWeight, fontSize: size),
    );
  }

  static Text dropDownMenuTitle({required String title, double? size, FontWeight? fontWeight}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: fontWeight, fontSize: size),
    );
  }

  static Text quranSecondTitle({required String title, double? size, FontWeight? fontWeight, Color? color}) {
    return Text(
      title,
      textAlign: TextAlign.right,

      style: Theme.of(context)
          .textTheme
          .bodySmall!
          .copyWith(fontWeight: fontWeight, color: color ?? MyColors.quranPrimary(), fontSize: size),
      // TextStyle(
      //   color: MyColors.quranPrimary(),
      //   fontSize: size ?? 16,
      //   fontWeight: fontWeight,
      // ),
    );
  }
}
