import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/assets_manager.dart';
import 'package:zad_almumin/services/theme_service.dart';
import '../../components/my_app_bar.dart';
import '../../components/my_drawer.dart';
import '../../constents/my_texts.dart';
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
          appBar: MyAppBar(title: 'المنبه'.tr),
          drawer: MyDrawer(),
          body: ListView(
            children: [
              alarmBlockTitle(title: 'تذكير الاحاديث'.tr),
              hadithsAlarms(),
              alarmBlockTitle(title: 'الأذكار اليومية'.tr),
              azkarAlamrs(),
              alarmBlockTitle(title: 'قراءة القرآن'.tr),
              quranAlarms(),
              alarmBlockTitle(title: 'اوقات الصيام'.tr),
              fastAlarms(),
              alarmBlockTitle(title: 'اوقات الاذان'.tr),
              prayTimesAlarms(),
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
              imagePath: ImagesManager.azkarAlarm,
              title: 'أذكار عشوائية'.tr,
              subtitle: 'سيصلك اشعار بذكر عشوائي'.tr,
              value: alarmsCtr.azkarProp.isActive.value,
              alarmProp: alarmsCtr.azkarProp.time.value.minute == 0 ? alarmsCtr.azkarProp : alarmsCtr.azkarProp,
              onChanged: (newValue) {
                alarmsCtr.changeState(alarmProp: alarmsCtr.azkarProp, newValue: newValue);
              },
            ),
          ),
          Obx(
            () => AlarmListTile(
                imagePath: ImagesManager.azkarAlarm,
                title: 'أذكار الصباح'.tr,
                subtitle: 'سيصلك اشعار لتذكيرك بقراءة أذكار الصباح'.tr,
                value: alarmsCtr.morningAzkarProp.isActive.value,
                alarmProp: alarmsCtr.morningAzkarProp,
                onChanged: (newValue) {
                  alarmsCtr.changeState(alarmProp: alarmsCtr.morningAzkarProp, newValue: newValue);
                }),
          ),
          Obx(
            () => AlarmListTile(
                imagePath: ImagesManager.azkarAlarm,
                title: 'أذكار المساء'.tr,
                subtitle: 'سيصلك اشعار لتذكيرك بقراءة أذكار المساء'.tr,
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
                imagePath: ImagesManager.quranAlarm,
                title: 'قراءة صفحة من القرآن كل يوم'.tr,
                subtitle: 'سيصلك اشعار كل يوم لتذكيرك بقراءة صفحة من القرآن'.tr,
                value: alarmsCtr.quranPageEveryDayProp.isActive.value,
                alarmProp: alarmsCtr.quranPageEveryDayProp,
                onChanged: (newValue) {
                  alarmsCtr.changeState(alarmProp: alarmsCtr.quranPageEveryDayProp, newValue: newValue);
                }),
          ),
          Obx(
            () => AlarmListTile(
              imagePath: ImagesManager.quranAlarm,
              title: 'قراءة سورة الكهف'.tr,
              subtitle: 'سيصلك اشعار لتذكيرك بقراءة سورة الكهف يوم الجمعة'.tr,
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
                imagePath: ImagesManager.fastingAlarm,
                title: 'صيام الاثنين'.tr,
                subtitle: 'قم بالتفعيل ليصلك اشعار لتذكيرك بالصوم'.tr,
                value: alarmsCtr.mondayFastProp.isActive.value,
                alarmProp: alarmsCtr.mondayFastProp,
                onChanged: (newValue) {
                  alarmsCtr.changeState(alarmProp: alarmsCtr.mondayFastProp, newValue: newValue);
                }),
          ),
          Obx(
            () => AlarmListTile(
                imagePath: ImagesManager.fastingAlarm,
                title: 'صيام الخميس'.tr,
                subtitle: 'قم بالتفعيل ليصلك اشعار لتذكيرك بالصوم'.tr,
                value: alarmsCtr.thursdayFastProp.isActive.value,
                alarmProp: alarmsCtr.thursdayFastProp,
                onChanged: (newValue) {
                  alarmsCtr.changeState(alarmProp: alarmsCtr.thursdayFastProp, newValue: newValue);
                }),
          ),
          // Obx(
          //   () => AlarmListTile(
          //       imagePath: ImagesManager.fastingAlarm,
          //       title: 'صيام الايام البيض'.tr,
          //       subtitle: 'قم بالتفعيل ليصلك اشعار لتذكيرك بالصوم'.tr,
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
                imagePath: ImagesManager.hadithAlarm,
                title: 'حديث رسول الله ﷺ'.tr,
                subtitle: 'سيصلك اشعار بحديث رسول الله ﷺ'.tr,
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
              imagePath: ImagesManager.prayAlarm,
              title: 'صلاة الفجر'.tr,
              subtitle: 'سيصلك اشعار قبل موعد الاذان بدقائق'.tr,
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
              imagePath: ImagesManager.prayAlarm,
              title: 'صلاة الظهر'.tr,
              subtitle: 'سيصلك اشعار قبل موعد الاذان بدقائق'.tr,
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
              imagePath: ImagesManager.prayAlarm,
              title: 'صلاة العصر'.tr,
              subtitle: 'سيصلك اشعار قبل موعد الاذان بدقائق'.tr,
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
              imagePath: ImagesManager.prayAlarm,
              title: 'صلاة المغرب'.tr,
              subtitle: 'سيصلك اشعار قبل موعد الاذان بدقائق'.tr,
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
              imagePath: ImagesManager.prayAlarm,
              title: 'صلاة العشاء'.tr,
              subtitle: 'سيصلك اشعار قبل موعد الاذان بدقائق'.tr,
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
