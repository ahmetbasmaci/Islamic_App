import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/constents/my_texts.dart';
import 'package:zad_almumin/services/theme_service.dart';
import '../constents/my_icons.dart';
import '../pages/settings/settings_page.dart';

class MyAppBar extends GetView<ThemeCtr> implements PreferredSizeWidget {
  MyAppBar({
    Key? key,
    required this.title,
    this.leading,
    this.actions,
    this.bottom,
    this.showSettingsBtn = false,
    this.showDrawerBtn = true,
  }) : super(key: key);
  final String title;

  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  bool showSettingsBtn = false;
  bool showDrawerBtn = true;
  @override
  Size get preferredSize {
    return Size.fromHeight(kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    context.theme;
    return AppBar(
      elevation: 0,
      title: MyTexts.outsideHeader(title: title, color: MyColors.primary()),
      leading: leading ??
          (showDrawerBtn
              ? IconButton(onPressed: () => Scaffold.of(context).openDrawer(), icon: MyIcons.drawer)
              : Container()),
      actions: [...actions ?? [], showSettingsBtn ? settingsPageButton() : Container(), backButton(context)],
      bottom: bottom,
    );
  }

  IconButton settingsPageButton() {
    return IconButton(
      onPressed: () =>
          Get.to(() => SettingsPage(), transition: Transition.upToDown, duration: Duration(milliseconds: 200)),
      icon: MyIcons.settings(),
    );
  }

  Widget backButton(BuildContext context) {
    return !ModalRoute.of(context)!.isFirst
        ? IconButton(onPressed: () => Get.back(), icon: MyIcons.backArrow)
        : Container();
  }
}
