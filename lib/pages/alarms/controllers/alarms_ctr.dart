import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../constents/my_colors.dart';
import '../../../constents/my_icons.dart';
import '../../../moduls/enums.dart';
import '../../../services/notification_api.dart';
import '../classes/alarm_prop.dart';

class AlarmsCtr extends GetxController {
  final getStorage = GetStorage();
//!------------- hadith ----------------------------
  AlarmProp hadithEveryDayProp = AlarmProp(
    id: 8,
    time: Time(13, 0).obs,
    storageKey: 'hadithEveryDay',
    notificationTitle: 'حديث رسول الله ﷺ'.tr,
    notificationBody: '',
    snackBarEnabeldTitle: 'تم تفعيل تذكير حديث عن رسول الله'.tr,
    snackBarEnabeldBody: 'سيصلك اشعار بحديث عن رسول الله'.tr,
    snackBarDesabledTitle: 'تم تعطيل الاشعار '.tr,
    snackBarDesabeldBody: 'لن يصلك اشعار حديث عن رسول الله'.tr,
    alarmPeriod: ALarmPeriod.repeat,
    notificationType: NotificationType.hadith,
    notificationSound: NotificationSound.hadith,
    zikrRepeat: ZikrRepeat.high,
  );
//!------------- quran ----------------------------
  AlarmProp kahfSureProp = AlarmProp(
    id: 4,
    time: Time(9, 50).obs,
    storageKey: 'kahfSure',
    notificationTitle: 'لا تنسى قراءة سورة الكهف '.tr,
    notificationBody:
        ' قَالَ رَسُولُ اللَّهِ ﷺ:  ((مَن قَرَأَ سورةَ الكَهفِ يومَ الجُمُعةِ أضاءَ له من النورِ ما بَينَ الجُمُعتينِ  ))'.tr,
    snackBarEnabeldTitle: 'تم تفعيل تذكير قراءة سورة الكهف'.tr,
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بقراءة سورة الكهف'.tr,
    snackBarDesabledTitle: 'تم تعطيل الاشعار '.tr,
    snackBarDesabeldBody: 'لن يصلك اشعار قراءة سورة الكهف'.tr,
    alarmPeriod: ALarmPeriod.weekly,
    notificationType: NotificationType.kahfQuran,
    notificationSound: NotificationSound.random,
    day: DateTime.friday,
  );
  AlarmProp quranPageEveryDayProp = AlarmProp(
    id: 5,
    time: Time(12, 0).obs,
    storageKey: 'quranPageEveryDay',
    notificationTitle: 'لا تنسى قراءة وردك اليومي من القرآن '.tr,
    notificationBody:
        ' قَالَ رَسُولُ اللَّهِ ﷺ:  ((اقْرَءُوا الْقُرْآنَ فَإِنَّهُ يَأْتِي يَوْمَ الْقِيَامَةِ شَفِيعًا لأَصْحَابِهِ))'.tr,
    snackBarEnabeldTitle: 'تم تفعيل تذكير قراءة الورد اليومي للقران'.tr,
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بقراءة وردك اليومي من القرآن الكريم'.tr,
    snackBarDesabledTitle: 'تم تعطيل الاشعار '.tr,
    snackBarDesabeldBody: 'لن يصلك اشعار قراءة الورد اليومي للقران'.tr,
    alarmPeriod: ALarmPeriod.daily,
    notificationSound: NotificationSound.random,
    notificationType: NotificationType.randomQuran,
  );
//!------------- fast ----------------------------
  AlarmProp mondayFastProp = AlarmProp(
    id: 1,
    time: Time(20, 0).obs,
    storageKey: 'mondayFast',
    notificationTitle: 'لا تنسى صيام غدا الاثنين '.tr,
    notificationBody: 'كان صلى الله عليه وسلم يصوم يومي الاثنين والخميس من كل اسبوع'.tr,
    snackBarEnabeldTitle: 'تم تفعيل تذكير صيام يوم الاثنين '.tr,
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بالصوم يوم الاحد'.tr,
    snackBarDesabledTitle: 'تم تعطيل الاشعار '.tr,
    snackBarDesabeldBody: 'لن يصلك اشعار صيام يوم الاثنين'.tr,
    alarmPeriod: ALarmPeriod.weekly,
    notificationType: NotificationType.fast,
    notificationSound: NotificationSound.random,
    day: DateTime.sunday,
  );
  AlarmProp thursdayFastProp = AlarmProp(
    id: 2,
    time: Time(20, 0).obs,
    storageKey: 'thursdayFast',
    notificationTitle: 'لا تنسى صيام غدا الخميس '.tr,
    notificationBody: 'كان صلى الله عليه وسلم يصوم يومي الاثنين والخميس من كل اسبوع'.tr,
    snackBarEnabeldTitle: 'تم تفعيل تذكير صيام يوم الخميس'.tr,
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بالصوم يوم الاربعاء'.tr,
    snackBarDesabledTitle: 'تم تعطيل الاشعار '.tr,
    snackBarDesabeldBody: 'لن يصلك اشعار صيام يوم الخميس'.tr,
    alarmPeriod: ALarmPeriod.weekly,
    notificationType: NotificationType.fast,
    notificationSound: NotificationSound.random,
    day: DateTime.wednesday,
  );
  AlarmProp whitedayFastProp = AlarmProp(
    id: 3,
    time: Time(20, 0).obs,
    storageKey: 'whiteDaysFast',
    notificationTitle: 'لا تنسى صيام غدا فهو من الايام البيض '.tr,
    notificationBody: 'كان صلى الله عليه وسلم يصوم ثلاثة ايام من كل شهر هجري'.tr,
    snackBarEnabeldTitle: 'تم تفعيل تذكير صيام الايام البيض'.tr,
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بالصوم'.tr,
    snackBarDesabledTitle: 'تم تعطيل الاشعار '.tr,
    snackBarDesabeldBody: 'لن يصلك اشعار صيام الايام البيض'.tr,
    alarmPeriod: ALarmPeriod.monthly,
    notificationType: NotificationType.fast,
    notificationSound: NotificationSound.random,
  );
//!------------- azkar ----------------------------
  AlarmProp azkarProp = AlarmProp(
    id: 4,
    time: Time(9, 50).obs,
    storageKey: 'azkar',
    notificationTitle: 'اذكر الله'.tr,
    notificationBody: '',
    snackBarEnabeldTitle: 'تم تفعيل الذكر العشوائي'.tr,
    snackBarEnabeldBody: 'سيصلك اشعار بأذكار مختلفة'.tr,
    snackBarDesabledTitle: 'تم تعطيل الاشعار '.tr,
    snackBarDesabeldBody: 'لن يصلك اشعار الذكر العشوائي'.tr,
    alarmPeriod: ALarmPeriod.repeat,
    notificationType: NotificationType.azkar,
    notificationSound: NotificationSound.random,
    zikrRepeat: ZikrRepeat.high,
  );
  AlarmProp morningAzkarProp = AlarmProp(
    id: 6,
    time: Time(7, 0).obs,
    storageKey: 'morningAzkar',
    notificationTitle: 'لا تنسى قراءة أذكار الصباح '.tr,
    notificationBody: 'لأذكار الصباح فضل عظيم لا تفوته'.tr,
    snackBarEnabeldTitle: 'تم تفعيل تذكير أذكار الصباح'.tr,
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بقراءة أذكار الصباح'.tr,
    snackBarDesabledTitle: 'تم تعطيل الاشعار '.tr,
    snackBarDesabeldBody: 'لن يصلك اشعار أذكار الصباج'.tr,
    alarmPeriod: ALarmPeriod.daily,
    notificationType: NotificationType.moorningAzkar,
    notificationSound: NotificationSound.random,
  );
  AlarmProp nightAzkarProp = AlarmProp(
    id: 7,
    time: Time(17, 0).obs,
    storageKey: 'nightAzkar',
    notificationTitle: 'لا تنسى قراءة أذكار المساء '.tr,
    notificationBody: 'لأذكار المساء فضل عظيم لا تفوته'.tr,
    snackBarEnabeldTitle: 'تم تفعيل تذكير أذكار المساء'.tr,
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بقراءة أذكار المساء'.tr,
    snackBarDesabledTitle: 'تم تعطيل الاشعار '.tr,
    snackBarDesabeldBody: 'لن يصلك اشعار أذكار المساء'.tr,
    alarmPeriod: ALarmPeriod.daily,
    notificationType: NotificationType.nightAzkar,
    notificationSound: NotificationSound.random,
  );

//!------------- prayers ----------------------------
  AlarmProp fajrPrayProp = AlarmProp(
    id: 9,
    time: Time(0, 0).obs,
    storageKey: 'fajrPrayProp',
    notificationTitle: 'اذان الفجر'.tr,
    notificationBody: 'تبقى القليل لموعد اذان الفجر'.tr,
    snackBarEnabeldTitle: 'تم تفعيل تذكير اذان الفجر'.tr,
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك باذان الفجر'.tr,
    snackBarDesabledTitle: 'تم تعطيل الاشعار '.tr,
    snackBarDesabeldBody: 'لن يصلك اشعار اذان الفجر'.tr,
    alarmPeriod: ALarmPeriod.daily,
    notificationType: NotificationType.pray,
    notificationSound: NotificationSound.azhan,
  );
  AlarmProp sunPrayProp = AlarmProp(
    id: 9,
    time: Time(0, 0).obs,
    storageKey: 'sunPrayProp',
    notificationTitle: 'شروق الشمس'.tr,
    notificationBody: 'تبقى القليل لموعد شروق الشمس'.tr,
    snackBarEnabeldTitle: 'تم تفعيل تذكير شروق الشمس'.tr,
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بموعد شروق الشمس'.tr,
    snackBarDesabledTitle: 'تم تعطيل الاشعار '.tr,
    snackBarDesabeldBody: 'لن يصلك اشعار  شروق الشمس'.tr,
    alarmPeriod: ALarmPeriod.daily,
    notificationType: NotificationType.pray,
    notificationSound: NotificationSound.azhan,
  );
  AlarmProp duhrPrayProp = AlarmProp(
    id: 10,
    time: Time(0, 0).obs,
    storageKey: 'duhrPrayProp',
    notificationTitle: 'اذان الظهر'.tr,
    notificationBody: 'تبقى القليل لموعد اذان الظهر'.tr,
    snackBarEnabeldTitle: 'تم تفعيل تذكير اذان الظهر'.tr,
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك باذان الظهر'.tr,
    snackBarDesabledTitle: 'تم تعطيل الاشعار '.tr,
    snackBarDesabeldBody: 'لن يصلك اشعار اذان الظهر'.tr,
    alarmPeriod: ALarmPeriod.daily,
    notificationType: NotificationType.pray,
    notificationSound: NotificationSound.azhan,
  );
  AlarmProp asrPrayProp = AlarmProp(
    id: 11,
    time: Time(0, 0).obs,
    storageKey: 'asrPrayProp',
    notificationTitle: 'اذان العصر'.tr,
    notificationBody: 'تبقى القليل لموعد اذان العصر'.tr,
    snackBarEnabeldTitle: 'تم تفعيل تذكير اذان العصر'.tr,
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك باذان العصر'.tr,
    snackBarDesabledTitle: 'تم تعطيل الاشعار '.tr,
    snackBarDesabeldBody: 'لن يصلك اشعار اذان العصر'.tr,
    alarmPeriod: ALarmPeriod.daily,
    notificationType: NotificationType.pray,
    notificationSound: NotificationSound.azhan,
  );
  AlarmProp maghribPrayProp = AlarmProp(
    id: 12,
    time: Time(0, 0).obs,
    storageKey: 'maghribPrayProp',
    notificationTitle: 'اذان  لمغرب'.tr,
    notificationBody: 'تبقى القليل لموعد اذان المغرب'.tr,
    snackBarEnabeldTitle: 'تم تفعيل تذكير اذان المغرب'.tr,
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك باذان المغرب'.tr,
    snackBarDesabledTitle: 'تم تعطيل الاشعار '.tr,
    snackBarDesabeldBody: 'لن يصلك اشعار اذان المغرب'.tr,
    alarmPeriod: ALarmPeriod.daily,
    notificationType: NotificationType.pray,
    notificationSound: NotificationSound.azhan,
  );
  AlarmProp ishaPrayProp = AlarmProp(
    id: 13,
    time: Time(0, 0).obs,
    storageKey: 'ishaPrayProp',
    notificationTitle: 'اذان العشاء'.tr,
    notificationBody: 'تبقى القليل لموعد اذان العشاء'.tr,
    snackBarEnabeldTitle: 'تم تفعيل تذكير اذان العشاء'.tr,
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك باذان العشاء'.tr,
    snackBarDesabledTitle: 'تم تعطيل الاشعار '.tr,
    snackBarDesabeldBody: 'لن يصلك اشعار اذان العشاء'.tr,
    alarmPeriod: ALarmPeriod.daily,
    notificationType: NotificationType.pray,
    notificationSound: NotificationSound.azhan,
  );

  int distanceBetweenAlarmAndAzan = 10;
  AlarmsCtr() {
//!------------- azkar ----------------------------
    setPropToStorage(prop: azkarProp);
//!------------- quran ----------------------------
    setPropToStorage(prop: kahfSureProp);
    setPropToStorage(prop: quranPageEveryDayProp);
//!------------- fast ----------------------------
    setPropToStorage(prop: mondayFastProp);
    setPropToStorage(prop: thursdayFastProp);
    setPropToStorage(prop: whitedayFastProp);
//!------------- azkar ----------------------------
    setPropToStorage(prop: morningAzkarProp);
    setPropToStorage(prop: nightAzkarProp);
//!------------- hadith ----------------------------
    setPropToStorage(prop: hadithEveryDayProp);
//!------------- prayers ----------------------------
    setPropToStorage(prop: fajrPrayProp);
    setPropToStorage(prop: duhrPrayProp);
    setPropToStorage(prop: asrPrayProp);
    setPropToStorage(prop: maghribPrayProp);
    setPropToStorage(prop: ishaPrayProp);
  }

  setPropToStorage({required AlarmProp prop}) {
    getStorage.read(prop.storageKey) != null
        ? prop.fromJson(jsonDecode(getStorage.read(prop.storageKey)))
        : prop = prop;
  }

  changeState({required AlarmProp alarmProp, required bool newValue, bool showSnackBar = true}) async {
    bool isUpdating = false;
    if (alarmProp.isActive.value) isUpdating = true;

    alarmProp.isActive.value = newValue;
    getStorage.write(alarmProp.storageKey, jsonEncode(alarmProp.toJson()));
    if (newValue) {
      NotificationService.setNotification(alarmProp);

      if (showSnackBar)
        _showSnackBar(
          icon: MyIcons.done(),
          title: isUpdating ? 'تم تحديث وقت الاشعار'.tr : alarmProp.snackBarEnabeldTitle.tr,
          message: alarmProp.snackBarEnabeldBody.tr,
        );
    } else {
      NotificationService.cancelNotification(id: alarmProp.id);
      if (showSnackBar)
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
      time.hour,
      time.minute,
    ).subtract(Duration(minutes: distanceBetweenAlarmAndAzan));

    alarmProp.time.value = Time(tmpDateTime.hour, tmpDateTime.minute);

    if (alarmProp.isActive.value) changeState(alarmProp: alarmProp, newValue: true, showSnackBar: false);
  }

  void setAzanAlarm({required PrayerTimeType nextPrayType}) {
    AlarmProp alarmProp;
    if (nextPrayType == PrayerTimeType.fajr)
      alarmProp = fajrPrayProp;
    else if (nextPrayType == PrayerTimeType.sun)
      alarmProp = sunPrayProp;
    else if (nextPrayType == PrayerTimeType.duhr)
      alarmProp = duhrPrayProp;
    else if (nextPrayType == PrayerTimeType.asr)
      alarmProp = asrPrayProp;
    else if (nextPrayType == PrayerTimeType.maghrib)
      alarmProp = maghribPrayProp;
    else
      alarmProp = ishaPrayProp;

    NotificationService.setOnceNotification(alarmProp: alarmProp);
  }

  _showSnackBar({required Widget icon, required String title, required String message}) {
    Get.closeAllSnackbars();
    Get.snackbar(
      title,
      animationDuration: Duration(milliseconds: 500),
      duration: Duration(seconds: 2),
      message,
      icon: icon,
      snackPosition: SnackPosition.BOTTOM,
      colorText: MyColors.whiteBlack(),
      backgroundColor: MyColors.background(),
      boxShadows: [BoxShadow(color: MyColors.primary().withOpacity(.5), blurRadius: 30, spreadRadius: 2)],
      titleText: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: MyColors.whiteBlack()),
      ),
      messageText: Text(
        message,
        style: TextStyle(fontSize: 16, color: MyColors.whiteBlack()),
      ),
    );
  }
}
