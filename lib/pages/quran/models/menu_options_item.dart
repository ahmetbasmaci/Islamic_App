import 'package:flutter/material.dart';
import 'package:zad_almumin/moduls/enums.dart';

class MenuOptionsItem {
  MenuOptionsItem(
      {this.child,
      required this.title,
      required this.icon,
      required this.onTap,
      this.isSelected = false,
      this.zikrRepeat = ZikrRepeat.none});
  String title;
  Widget? child;
  Widget icon;
  VoidCallback? onTap;
  bool isSelected;
  ZikrRepeat zikrRepeat;
}
