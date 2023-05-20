import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/pages/prayerTimes/controllers/prayer_time_ctr.dart';
import 'package:zad_almumin/services/theme_service.dart';
import '../../constents/my_colors.dart';
import '../../constents/my_sizes.dart';
import '../../constents/my_texts.dart';

class PrayTmeNextPrayInfo extends GetView<ThemeCtr> {
  PrayTmeNextPrayInfo({super.key});
  PrayerTimeCtr prayerTimeCtr = Get.find<PrayerTimeCtr>();
  @override
  Widget build(BuildContext context) {
    context.theme;
    return Container(
      margin: EdgeInsets.only(top: MySiezes.betweanAzkarBlock),
      decoration: BoxDecoration(
        color: MyColors.background(),
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(color: MyColors.shadow(), blurRadius: 10, offset: Offset(0, 3)),
          BoxShadow(color: MyColors.shadowPrimary(), blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      width: Get.width * .55,
      height: Get.height * .25,
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            MyTexts.normal(
              title: prayerTimeCtr.nextPrayName.value,
              size: 26,
              color: MyColors.second(),
              fontWeight: FontWeight.bold,
            ),
            MyTexts.normal(
              title: prayerTimeCtr.timeLeftToNextPrayTime.value,
              size: 30,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
