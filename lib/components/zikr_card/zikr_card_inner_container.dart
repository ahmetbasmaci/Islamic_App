// ignore_for_file:

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/classes/zikr_data.dart';
import 'package:zad_almumin/components/zikr_card/zikr_block_buttons.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/constents/my_icons.dart';
import 'package:zad_almumin/constents/my_sizes.dart';
import 'package:zad_almumin/constents/my_texts.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/services/audio_ctr.dart';
import 'package:zad_almumin/services/theme_service.dart';

class ZikrCardInnerContainer extends GetView<ThemeCtr> {
  ZikrCardInnerContainer({
    required this.zikrData,
    this.rigthTopChild,
    this.leftTopChild,
    this.onDeleteFromFavorite,
  });
  ZikrData zikrData;
  Widget? rigthTopChild;
  Widget? leftTopChild;
  VoidCallback? onDeleteFromFavorite;
  AudioCtr audioCtr = Get.find<AudioCtr>();
  @override
  Widget build(BuildContext context) {
    context.theme;
    return Container(
      padding: EdgeInsets.all(MySiezes.cardPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MySiezes.blockRadius),
        color: MyColors.zikrCard(),
        boxShadow: [
          // BoxShadow(color: Colors.black.withOpacity(.5), blurRadius: 10, offset: Offset(0, 5)),
          //BoxShadow(color: MyColors.primary().withOpacity(.5), blurRadius: 5, offset: Offset(0, 0)),
          // BoxShadow(color: MyColors.primary().withOpacity(0.1), blurRadius: 40, spreadRadius: 10),
          BoxShadow(color: MyColors.black.withOpacity(0.2), blurRadius: 20, spreadRadius: 2)
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              rigthTopChild ?? SizedBox(width: Get.width * .1),
              SizedBox(width: Get.width * .1),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyTexts.zikrTitle(title: zikrData.title),
                  zikrData.zikrType == ZikrType.quran
                      ? SizedBox(
                          // width: 50,
                          child: Obx(
                            () => LinearProgressIndicator(
                              value: audioCtr.slider.value,
                              valueColor: AlwaysStoppedAnimation<Color>(MyColors.primary()),
                              backgroundColor: MyColors.background(),
                            ),
                          ),
                        )
                      : Container()
                ],
              )),
              SizedBox(width: Get.width * .1),
              leftTopChild ?? SizedBox(width: Get.width * .1),
            ],
          ),
          MyTexts.main(title: zikrData.content),
          zikrData.description != ''
              ? Row(children: [MyIcons.info, Expanded(child: MyTexts.info(title: zikrData.description))])
              : Container(),
          ZikrBlockButtons(zikrData: zikrData, onDeleteFromFavorite: onDeleteFromFavorite)
        ],
      ),
    );
  }
}
