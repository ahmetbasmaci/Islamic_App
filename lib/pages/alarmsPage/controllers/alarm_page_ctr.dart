import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../constents/colors.dart';
import '../../../constents/icons.dart';
import '../../../moduls/enums.dart';
import '../../../services/notification_api.dart';
import '../classes/alarm_prop.dart';

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
      colorText:MyColors.whiteBlack(),
      backgroundColor: MyColors.background(),
      boxShadows: [BoxShadow(color: MyColors.primary().withOpacity(.5), blurRadius: 30, spreadRadius: 2)],
      titleText: Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: MyColors.whiteBlack()),
        ),
      ),
      messageText: Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          message,
          style: TextStyle(
              fontSize: 16, color: MyColors.whiteBlack()),
        ),
      ),
    );
  }
}
