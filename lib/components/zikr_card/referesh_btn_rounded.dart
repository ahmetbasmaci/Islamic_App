import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/constents/my_icons.dart';
import 'package:zad_almumin/constents/my_sizes.dart';
import 'package:zad_almumin/services/theme_service.dart';

class RefereshBtnRounded extends GetView<ThemeCtr> {
  RefereshBtnRounded({super.key, required this.onPress, this.enabled = true});

  VoidCallback onPress;
  bool enabled;
  @override
  Widget build(BuildContext context) {
    context.theme;
    return AnimatedButton(
      enabled: enabled,
      color: MyColors.zikrCard(),
      width: MySiezes.btnIcon,
      height: MySiezes.btnIcon,
      onPressed: onPress,
      child: MyIcons.refresh,
    );
  }
}
