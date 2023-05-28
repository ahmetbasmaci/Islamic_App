import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:zad_almumin/pages/prayerTimes/controllers/prayer_time_ctr.dart';
import 'package:zad_almumin/pages/prayerTimes/pray_time_left.dart';
import 'package:zad_almumin/pages/prayerTimes/pray_times_info.dart';
import '../../components/my_app_bar.dart';
import '../../components/my_circular_progress_indecator.dart';
import '../../components/my_drawer.dart';
import '../../constents/my_colors.dart';
import '../../constents/my_sizes.dart';
import '../../constents/my_texts.dart';
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
  void initState() {
    super.initState();
    //prayerTimeCtr.updatePrayerTimes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'مواقيت الصلاة'),
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
                  PrayTmeNextPrayInfo(),
                  SizedBox(height: MySiezes.betweanAzkarBlock),
                ],
              ),
              nextPrevDaysArrows(),
              PrayTimesInfo(),
              MaterialButton(
                color: MyColors.primary(),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onPressed: () async {
                  await prayerTimeCtr.updatePrayerTimes();
                  if (mounted) setState(() {});
                },
                child: Obx(() {
                  return SizedBox(
                    width: Get.width * 0.25,
                    child: Row(
                      mainAxisAlignment:
                          prayerTimeCtr.isLoading.value ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                      children: [
                        MyTexts.normal(title: 'تحديث', color: MyColors.white, fontWeight: FontWeight.bold),
                        prayerTimeCtr.isLoading.value
                            ? AnimatedOpacity(
                                duration: Duration(milliseconds: 3000),
                                opacity: prayerTimeCtr.isLoading.value ? 1 : 0,
                                child: MyCircularProgressIndecator(
                                  color: MyColors.white,
                                  backgroundColor: Colors.black,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget nextPrevDaysArrows() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () async {
            await prayerTimeCtr.updatePrayerTimes(newTime: prayerTimeCtr.curerntDate.value.add(Duration(days: 1)));

            setState(() {});
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        IconButton(
          onPressed: () async {
            await prayerTimeCtr.updatePrayerTimes(newTime: prayerTimeCtr.curerntDate.value.subtract(Duration(days: 1)));
            setState(() {});
          },
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ],
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
