import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';

import '../../components/my_circular_progress_indecator.dart';
import '../../constents/my_colors.dart';
import '../../constents/my_sizes.dart';
import '../../constents/my_texts.dart';
import '../../moduls/enums.dart';
import '../../services/theme_service.dart';
import 'controllers/prayer_time_ctr.dart';

class PrayTimesInfo extends GetView<ThemeCtr> {
  PrayTimesInfo({super.key});
  PrayerTimeCtr prayerTimeCtr = Get.find<PrayerTimeCtr>();
  @override
  Widget build(BuildContext context) {
    context.theme;
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(color: MyColors.zikrCard(), borderRadius: BorderRadius.circular(20)),
      // height: 400,
      // height: double.maxFinite,

      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  MyTexts.settingsTitle(title: 'التاريخ الميلادي'),
                  Obx(
                    () => MyTexts.normal(
                      title:
                          '${prayerTimeCtr.curerntDate.value.year}-${prayerTimeCtr.curerntDate.value.month}-${prayerTimeCtr.curerntDate.value.day}',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  MyTexts.settingsTitle(title: 'التاريخ الهجري'),
                  Obx(
                    () => MyTexts.normal(
                      title:
                          '${HijriCalendar.fromDate(prayerTimeCtr.curerntDate.value).hYear}-${HijriCalendar.fromDate(prayerTimeCtr.curerntDate.value).hMonth}-${HijriCalendar.fromDate(prayerTimeCtr.curerntDate.value).hDay}',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(thickness: 2),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: MySiezes.betweanAzkarBlock),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  prayerTime(prayerTimeType: PrayerTimeType.fajr),
                  prayerTime(prayerTimeType: PrayerTimeType.sun),
                  prayerTime(prayerTimeType: PrayerTimeType.duhr),
                ],
              ),
              SizedBox(height: MySiezes.betweanAzkarBlock),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  prayerTime(prayerTimeType: PrayerTimeType.asr),
                  prayerTime(prayerTimeType: PrayerTimeType.maghrib),
                  prayerTime(prayerTimeType: PrayerTimeType.isha),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget prayerTime({required PrayerTimeType prayerTimeType}) {
    String title = '';
    String time = '';
    if (prayerTimeType == PrayerTimeType.fajr) {
      title = 'الفجر';
      time = '${prayerTimeCtr.fajrTime.value.hour}:${prayerTimeCtr.fajrTime.value.minute}';
    } else if (prayerTimeType == PrayerTimeType.sun) {
      title = 'شروق الشمس';
      time = '${prayerTimeCtr.sunTime.value.hour}:${prayerTimeCtr.sunTime.value.minute}';
    } else if (prayerTimeType == PrayerTimeType.duhr) {
      title = 'الظهر';
      time = '${prayerTimeCtr.duhrTime.value.hour}:${prayerTimeCtr.duhrTime.value.minute}';
    } else if (prayerTimeType == PrayerTimeType.asr) {
      title = 'العصر';
      time = '${prayerTimeCtr.asrTime.value.hour}:${prayerTimeCtr.asrTime.value.minute}';
    } else if (prayerTimeType == PrayerTimeType.maghrib) {
      title = 'المغرب';
      time = '${prayerTimeCtr.maghribTime.value.hour}:${prayerTimeCtr.maghribTime.value.minute}';
    } else if (prayerTimeType == PrayerTimeType.isha) {
      title = 'العشاء';
      time = '${prayerTimeCtr.ishaTime.value.hour}:${prayerTimeCtr.ishaTime.value.minute}';
    }

    return Obx(
      () => Expanded(
        child: Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.symmetric(horizontal: 5),
          decoration: prayerTimeType == prayerTimeCtr.nextPrayType.value && //check if the prayer is the next prayer
                  !prayerTimeCtr.isLoading.value && // check if loading when getting data
                  prayerTimeCtr.curerntDate.value.day == DateTime.now().day //check if today
              ? BoxDecoration(
                  color: MyColors.zikrCard(),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: MyColors.shadow(), blurRadius: 10, offset: Offset(0, 3))],
                )
              : BoxDecoration(),
          child: Column(
            children: [
              MyTexts.settingsTitle(title: title),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                child: prayerTimeCtr.isLoading.value
                    ? MyCircularProgressIndecator()
                    : MyTexts.normal(title: time, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
