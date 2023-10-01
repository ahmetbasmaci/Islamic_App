import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constents/my_colors.dart';
import '../../constents/my_sizes.dart';
import '../../services/theme_service.dart';

class AlarmCard extends GetView<ThemeCtr> {
  AlarmCard({required this.child});
  Widget child;
  @override
  Widget build(BuildContext context) {
    context.theme;
    return Container(
      margin: EdgeInsets.all(MySiezes.cardPadding),
      decoration: BoxDecoration(
        color: MyColors.background,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: child,
    );
  }
}
