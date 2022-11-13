import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/texts.dart';
import '../constents/icons.dart';
import '../pages/settings/settings_page.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key, required this.title, this.leading, this.actions, this.bottom}) : super(key: key);
  final String title;

  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  @override
  Size get preferredSize {
    return Size.fromHeight(kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        title: MyTexts.outsideHeader(title: title),
        leading: leading ?? IconButton(onPressed: () => Scaffold.of(context).openDrawer(), icon: MyIcons.drawer),
        actions: [...actions ?? [], settingsPageButton(), backButton(context)],
        bottom: bottom);
  }

  IconButton settingsPageButton() {
    return IconButton(
      onPressed: () =>
          Get.to(() => SettingsPage(), transition: Transition.upToDown, duration: Duration(milliseconds: 500)),
      icon: MyIcons.settings(),
    );
  }

  Widget backButton(BuildContext context) {
    return !ModalRoute.of(context)!.isFirst
        ? IconButton(onPressed: () => Get.back(), icon: MyIcons.backArrow)
        : Container();
  }
}
