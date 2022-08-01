import 'package:flutter/material.dart';
import 'package:zad_almumin/constents/colors.dart';

import '../services/theme_service.dart';

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
      inactiveThumbColor:
          ThemeService().getThemeMode() == ThemeMode.dark ? MyColors.settingsContent : MyColors.background(),
      inactiveTrackColor: ThemeService().getThemeMode() == ThemeMode.dark ? MyColors.black : MyColors.settingsContent,
      onChanged: onChanged,
    );
  }
}
