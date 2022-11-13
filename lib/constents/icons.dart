// ignore_for_file: non_constant_identifier_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:zad_almumin/services/theme_service.dart';
import 'package:zad_almumin/constents/colors.dart';
import 'package:zad_almumin/constents/sizes.dart';

import '../pages/settings/settings_ctr.dart';

class MyIcons {
  static final SettingsCtr _settingsCtr = Get.find<SettingsCtr>();
  static Icon drawer = Icon(Icons.menu);
  static Icon refresh = Icon(Icons.refresh);
  static Icon copy = Icon(Icons.file_copy_outlined);
  static Icon copyFilled = Icon(Icons.file_copy);
  static Icon share = Icon(Icons.share_outlined);
  static Icon leftArrow = Icon(Icons.arrow_forward_ios_rounded, color: Colors.white);
  static Icon error = Icon(Icons.error_outline, color: Colors.red);
  static Icon ayahsTest = Icon(Icons.menu_book_sharp);
  static Icon person = Icon(Icons.person);
  static Icon shop = Icon(Icons.shopify);
  static Icon delete = Icon(Icons.delete, color: Colors.red);
  static Icon backArrow = Icon(Icons.arrow_forward, size: MySiezes.icon);
  static Icon info = Icon(Icons.info_outline, color: MyColors.info);
  static Icon selectAll = Icon(Icons.select_all);
  static Icon alarm = Icon(Icons.alarm);

  static Icon plus({Color? color, double size = MySiezes.icon}) => Icon(Icons.add, color: color, size: size);
  static Icon minus({Color? color, double size = MySiezes.icon}) =>
      Icon(CupertinoIcons.minus, color: color, size: size);
  static Icon send({Color? color, double size = MySiezes.icon}) => Icon(Icons.send, color: color, size: size);
  static Icon settings({Color? color, double size = MySiezes.icon}) => Icon(Icons.settings, color: color, size: size);
  static Icon moreVert({Color? color, double size = MySiezes.icon}) => Icon(Icons.more_vert, color: color, size: size);
  static Icon repeat({Color? color, double size = MySiezes.icon}) => Icon(Icons.repeat, color: color, size: size);
  static Icon stop({Color? color, double size = MySiezes.icon}) => Icon(Icons.stop, color: color, size: size);
  static Icon close({Color? color, double size = MySiezes.icon}) => Icon(Icons.close, color: color, size: size);
  static Icon home({Color? color, double size = MySiezes.icon}) => Icon(Icons.home, color: color);
  static Icon mark({Color? color, double size = MySiezes.icon}) => Icon(Icons.bookmark_add_sharp, color: color);
  static Icon book({Color? color, double size = MySiezes.icon}) => Icon(Icons.book, color: color);
  static Icon quran({Color? color, double size = MySiezes.icon}) => Icon(CupertinoIcons.book_solid, color: color);
  static Icon azkar({Color? color, double size = MySiezes.icon}) => Icon(Icons.workspace_premium_sharp, color: color);
  static Icon prayersTime({Color? color, double size = MySiezes.icon}) => Icon(CupertinoIcons.timer_fill, color: color);
  static Icon menu({Color? color, double size = MySiezes.icon}) => Icon(Icons.menu_book, color: color, size: size);
  static Icon notification({Color? color, double size = MySiezes.icon}) =>
      Icon(Icons.notification_important, color: color);
  static Icon rightArrow({Color? color, double size = MySiezes.icon}) =>
      Icon(Icons.arrow_back_ios, color: color, size: size);
  static Icon search({Color? color, double size = MySiezes.icon}) =>
      Icon(CupertinoIcons.search, color: color, size: size);
  static Icon favoriteFilled({Color? color, double size = MySiezes.icon}) =>
      Icon(Icons.favorite, color: color, size: size);
  static Icon favorite({Color? color, double size = MySiezes.icon}) =>
      Icon(Icons.favorite_border, color: color, size: size);
  static Icon downArrow({Color? color, double size = MySiezes.icon}) =>
      Icon(Icons.arrow_drop_down, color: color, size: size);
  static Icon done({Color? color = Colors.green, double size = MySiezes.icon}) =>
      Icon(Icons.done, color: color, size: size);

  static Widget animated_Light_Dark({Color? color, double size = MySiezes.icon}) {
    color = color ?? MyColors.primaryDark;
    return AnimatedCrossFade(
      duration: Duration(milliseconds: 500),
      firstChild: Icon(Icons.dark_mode, color: color, size: size),
      secondChild: Icon(Icons.light_mode, color: color, size: size),
      crossFadeState: Get.isDarkMode ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }

  // static Widget animatedIcon_Play_Pause({
  //   required AnimationController animationCtr,
  //   required VoidCallback onTap,
  // }) {
  //   return InkWell(
  //     borderRadius: BorderRadius.circular(100),
  //     onTap: () {
  //       onTap();
  //     },
  //     child: Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(100),
  //         color: MyColors.zikrCard(),
  //         boxShadow: [
  //           BoxShadow(
  //             color: MyColors.black.withOpacity(.6),
  //             blurRadius: 5,
  //             offset: Offset(0, 5),
  //           )
  //         ],
  //       ),
  //       padding: EdgeInsets.all(8),
  //       margin: EdgeInsets.only(left: 8),
  //       child: AnimatedIcon(icon: AnimatedIcons.play_pause, progress: animationCtr),
  //     ),
  //   );
  // }
}
