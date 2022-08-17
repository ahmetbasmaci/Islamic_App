import 'package:flutter/material.dart';

import 'colors.dart';

class MyTexts {
  static Text outsideHeader(BuildContext context, {required String title}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline1,
    );
  }

  static Text zikrTitle(BuildContext context, {required String title}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline2,
      textAlign: TextAlign.center,
    );
  }

  static Text blockTitle(BuildContext context, {required String title}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline3,
    );
  }

  static Text content(BuildContext context, {required String title}) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyText1,
    );
  }

  static Text info(BuildContext context, {required String title}) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyText2,
    );
  }

  static Text normal(BuildContext context, {required String title, Color? color,double ?size,FontWeight? fontWeight}) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.subtitle2!.copyWith(color: color,fontSize: size,fontWeight: fontWeight),
    );
  }

  static Text settingsTitle(BuildContext context, {required String title}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline4,
    );
  }

  static Text settingsContent(BuildContext context, {required String title}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  static Text drawerTitle(BuildContext context, {required String title}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline6,
    );
  }

  static Text dropDownMenuItem(BuildContext context, {required String title}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.subtitle1,
    );
  }

  static Text dropDownMenuTitle(BuildContext context, {required String title}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.subtitle2,
    );
  }
  static Text quranSecondTitle(BuildContext context, {required String title,double?size}) {
    return Text(
      title,
     style: TextStyle(color: MyColors.quranSecond(), fontSize: size??16, fontWeight: FontWeight.bold),
    );
  }
}
