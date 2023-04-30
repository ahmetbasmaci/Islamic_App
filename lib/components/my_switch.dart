import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/my_colors.dart';

class MySwitch extends StatelessWidget {
  const MySwitch(
      {Key? key,
      required this.value,
      // required this.activeColor,
      // required this.inactiveColor,
      // required this.activeTrackColor,
      // required this.inactiveTrackColor,
      required this.onChanged})
      : super(key: key);
  final bool value;
  // final Color activeColor;
  // final Color inactiveColor;
  // final Color activeTrackColor;
  // final Color inactiveTrackColor;
  final void Function(bool) onChanged;
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      activeColor: MyColors.primary(),
      activeTrackColor: MyColors.primary(),
      inactiveThumbColor: Get.isDarkMode ? MyColors.settingsContent : MyColors.background(),
      inactiveTrackColor: Get.isDarkMode ? MyColors.black : MyColors.settingsContent,
      onChanged: onChanged,
    );
  }
}
