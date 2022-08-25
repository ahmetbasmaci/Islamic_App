
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:zad_almumin/pages/prayerTimesPage/controllers/prayer_time_ctr.dart';
import '../../components/my_app_bar.dart';
import '../../components/my_circular_progress_indecator.dart';
import '../../components/my_drawer.dart';
import '../../constents/colors.dart';
import '../../constents/sizes.dart';
import '../../constents/texts.dart';

import '../../moduls/enums.dart';

class PrayerTimes extends StatefulWidget {
  const PrayerTimes({Key? key}) : super(key: key);
  static String id = 'PrayerTimes';
  @override
  State<PrayerTimes> createState() => _PrayerTimesState();
}

class _PrayerTimesState extends State<PrayerTimes> {
  PrayerTimeCtr prayerTimeCtr = Get.find<PrayerTimeCtr>();
  int hDay = HijriCalendar.fromDate(DateTime.now()).hDay;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: MyAppBar(title: ''),
        drawer: MyDrawer(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: MySiezes.betweanAzkarBlock),
                      decoration: BoxDecoration(
                        color: MyColors.background(),
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(color: MyColors.shadow(), blurRadius: 10, offset: Offset(0, 3)),
                          BoxShadow(color: MyColors.shadowPrimary(), blurRadius: 6, offset: Offset(0, 3)),
                        ],
                      ),
                      width: 170,
                      height: 170,
                      child: Obx(
                        () => Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            MyTexts.normal(
                              context,
                              title: prayerTimeCtr.nextPrayName.value,
                              size: 26,
                              color: MyColors.second(),
                              fontWeight: FontWeight.bold,
                            ),
                            MyTexts.normal(
                              context,
                              title: prayerTimeCtr.timeLeftToNextPrayTime.value,
                              size: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: MySiezes.betweanAzkarBlock),
                    ElevatedButton(
                      onPressed: () async {
                        await prayerTimeCtr.updatePrayerTimes();
                        if(mounted)
                        setState(() {});
                      },
                      child: Text('تحديث'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await prayerTimeCtr.updatePrayerTimes(
                            newTime: prayerTimeCtr.curerntDate.value.add(Duration(days: 1)));

                        setState(() {});
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    IconButton(
                      onPressed: () async {
                        await prayerTimeCtr.updatePrayerTimes(
                            newTime: prayerTimeCtr.curerntDate.value.subtract(Duration(days: 1)));
                        setState(() {});
                      },
                      icon: const Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
                _prayTimeContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _prayTimeContainer() {
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
                  MyTexts.settingsTitle(context, title: 'التاريخ الميلادي'),
                  Obx(
                    () => MyTexts.normal(
                      context,
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
                  MyTexts.settingsTitle(context, title: 'التاريخ الهجري'),
                  Obx(
                    () => MyTexts.normal(
                      context,
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
              MyTexts.settingsTitle(context, title: title),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                child: prayerTimeCtr.isLoading.value
                    ? MyCircularProgressIndecator()
                    : MyTexts.normal(context, title: time, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

