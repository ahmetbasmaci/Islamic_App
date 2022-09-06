import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/constents/colors.dart';
import 'package:zad_almumin/constents/sizes.dart';
import '../../components/my_app_bar.dart';
import '../../components/my_drawer.dart';
import '../../components/my_switch.dart';
import '../../constents/constents.dart';
import '../../constents/icons.dart';
import '../../constents/texts.dart';
import 'classes/alarm_prop.dart';
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
    return Scaffold(
      appBar: MyAppBar(title: 'المنبه'),
      drawer: MyDrawer(),
      body: ListView(
        children: [
          alarmBlockTitle(title: 'تذكير القران'),
          quranAlarms(),
          alarmBlockTitle(title: 'تذكير الصيام'),
          fastAlarms(),
          alarmBlockTitle(title: 'تذكير الاذكار'),
          azkarAlarms(),
          alarmBlockTitle(title: 'تذكير الاحاديث'),
          hadithsAlarms(),
          alarmBlockTitle(title: 'تذكير الاذان'),
          prayTimesAlarms(),
        ],
      ),
    );
  }

  Widget cardContainer({required Widget child}) {
    return Container(
      margin: EdgeInsets.all(MySiezes.cardPadding),
      decoration: BoxDecoration(
        color: MyColors.background(),
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

  Widget quranAlarms() {
    return cardContainer(
      child: Column(
        children: [
          Obx(
            () => alarmListTile(
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
          Obx(
            () => alarmListTile(
                imagePath: 'assets/images/quranAlarm.png',
                title: 'قراءة صفحة من القران كل يوم',
                subtitle: 'سيصلك اشعار كل يوم لتذكيرك بقراءة صفحة من القران',
                value: alarmsCtr.quranPageEveryDayProp.isActive.value,
                alarmProp: alarmsCtr.quranPageEveryDayProp,
                onChanged: (newValue) {
                  alarmsCtr.changeState(alarmProp: alarmsCtr.quranPageEveryDayProp, newValue: newValue);
                }),
          ),
        ],
      ),
    );
  }

  Widget fastAlarms() {
    return cardContainer(
      child: Column(
        children: [
          Obx(
            () => alarmListTile(
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
            () => alarmListTile(
                imagePath: 'assets/images/fastingAlarm.png',
                title: 'صيام الخميس',
                subtitle: 'قم بالتفعيل ليصلك اشعار لتذكيرك بالصوم',
                value: alarmsCtr.thursdayFastProp.isActive.value,
                alarmProp: alarmsCtr.thursdayFastProp,
                onChanged: (newValue) {
                  alarmsCtr.changeState(alarmProp: alarmsCtr.thursdayFastProp, newValue: newValue);
                }),
          ),
          Obx(
            () => alarmListTile(
                imagePath: 'assets/images/fastingAlarm.png',
                title: 'صيام الايام البيض',
                subtitle: 'قم بالتفعيل ليصلك اشعار لتذكيرك بالصوم',
                value: alarmsCtr.whitedayFastProp.isActive.value,
                alarmProp: alarmsCtr.whitedayFastProp,
                onChanged: (newValue) {
                  alarmsCtr.changeState(alarmProp: alarmsCtr.whitedayFastProp, newValue: newValue);
                }),
          ),
        ],
      ),
    );
  }

  Widget azkarAlarms() {
    return cardContainer(
      child: Column(
        children: [
          Obx(
            () => alarmListTile(
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
            () => alarmListTile(
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

  Widget hadithsAlarms() {
    return cardContainer(
      child: Column(
        children: [
          Obx(
            () => alarmListTile(
                imagePath: 'assets/images/hadithAlarm.png',
                title: 'حديث يومي',
                subtitle: 'سيصلك اشعار بحديث جديد كل يوم',
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
    return cardContainer(
      child: Column(
        children: [
          Obx(
            () => alarmListTile(
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
            () => alarmListTile(
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
            () => alarmListTile(
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
            () => alarmListTile(
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
            () => alarmListTile(
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

  Widget alarmListTile({
    required String imagePath,
    required String title,
    required String subtitle,
    required bool value,
    required AlarmProp alarmProp,
    required Function(bool) onChanged,
    bool canChange = true,
  }) {
    GetStorage getStorage = GetStorage();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: MySiezes.betweanAzkarBlock),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(child: Image.asset(imagePath, width: 50)),
          const SizedBox(width: 15),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTexts.settingsTitle(title: title),
                MyTexts.settingsContent(title: subtitle),
                // MyTexts.settingsContent(
                //     title:
                //         '${Constants.format2.format(alarmProp.time.value.hour)}:${Constants.format2.format(alarmProp.time.value.minute)}'),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                IconButton(
                  onPressed: canChange
                      ? () async {
                          TimeOfDay? newTime = await showTimePicker(
                            context: context,
                            initialTime:
                                TimeOfDay(hour: alarmProp.time.value.hour, minute: alarmProp.time.value.minute),
                            builder: (BuildContext context, Widget? child) => child!,
                          );
                          if (newTime == null) return;
                          alarmProp.time.value = Time(newTime.hour, newTime.minute);
                          getStorage.write(alarmProp.storageKey, jsonEncode(alarmProp.toJson()));
                          onChanged(true);
                        }
                      : () {
                          Get.dialog(
                            AlertDialog(
                              title: MyTexts.settingsTitle(title: 'غير مسموح'),
                              content: MyTexts.settingsContent(title: 'لا يمكنك تغيير الاشعارات الخاصة بهذه الصلاة'),
                              actions: [
                                TextButton(
                                  child: MyTexts.settingsContent(title: 'حسنا'),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                              ],
                            ),
                            transitionDuration: Duration(milliseconds: 300),
                            transitionCurve: Curves.easeInCirc,
                          );
                        },
                  icon: MyIcons.alarm,
                ),
                MyTexts.settingsContent(
                    title:
                        '${Constants.format2.format(alarmProp.time.value.hour)}:${Constants.format2.format(alarmProp.time.value.minute)}'),
              ],
            ),
          ),
          Expanded(child: MySwitch(value: value, onChanged: onChanged)),
        ],
      ),
    );
  }

  ListTile alarmBlockTitle({required String title}) {
    return ListTile(leading: MyTexts.outsideHeader(title: title));
  }
}
