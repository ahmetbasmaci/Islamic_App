import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/services/theme_service.dart';
import '../../components/my_app_bar.dart';
import '../../components/my_drawer.dart';
import '../../constents/texts.dart';
import 'alarm_card.dart';
import 'alarm_list_tile.dart';
import 'controllers/alarms_ctr.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);
  static const id = 'AlarmPage';
  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  var alarmsCtr = Get.find<AlarmsCtr>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        Get.find<ThemeCtr>().isDarkMode.value;
        return Scaffold(
          appBar: MyAppBar(title: 'المنبه'),
          drawer: MyDrawer(),
          body: ListView(
            children: [
              alarmBlockTitle(title: 'تذكير الاحاديث'),
              hadithsAlarms(),
              alarmBlockTitle(title: 'الاذكار اليومية'),
              azkarAlamrs(),
              alarmBlockTitle(title: 'قراءة القران'),
              quranAlarms(),
              alarmBlockTitle(title: 'اوقات الصيام'),
              fastAlarms(),
              // alarmBlockTitle(title: 'اوقات الاذان'),
              // prayTimesAlarms(),
            ],
          ),
        );
      },
    );
  }

  Widget azkarAlamrs() {
    return AlarmCard(
      child: Column(
        children: [
          Obx(
            () => AlarmListTile(
              imagePath: 'assets/images/azkarAlarm.png',
              title: 'اذكار عشوائية',
              subtitle: 'سيصلك اشعار بذكر عشوائي ',
              value: alarmsCtr.azkarProp.isActive.value,
              alarmProp: alarmsCtr.azkarProp.time.value.minute == 0 ? alarmsCtr.azkarProp : alarmsCtr.azkarProp,
              onChanged: (newValue) {
                alarmsCtr.changeState(alarmProp: alarmsCtr.azkarProp, newValue: newValue);
              },
            ),
          ),
          Obx(
            () => AlarmListTile(
                imagePath: 'assets/images/azkarAlarm.png',
                title: 'اذكار الصباح',
                subtitle: 'سيصلك اشعار لتذكيرك بقراءة اذكار الصباح',
                value: alarmsCtr.morningAzkarProp.isActive.value,
                alarmProp: alarmsCtr.morningAzkarProp,
                onChanged: (newValue) {
                  alarmsCtr.changeState(alarmProp: alarmsCtr.morningAzkarProp, newValue: newValue);
                }),
          ),
          Obx(
            () => AlarmListTile(
                imagePath: 'assets/images/azkarAlarm.png',
                title: 'اذكار المساء',
                subtitle: 'سيصلك اشعار لتذكيرك بقراءة اذكار المساء',
                value: alarmsCtr.nightAzkarProp.isActive.value,
                alarmProp: alarmsCtr.nightAzkarProp,
                onChanged: (newValue) {
                  alarmsCtr.changeState(alarmProp: alarmsCtr.nightAzkarProp, newValue: newValue);
                }),
          ),
        ],
      ),
    );
  }

  Widget quranAlarms() {
    return AlarmCard(
      child: Column(
        children: [
          Obx(
            () => AlarmListTile(
                imagePath: 'assets/images/quranAlarm.png',
                title: 'قراءة صفحة من القران كل يوم',
                subtitle: 'سيصلك اشعار كل يوم لتذكيرك بقراءة صفحة من القران',
                value: alarmsCtr.quranPageEveryDayProp.isActive.value,
                alarmProp: alarmsCtr.quranPageEveryDayProp,
                onChanged: (newValue) {
                  alarmsCtr.changeState(alarmProp: alarmsCtr.quranPageEveryDayProp, newValue: newValue);
                }),
          ),
          Obx(
            () => AlarmListTile(
              imagePath: 'assets/images/quranAlarm.png',
              title: 'قراءة سورة الكهف',
              subtitle: 'سيصلك اشعار لتذكيرك بقراءة سورة الكهف يوم الجمعة',
              value: alarmsCtr.kahfSureProp.isActive.value,
              alarmProp:
                  alarmsCtr.kahfSureProp.time.value.minute == 0 ? alarmsCtr.kahfSureProp : alarmsCtr.kahfSureProp,
              onChanged: (newValue) {
                alarmsCtr.changeState(alarmProp: alarmsCtr.kahfSureProp, newValue: newValue);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget fastAlarms() {
    return AlarmCard(
      child: Column(
        children: [
          Obx(
            () => AlarmListTile(
                imagePath: 'assets/images/fastingAlarm.png',
                title: 'صيام الاثنين',
                subtitle: 'قم بالتفعيل ليصلك اشعار لتذكيرك بالصوم',
                value: alarmsCtr.mondayFastProp.isActive.value,
                alarmProp: alarmsCtr.mondayFastProp,
                onChanged: (newValue) {
                  alarmsCtr.changeState(alarmProp: alarmsCtr.mondayFastProp, newValue: newValue);
                }),
          ),
          Obx(
            () => AlarmListTile(
                imagePath: 'assets/images/fastingAlarm.png',
                title: 'صيام الخميس',
                subtitle: 'قم بالتفعيل ليصلك اشعار لتذكيرك بالصوم',
                value: alarmsCtr.thursdayFastProp.isActive.value,
                alarmProp: alarmsCtr.thursdayFastProp,
                onChanged: (newValue) {
                  alarmsCtr.changeState(alarmProp: alarmsCtr.thursdayFastProp, newValue: newValue);
                }),
          ),
          // Obx(
          //   () => AlarmListTile(
          //       imagePath: 'assets/images/fastingAlarm.png',
          //       title: 'صيام الايام البيض',
          //       subtitle: 'قم بالتفعيل ليصلك اشعار لتذكيرك بالصوم',
          //       value: alarmsCtr.whitedayFastProp.isActive.value,
          //       alarmProp: alarmsCtr.whitedayFastProp,
          //       onChanged: (newValue) {
          //         alarmsCtr.changeState(alarmProp: alarmsCtr.whitedayFastProp, newValue: newValue);
          //       }),
          // ),
        ],
      ),
    );
  }

  Widget hadithsAlarms() {
    return AlarmCard(
      child: Column(
        children: [
          Obx(
            () => AlarmListTile(
                imagePath: 'assets/images/hadithAlarm.png',
                title: 'حديث رسول الله ﷺ',
                subtitle: 'سيصلك اشعار بحديث رسول الله ﷺ',
                value: alarmsCtr.hadithEveryDayProp.isActive.value,
                alarmProp: alarmsCtr.hadithEveryDayProp,
                onChanged: (newValue) {
                  alarmsCtr.changeState(alarmProp: alarmsCtr.hadithEveryDayProp, newValue: newValue);
                }),
          ),
        ],
      ),
    );
  }

  Widget prayTimesAlarms() {
    return AlarmCard(
      child: Column(
        children: [
          Obx(
            () => AlarmListTile(
              imagePath: 'assets/images/prayAlarm.png',
              title: 'صلاة الفجر',
              subtitle: 'سيصلك اشعار قبل مزعد الاذان',
              value: alarmsCtr.fajrPrayProp.isActive.value,
              alarmProp: alarmsCtr.fajrPrayProp,
              onChanged: (newValue) {
                alarmsCtr.changeState(alarmProp: alarmsCtr.fajrPrayProp, newValue: newValue);
              },
              canChange: false,
            ),
          ),
          Obx(
            () => AlarmListTile(
              imagePath: 'assets/images/prayAlarm.png',
              title: 'صلاة الظهر',
              subtitle: 'سيصلك اشعار قبل مزعد الاذان',
              value: alarmsCtr.duhrPrayProp.isActive.value,
              alarmProp: alarmsCtr.duhrPrayProp,
              onChanged: (newValue) {
                alarmsCtr.changeState(alarmProp: alarmsCtr.duhrPrayProp, newValue: newValue);
              },
              canChange: false,
            ),
          ),
          Obx(
            () => AlarmListTile(
              imagePath: 'assets/images/prayAlarm.png',
              title: 'صلاة العصر',
              subtitle: 'سيصلك اشعار قبل مزعد الاذان',
              value: alarmsCtr.asrPrayProp.isActive.value,
              alarmProp: alarmsCtr.asrPrayProp,
              onChanged: (newValue) {
                alarmsCtr.changeState(alarmProp: alarmsCtr.asrPrayProp, newValue: newValue);
              },
              canChange: false,
            ),
          ),
          Obx(
            () => AlarmListTile(
              imagePath: 'assets/images/prayAlarm.png',
              title: 'صلاة المغرب',
              subtitle: 'سيصلك اشعار قبل مزعد الاذان',
              value: alarmsCtr.maghribPrayProp.isActive.value,
              alarmProp: alarmsCtr.maghribPrayProp,
              onChanged: (newValue) {
                alarmsCtr.changeState(alarmProp: alarmsCtr.maghribPrayProp, newValue: newValue);
              },
              canChange: false,
            ),
          ),
          Obx(
            () => AlarmListTile(
              imagePath: 'assets/images/prayAlarm.png',
              title: 'صلاة العشاء',
              subtitle: 'سيصلك اشعار قبل مزعد الاذان',
              value: alarmsCtr.ishaPrayProp.isActive.value,
              alarmProp: alarmsCtr.ishaPrayProp,
              onChanged: (newValue) {
                alarmsCtr.changeState(alarmProp: alarmsCtr.ishaPrayProp, newValue: newValue);
              },
              canChange: false,
            ),
          ),
        ],
      ),
    );
  }

  ListTile alarmBlockTitle({required String title}) {
    return ListTile(leading: MyTexts.outsideHeader(title: title));
  }
}
