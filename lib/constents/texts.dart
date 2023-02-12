import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/constents.dart';

import 'colors.dart';

class MyTexts {
  static BuildContext context = Constants.navigatorKey.currentState!.context;
  static Text outsideHeader({required String title, Color? color}) {
    return Text(
      title,
      style: Theme.of(Get.context ?? context)
          .textTheme
          .headline6!
          .copyWith(fontSize: 18, color: color ?? MyColors.primary()),
    );
  }

  static Text zikrTitle({required String title}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline2,
      textAlign: TextAlign.center,
    );
  }

  static Text blockTitle({required String title}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline3,
    );
  }

  static Text content({required String title, double? size, Color? color}) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: size, color: color),
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
      style: Theme.of(context).textTheme.headline1!.copyWith(fontWeight: fontWeight, color: color, fontSize: size),
    );
  }

  static Text info({required String title}) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyText2,
    );
  }

  static Text normal({required String title, Color? color, double? size, FontWeight? fontWeight}) {
    return Text(
      title,
      // textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.subtitle2!.copyWith(color: color, fontSize: size, fontWeight: fontWeight),
    );
  }

  static Text settingsTitle({required String title, Color? color, double? size}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline4!.copyWith(color: color, fontSize: size),
    );
  }

  static Text settingsContent({required String title}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  static Text drawerTitle({required String title}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline6,
    );
  }

  static Text dropDownMenuItem({required String title}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.subtitle1,
    );
  }

  static Text dropDownMenuTitle({required String title}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.subtitle2,
    );
  }

  static Text quranSecondTitle({required String title, double? size, FontWeight? fontWeight}) {
    return Text(
      title,
      textAlign: TextAlign.right,
      style: TextStyle(
        color: MyColors.quranPrimary(),
        fontSize: size ?? 16,
        fontWeight: fontWeight,
      ),
    );
  }
}
