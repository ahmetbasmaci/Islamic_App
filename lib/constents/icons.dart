// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zad_almumin/services/theme_service.dart';
import 'package:zad_almumin/constents/colors.dart';
import 'package:zad_almumin/constents/sizes.dart';

class MyIcons {
  static Icon settings = Icon(Icons.settings);
  static Icon drawer = Icon(Icons.menu);
  static Icon refresh = Icon(Icons.refresh);
  static Icon copy = Icon(Icons.file_copy_outlined);
  static Icon copyFilled = Icon(Icons.file_copy);
  static Icon share = Icon(Icons.share_outlined);
  static Icon favorite = Icon(Icons.favorite_border);
  static Icon favoriteFilled = Icon(Icons.favorite);
  static Icon leftArrow = Icon(Icons.arrow_forward_ios_rounded, color: Colors.white);
  static Icon error = Icon(Icons.error_outline, color: Colors.red);
  static Icon notification = Icon(Icons.notification_add);
  static Icon ayahsTest = Icon(Icons.menu_book_sharp);
  static Icon person = Icon(Icons.person);
  static Icon home = Icon(Icons.home);
  static Icon shop = Icon(Icons.shopify);
  static Icon delete = Icon(Icons.delete, color: Colors.red);
  static Icon backArrow = Icon(Icons.arrow_forward, size: MySiezes.icon);
  static Icon info = Icon(Icons.info_outline, color: MyColors.info);
  static Icon selectAll = Icon(Icons.select_all);
  static Icon alarm = Icon(Icons.alarm);
  static Icon prayersTime = Icon(CupertinoIcons.timer_fill);

  static Icon rightArrow({Color? color, double size = MySiezes.icon}) {
    return Icon(Icons.arrow_back_ios, color: color, size: size);
  }

  static Icon downArrow({Color? color, double size = MySiezes.icon}) {
    return Icon(Icons.arrow_drop_down, color: color, size: size);
  }

  static Icon menu({Color? color, double size = MySiezes.icon}) {
    color = ThemeService().getThemeMode() == ThemeMode.dark ? MyColors.primaryDark : MyColors.primary;
    return Icon(Icons.menu_book, color: color, size: size);
  }

  static Icon done({Color? color = Colors.green, double size = MySiezes.icon}) {
    return Icon(Icons.done, color: color, size: size);
  }

  static Widget animated_Light_Dark({Color? color = MyColors.primaryDark, double size = MySiezes.icon}) {
    return AnimatedCrossFade(
      duration: Duration(milliseconds: 500),
      firstChild: Icon(Icons.dark_mode, color: color, size: size),
      secondChild: Icon(Icons.light_mode, color: color, size: size),
      crossFadeState:
          ThemeService().getThemeMode() == ThemeMode.dark ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }

  static Widget animatedIcon_Play_Pause(
      {required AnimationController animationCtr, required VoidCallback onTap, Color? color, double? size}) {
    color = ThemeService().getThemeMode() == ThemeMode.dark ? MyColors.primaryDark : MyColors.primary;
    size = MySiezes.icon;

    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: ThemeService().getThemeMode() == ThemeMode.dark ? MyColors.zikrCardDark : MyColors.zikrCard,
          boxShadow: [
            BoxShadow(
              color: ThemeService().getThemeMode() == ThemeMode.dark
                  ? MyColors.black.withOpacity(.5)
                  : MyColors.black.withOpacity(.6),
              blurRadius: 5,
              offset: Offset(0, 5),
            )
          ],
        ),
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(left: 8),
        child: AnimatedIcon(icon: AnimatedIcons.play_pause, progress: animationCtr, size: size),
      ),
    );
  }
}
