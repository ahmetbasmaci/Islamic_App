import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/constents/my_icons.dart';
import 'package:zad_almumin/services/theme_service.dart';

class RefereshBtnRounded extends GetView<ThemeCtr> {
  RefereshBtnRounded({super.key, required this.onPress, this.enabled = true});

  VoidCallback onPress;
  bool enabled;
  @override
  Widget build(BuildContext context) {
    context.theme;
    return IconButton(
      color: MyColors.primary,
      highlightColor: Colors.transparent,
      onPressed: enabled ? onPress : null,
      icon: MyIcons.refresh,
    );
  }
}
