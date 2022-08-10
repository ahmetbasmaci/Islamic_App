import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/constents/colors.dart';
import 'package:zad_almumin/constents/sizes.dart';
import 'package:zad_almumin/pages/prayer_times.dart';
import 'package:zad_almumin/services/notification_api.dart';
import '../services/theme_service.dart';
import '../components/main_container.dart';
import '../components/my_app_bar.dart';
import '../components/my_drawer.dart';
import '../components/my_switch.dart';
import '../constents/icons.dart';
import '../constents/texts.dart';

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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: MyAppBar(title: 'المنبه'),
        drawer: MyDrawer(),
        body: Container(
          // padding: EdgeInsets.all(8),
          child: ListView(
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
        ),
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
              alarmProp: alarmsCtr.kahfSureProp,
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
                MyTexts.settingsTitle(context, title: title),
                MyTexts.settingsContent(context, title: subtitle),
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
                            initialTime: alarmProp.timeOfDay,
                            builder: (BuildContext context, Widget? child) {
                              return Directionality(
                                textDirection: TextDirection.rtl,
                                child: child!,
                              );
                            },
                          );
                          if (newTime == null) return;
                          alarmProp.timeOfDay = newTime;

                          getStorage.write(alarmProp.storageKey, jsonEncode(alarmProp.toJson()));
                          if (alarmProp.isActive.value) onChanged(true);
                        }
                      : () {
                          Get.dialog(
                            AlertDialog(
                              title: MyTexts.settingsTitle(context, title: 'غير مسموح'),
                              content: MyTexts.settingsContent(context,
                                  title: 'لا يمكنك تغيير الاشعارات الخاصة بهذه الصلاة'),
                              actions: [
                                TextButton(
                                  child: MyTexts.settingsContent(context, title: 'حسنا'),
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
                MyTexts.settingsContent(context, title: '${alarmProp.timeOfDay.hour}:${alarmProp.timeOfDay.minute}'),
              ],
            ),
          ),
          Expanded(child: MySwitch(value: value, onChanged: onChanged)),
        ],
      ),
    );
  }

  ListTile alarmBlockTitle({required String title}) {
    return ListTile(leading: MyTexts.outsideHeader(context, title: title));
  }
}

class AlarmProp {
  AlarmProp({
    required this.id,
    required this.timeOfDay,
    required this.storageKey,
    required this.notificationTitle,
    required this.notificationBody,
    required this.snackBarEnabeldTitle,
    required this.snackBarEnabeldBody,
    required this.snackBarDesabledTitle,
    required this.snackBarDesabeldBody,
    required this.alarmPeriod,
    this.alarmType = ALarmType.none,
    this.day = 0,
  });
  RxBool isActive = false.obs;
  int id;
  TimeOfDay timeOfDay;
  String storageKey;
  String notificationTitle;
  String notificationBody;
  String snackBarEnabeldTitle;
  String snackBarEnabeldBody;
  String snackBarDesabledTitle;
  String snackBarDesabeldBody;
  int day;
  ALarmPeriod alarmPeriod;
  ALarmType alarmType;
  Map<String, dynamic> toJson() => {
        'hour': timeOfDay.hour.toString(),
        'minute': timeOfDay.minute.toString(),
        'isActive': isActive.value,
      };

  fromJson(Map<String, dynamic> json) {
    timeOfDay = TimeOfDay(hour: int.parse(json['hour']), minute: int.parse(json['minute']));
    isActive.value = json['isActive'];
  }
}

enum ALarmPeriod { daily, weekly, monthly, once }

enum ALarmType { none, hadith }

class AlarmsCtr extends GetxController {
  final getStorage = GetStorage();

//!------------- quran ----------------------------
  AlarmProp kahfSureProp = AlarmProp(
    id: 4,
    timeOfDay: const TimeOfDay(hour: 9, minute: 50),
    storageKey: 'kahfSure',
    notificationTitle: 'لا تنسا قراءة سورة الكهف ',
    notificationBody:
        ' قَالَ رَسُولُ اللَّهِ ﷺ:  ((مَن قَرَأَ سورةَ الكَهفِ يومَ الجُمُعةِ أضاءَ له من النورِ ما بَينَ الجُمُعتينِ  ))',
    snackBarEnabeldTitle: 'تم تفعيل تذكير قراءة سورة الكهف',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بقراءة سورة الكهف',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار قراءة سورة الكهف',
    alarmPeriod: ALarmPeriod.weekly,
    day: DateTime.friday,
  );
  AlarmProp quranPageEveryDayProp = AlarmProp(
    id: 5,
    timeOfDay: const TimeOfDay(hour: 12, minute: 0),
    storageKey: 'quranPageEveryDay',
    notificationTitle: 'لا تنسا قراءة وردك اليومي من القران ',
    notificationBody:
        ' قَالَ رَسُولُ اللَّهِ ﷺ:  ((اقْرَءُوا الْقُرْآنَ فَإِنَّهُ يَأْتِي يَوْمَ الْقِيَامَةِ شَفِيعًا لأَصْحَابِهِ))',
    snackBarEnabeldTitle: 'تم تفعيل تذكير قراءة الورد اليومي للقران',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بقراءة وردك اليومي من القران الكريم',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار قراءة الورد اليومي للقران',
    alarmPeriod: ALarmPeriod.daily,
  );
//!------------- fast ----------------------------
  AlarmProp mondayFastProp = AlarmProp(
    id: 1,
    timeOfDay: const TimeOfDay(hour: 20, minute: 0),
    storageKey: 'mondayFast',
    notificationTitle: 'لا تنسا صيام غدا الاثنين ',
    notificationBody: 'كان صلى الله عليه وسلم يصوم يومي الاثنين والخميس من كل اسبوع',
    snackBarEnabeldTitle: 'تم تفعيل تذكير صيام يوم الاثنين',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بالصوم',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار صيام يوم الاثنين',
    alarmPeriod: ALarmPeriod.weekly,
    day: DateTime.sunday,
  );
  AlarmProp thursdayFastProp = AlarmProp(
    id: 2,
    timeOfDay: const TimeOfDay(hour: 20, minute: 0),
    storageKey: 'thursdayFast',
    notificationTitle: 'لا تنسا صيام غدا الخميس ',
    notificationBody: 'كان صلى الله عليه وسلم يصوم يومي الاثنين والخميس من كل اسبوع',
    snackBarEnabeldTitle: 'تم تفعيل تذكير صيام يوم الخميس',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بالصوم',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار صيام يوم الخميس',
    alarmPeriod: ALarmPeriod.weekly,
    day: DateTime.wednesday,
  );
  AlarmProp whitedayFastProp = AlarmProp(
    id: 3,
    timeOfDay: const TimeOfDay(hour: 20, minute: 0),
    storageKey: 'whiteDaysFast',
    notificationTitle: 'لا تنسا صيام غدا فهو من الايام البيض ',
    notificationBody: 'كان صلى الله عليه وسلم يصوم ثلاثة ايام من كل شهر هجري',
    snackBarEnabeldTitle: 'تم تفعيل تذكير صيام الايام البيض',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بالصوم',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار صيام الايام البيض',
    alarmPeriod: ALarmPeriod.monthly,
  );
//!------------- azkar ----------------------------
  AlarmProp morningAzkarProp = AlarmProp(
    id: 6,
    timeOfDay: const TimeOfDay(hour: 7, minute: 0),
    storageKey: 'morningAzkar',
    notificationTitle: 'لا تنسا قراءة اذكار الصباح ',
    notificationBody: 'لاذكار الصباح فضل عظيم لا تفوته',
    snackBarEnabeldTitle: 'تم تفعيل تذكير اذكار الصباح',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بقراءة اذكار الصباح',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار اذكار الصباج',
    alarmPeriod: ALarmPeriod.daily,
  );
  AlarmProp nightAzkarProp = AlarmProp(
    id: 7,
    timeOfDay: const TimeOfDay(hour: 17, minute: 0),
    storageKey: 'nightAzkar',
    notificationTitle: 'لا تنسا قراءة اذكار المساء ',
    notificationBody: 'لاذكار المساء فضل عظيم لا تفوته',
    snackBarEnabeldTitle: 'تم تفعيل تذكير اذكار المساء',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بقراءة اذكار المساء',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار اذكار المساء',
    alarmPeriod: ALarmPeriod.daily,
  );
//!------------- hadith ----------------------------
  AlarmProp hadithEveryDayProp = AlarmProp(
    id: 8,
    timeOfDay: const TimeOfDay(hour: 13, minute: 0),
    storageKey: 'hadithEveryDay',
    notificationTitle: 'كل يوم حديث عن رسول الله',
    notificationBody: '',
    snackBarEnabeldTitle: 'تم تفعيل تذكير حديث عن رسول الله',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بقراءة حديث عن رسول الله',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار اذكار المساء',
    alarmPeriod: ALarmPeriod.daily,
    alarmType: ALarmType.hadith,
  );
//!------------- prayers ----------------------------
  AlarmProp fajrPrayProp = AlarmProp(
    id: 9,
    timeOfDay: const TimeOfDay(hour: 0, minute: 0),
    storageKey: 'fajrPrayProp',
    notificationTitle: 'اذان الفجر',
    notificationBody: 'تبفى القليل لموعد اذان الفجر',
    snackBarEnabeldTitle: 'تم تفعيل تذكير اذان الفجر',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك باذان الفجر',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار اذان الفجر',
    alarmPeriod: ALarmPeriod.daily,
  );
  AlarmProp sunPrayProp = AlarmProp(
    id: 9,
    timeOfDay: const TimeOfDay(hour: 0, minute: 0),
    storageKey: 'sunPrayProp',
    notificationTitle: 'شروق الشمس',
    notificationBody: 'تبفى القليل لموعد شروق الشمس',
    snackBarEnabeldTitle: 'تم تفعيل تذكير شروق الشمس',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بموعد شروق الشمس',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار  شروق الشمس',
    alarmPeriod: ALarmPeriod.daily,
  );
  AlarmProp duhrPrayProp = AlarmProp(
    id: 10,
    timeOfDay: const TimeOfDay(hour: 0, minute: 0),
    storageKey: 'duhrPrayProp',
    notificationTitle: 'اذان الظهر',
    notificationBody: 'تبفى القليل لموعد اذان الظهر',
    snackBarEnabeldTitle: 'تم تفعيل تذكير اذان الظهر',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك باذان الظهر',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار اذان الظهر',
    alarmPeriod: ALarmPeriod.daily,
  );
  AlarmProp asrPrayProp = AlarmProp(
    id: 11,
    timeOfDay: const TimeOfDay(hour: 0, minute: 0),
    storageKey: 'asrPrayProp',
    notificationTitle: 'اذان العصر',
    notificationBody: 'تبفى القليل لموعد اذان العصر',
    snackBarEnabeldTitle: 'تم تفعيل تذكير اذان العصر',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك باذان العصر',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار اذان العصر',
    alarmPeriod: ALarmPeriod.daily,
  );
  AlarmProp maghribPrayProp = AlarmProp(
    id: 12,
    timeOfDay: const TimeOfDay(hour: 0, minute: 0),
    storageKey: 'maghribPrayProp',
    notificationTitle: 'اذان المغرب',
    notificationBody: 'تبفى القليل لموعد اذان المغرب',
    snackBarEnabeldTitle: 'تم تفعيل تذكير اذان المغرب',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك باذان المغرب',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار اذان المغرب',
    alarmPeriod: ALarmPeriod.daily,
  );
  AlarmProp ishaPrayProp = AlarmProp(
    id: 13,
    timeOfDay: const TimeOfDay(hour: 0, minute: 0),
    storageKey: 'ishaPrayProp',
    notificationTitle: 'اذان العشاء',
    notificationBody: 'تبفى القليل لموعد اذان العشاء',
    snackBarEnabeldTitle: 'تم تفعيل تذكير اذان العشاء',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك باذان العشاء',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار اذان العشاء',
    alarmPeriod: ALarmPeriod.daily,
  );

  int distanceBetweenAlarmAndAzan = 10;
  AlarmsCtr() {
//!------------- quran ----------------------------
    getStorage.read(kahfSureProp.storageKey) != null
        ? kahfSureProp.fromJson(jsonDecode(getStorage.read(kahfSureProp.storageKey)))
        : kahfSureProp = kahfSureProp;

    getStorage.read(quranPageEveryDayProp.storageKey) != null
        ? quranPageEveryDayProp.fromJson(jsonDecode(getStorage.read(quranPageEveryDayProp.storageKey)))
        : quranPageEveryDayProp = quranPageEveryDayProp;

//!------------- fast ----------------------------
    getStorage.read(mondayFastProp.storageKey) != null
        ? mondayFastProp.fromJson(jsonDecode(getStorage.read(mondayFastProp.storageKey)))
        : mondayFastProp = mondayFastProp;

    getStorage.read(thursdayFastProp.storageKey) != null
        ? thursdayFastProp.fromJson(jsonDecode(getStorage.read(thursdayFastProp.storageKey)))
        : thursdayFastProp = thursdayFastProp;

    getStorage.read(whitedayFastProp.storageKey) != null
        ? whitedayFastProp.fromJson(jsonDecode(getStorage.read(whitedayFastProp.storageKey)))
        : whitedayFastProp = whitedayFastProp;
//!------------- azkar ----------------------------
    getStorage.read(morningAzkarProp.storageKey) != null
        ? morningAzkarProp.fromJson(jsonDecode(getStorage.read(morningAzkarProp.storageKey)))
        : morningAzkarProp = morningAzkarProp;

    getStorage.read(nightAzkarProp.storageKey) != null
        ? nightAzkarProp.fromJson(jsonDecode(getStorage.read(nightAzkarProp.storageKey)))
        : nightAzkarProp = nightAzkarProp;

//!------------- hadith ----------------------------
    getStorage.read(hadithEveryDayProp.storageKey) != null
        ? hadithEveryDayProp.fromJson(jsonDecode(getStorage.read(hadithEveryDayProp.storageKey)))
        : hadithEveryDayProp = hadithEveryDayProp;

//!------------- prayers ----------------------------
    getStorage.read(fajrPrayProp.storageKey) != null
        ? fajrPrayProp.fromJson(jsonDecode(getStorage.read(fajrPrayProp.storageKey)))
        : fajrPrayProp = fajrPrayProp;

    getStorage.read(duhrPrayProp.storageKey) != null
        ? duhrPrayProp.fromJson(jsonDecode(getStorage.read(duhrPrayProp.storageKey)))
        : duhrPrayProp = duhrPrayProp;

    getStorage.read(asrPrayProp.storageKey) != null
        ? asrPrayProp.fromJson(jsonDecode(getStorage.read(asrPrayProp.storageKey)))
        : asrPrayProp = asrPrayProp;

    getStorage.read(maghribPrayProp.storageKey) != null
        ? maghribPrayProp.fromJson(jsonDecode(getStorage.read(maghribPrayProp.storageKey)))
        : maghribPrayProp = maghribPrayProp;

    getStorage.read(ishaPrayProp.storageKey) != null
        ? ishaPrayProp.fromJson(jsonDecode(getStorage.read(ishaPrayProp.storageKey)))
        : ishaPrayProp = ishaPrayProp;
  }

  changeState({required AlarmProp alarmProp, required bool newValue}) async {
    bool isUpdating = false;
    if (alarmProp.isActive.value) isUpdating = true;

    alarmProp.isActive.value = newValue;
    getStorage.write(alarmProp.storageKey, jsonEncode(alarmProp.toJson()));
    if (newValue) {
      if (alarmProp.alarmPeriod == ALarmPeriod.once)
        NotificationService.setOnceNotification(alarmProp: alarmProp);
      else if (alarmProp.alarmPeriod == ALarmPeriod.daily)
        NotificationService.setDailyNotification(alarmProp: alarmProp);
      else if (alarmProp.alarmPeriod == ALarmPeriod.weekly)
        NotificationService.setWeecklyNotifivation(alarmProp: alarmProp);
      else if (alarmProp.alarmPeriod == ALarmPeriod.monthly)
        NotificationService.setWhiteDaysFastNotification(alarmProp: alarmProp);
      _showSnackBar(
        icon: MyIcons.done(),
        title: isUpdating ? 'تم تحديث وقت الاشعار' : alarmProp.snackBarEnabeldTitle,
        message: alarmProp.snackBarEnabeldBody,
      );
    } else {
      NotificationService.cancelNotification(id: alarmProp.id);
      _showSnackBar(
        icon: MyIcons.error,
        title: alarmProp.snackBarDesabledTitle,
        message: alarmProp.snackBarDesabeldBody,
      );
    }
  }

  setPrayTimesAlarms({
    required Time fajrTime,
    required Time sunTime,
    required Time duhrTime,
    required Time asrTime,
    required Time maghribTime,
    required Time ishaTime,
  }) {
    updatePrayTimeAlarm(alarmProp: fajrPrayProp, time: fajrTime);
    updatePrayTimeAlarm(alarmProp: sunPrayProp, time: sunTime);
    updatePrayTimeAlarm(alarmProp: duhrPrayProp, time: duhrTime);
    updatePrayTimeAlarm(alarmProp: asrPrayProp, time: asrTime);
    updatePrayTimeAlarm(alarmProp: maghribPrayProp, time: maghribTime);
    updatePrayTimeAlarm(alarmProp: ishaPrayProp, time: ishaTime);
  }

  void updatePrayTimeAlarm({required AlarmProp alarmProp, required Time time}) {
    DateTime tmpDateTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      alarmProp.timeOfDay.hour,
      alarmProp.timeOfDay.minute,
    ).subtract(Duration(minutes: distanceBetweenAlarmAndAzan));

    alarmProp.timeOfDay = TimeOfDay(hour: tmpDateTime.hour, minute: tmpDateTime.minute);

    getStorage.write(alarmProp.storageKey, jsonEncode(alarmProp.toJson()));
  }

  _showSnackBar({required Widget icon, required String title, required String message}) {
    Get.closeCurrentSnackbar();
    Get.snackbar(
      title,
      animationDuration: Duration(milliseconds: 500),
      duration: Duration(seconds: 2),
      message,
      icon: icon,
      snackPosition: SnackPosition.BOTTOM,
      colorText: ThemeService().getThemeMode() == ThemeMode.dark ? MyColors.white : MyColors.black,
      backgroundColor: MyColors.background(),
      boxShadows: [BoxShadow(color: MyColors.primary().withOpacity(.5), blurRadius: 30, spreadRadius: 2)],
      titleText: Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: ThemeService().getThemeMode() == ThemeMode.dark ? MyColors.white : MyColors.black),
        ),
      ),
      messageText: Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          message,
          style: TextStyle(
              fontSize: 16, color: ThemeService().getThemeMode() == ThemeMode.dark ? MyColors.white : MyColors.black),
        ),
      ),
    );
  }
}
