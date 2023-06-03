import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/constents/my_texts.dart';
import 'package:zad_almumin/pages/settings/settings_ctr.dart';

class ZikrCountWidget extends GetView<SettingsCtr> {
  ZikrCountWidget({super.key, required this.title});
  String title;
  @override
  Widget build(BuildContext context) {
    context.theme;
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: Get.width * .2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          topRight: Radius.circular(100),
          bottomLeft: Radius.circular(10),
        ),
        color: MyColors.zikrCard(),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: MyColors.primary().withOpacity(.2),
            blurRadius: 5,
          ),
        ],
      ),
      child: MyTexts.zikrTitle(title: title,color:MyColors.whiteBlack()),
    );
  }
}
