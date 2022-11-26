import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/classes/zikr_data.dart';
import 'package:zad_almumin/components/zikr_block_buttons.dart';
import 'package:zad_almumin/constents/colors.dart';
import 'package:zad_almumin/constents/icons.dart';
import 'package:zad_almumin/constents/sizes.dart';
import 'package:zad_almumin/constents/texts.dart';
import 'package:zad_almumin/services/theme_service.dart';

class ZikrCardInnerContainer extends GetView<ThemeCtr> {
  ZikrCardInnerContainer({
    required this.zikrData,
    this.firstChild,
    this.secondChild,
    this.onDeleteFromFavorite,
  });
  ZikrData zikrData;
  Widget? firstChild;
  Widget? secondChild;
  VoidCallback? onDeleteFromFavorite;
  @override
  Widget build(BuildContext context) {
    context.theme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MySiezes.blockRadius),
        color: MyColors.zikrCard(),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.5), blurRadius: 10, offset: Offset(0, 5)),
          BoxShadow(color: MyColors.primary().withOpacity(.5), blurRadius: 5, offset: Offset(0, 0)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              firstChild ?? Container(),
              Expanded(child: Center(child: MyTexts.zikrTitle(title: zikrData.title))),
              secondChild ?? Container(),
            ],
          ),
          MyTexts.quran(title: zikrData.content),
          zikrData.description != ''
              ? Row(children: [MyIcons.info, Expanded(child: MyTexts.info(title: zikrData.description))])
              : Container(),
          ZikrBlockButtons(zikrData: zikrData, onDeleteFromFavorite: onDeleteFromFavorite)
        ],
      ),
    );
  }
}
