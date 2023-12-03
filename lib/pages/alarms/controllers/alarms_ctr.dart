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
  //!------------- phalastine ----------------------------
  AlarmProp phalastineProp = AlarmProp(
    id: 8,
    time: Time(13, 0).obs,
    storageKey: 'phalastineProp',
    notificationTitle: '😔دعاء لأهلنا في فلسطين😔',
    notificationBody:
        'أللهم فرّج همَّهم وانصرهم يا عزيز يا اللّه🤲🏻 .لا تنسى إخوانك في فلسطين من الدعاء فمن لم يهتم لأمر المسلمين ليس منهم',
    snackBarEnabeldTitle: 'تم تفعيل تذكير الدعاء لأهلنا في  فلسطين',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بالدعاء لأهلنا في فلسطين',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار تذكير بالدعاء',
    alarmPeriod: ALarmPeriod.repeat,
    notificationType: NotificationType.phalastine,
    notificationSound: NotificationSound.random,
    zikrRepeat: ZikrRepeat.high,
  );
//!------------- hadith ----------------------------
  AlarmProp hadithEveryDayProp = AlarmProp(
    id: 8,
    time: Time(13, 0).obs,
    storageKey: 'hadithEveryDay',
    notificationTitle: 'حديث رسول الله ﷺ',
    notificationBody: '',
    snackBarEnabeldTitle: 'تم تفعيل تذكير حديث عن رسول الله',
    snackBarEnabeldBody: 'سيصلك اشعار بحديث عن رسول الله',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار حديث عن رسول الله',
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
    notificationTitle: 'لا تنسى قراءة سورة الكهف ',
    notificationBody:
        ' قَالَ رَسُولُ اللَّهِ ﷺ:  ((مَن قَرَأَ سورةَ الكَهفِ يومَ الجُمُعةِ أضاءَ له من النورِ ما بَينَ الجُمُعتينِ  ))',
    snackBarEnabeldTitle: 'تم تفعيل تذكير قراءة سورة الكهف',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بقراءة سورة الكهف',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار قراءة سورة الكهف',
    alarmPeriod: ALarmPeriod.weekly,
    notificationType: NotificationType.kahfQuran,
    notificationSound: NotificationSound.random,
    day: DateTime.friday,
  );
  AlarmProp quranPageEveryDayProp = AlarmProp(
    id: 5,
    time: Time(12, 0).obs,
    storageKey: 'quranPageEveryDay',
    notificationTitle: 'لا تنسى قراءة وردك اليومي من القرآن ',
    notificationBody:
        ' قَالَ رَسُولُ اللَّهِ ﷺ:  ((اقْرَءُوا الْقُرْآنَ فَإِنَّهُ يَأْتِي يَوْمَ الْقِيَامَةِ شَفِيعًا لأَصْحَابِهِ))',
    snackBarEnabeldTitle: 'تم تفعيل تذكير قراءة الورد اليومي للقران',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بقراءة وردك اليومي من القرآن الكريم',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار قراءة الورد اليومي للقران',
    alarmPeriod: ALarmPeriod.daily,
    notificationSound: NotificationSound.random,
    notificationType: NotificationType.randomQuran,
  );
//!------------- fast ----------------------------
  AlarmProp mondayFastProp = AlarmProp(
    id: 1,
    time: Time(20, 0).obs,
    storageKey: 'mondayFast',
    notificationTitle: 'لا تنسى صيام غدا الاثنين ',
    notificationBody: 'كان صلى الله عليه وسلم يصوم يومي الاثنين والخميس من كل اسبوع',
    snackBarEnabeldTitle: 'تم تفعيل تذكير صيام يوم الاثنين ',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بالصوم يوم الاحد',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار صيام يوم الاثنين',
    alarmPeriod: ALarmPeriod.weekly,
    notificationType: NotificationType.fast,
    notificationSound: NotificationSound.random,
    day: DateTime.sunday,
  );
  AlarmProp thursdayFastProp = AlarmProp(
    id: 2,
    time: Time(20, 0).obs,
    storageKey: 'thursdayFast',
    notificationTitle: 'لا تنسى صيام غدا الخميس ',
    notificationBody: 'كان صلى الله عليه وسلم يصوم يومي الاثنين والخميس من كل اسبوع',
    snackBarEnabeldTitle: 'تم تفعيل تذكير صيام يوم الخميس',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بالصوم يوم الاربعاء',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار صيام يوم الخميس',
    alarmPeriod: ALarmPeriod.weekly,
    notificationType: NotificationType.fast,
    notificationSound: NotificationSound.random,
    day: DateTime.wednesday,
  );
  AlarmProp whitedayFastProp = AlarmProp(
    id: 3,
    time: Time(20, 0).obs,
    storageKey: 'whiteDaysFast',
    notificationTitle: 'لا تنسى صيام غدا فهو من الايام البيض ',
    notificationBody: 'كان صلى الله عليه وسلم يصوم ثلاثة ايام من كل شهر هجري',
    snackBarEnabeldTitle: 'تم تفعيل تذكير صيام الايام البيض',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بالصوم',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار صيام الايام البيض',
    alarmPeriod: ALarmPeriod.monthly,
    notificationType: NotificationType.fast,
    notificationSound: NotificationSound.random,
  );
//!------------- azkar ----------------------------
  AlarmProp azkarProp = AlarmProp(
    id: 4,
    time: Time(9, 50).obs,
    storageKey: 'azkar',
    notificationTitle: 'اذكر الله',
    notificationBody: '',
    snackBarEnabeldTitle: 'تم تفعيل الذكر العشوائي',
    snackBarEnabeldBody: 'سيصلك اشعار بأذكار مختلفة',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار الذكر العشوائي',
    alarmPeriod: ALarmPeriod.repeat,
    notificationType: NotificationType.azkar,
    notificationSound: NotificationSound.random,
    zikrRepeat: ZikrRepeat.high,
  );
  AlarmProp morningAzkarProp = AlarmProp(
    id: 6,
    time: Time(7, 0).obs,
    storageKey: 'morningAzkar',
    notificationTitle: 'لا تنسى قراءة أذكار الصباح ',
    notificationBody: 'لأذكار الصباح فضل عظيم لا تفوته',
    snackBarEnabeldTitle: 'تم تفعيل تذكير أذكار الصباح',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بقراءة أذكار الصباح',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار أذكار الصباح',
    alarmPeriod: ALarmPeriod.daily,
    notificationType: NotificationType.moorningAzkar,
    notificationSound: NotificationSound.random,
  );
  AlarmProp nightAzkarProp = AlarmProp(
    id: 7,
    time: Time(17, 0).obs,
    storageKey: 'nightAzkar',
    notificationTitle: 'لا تنسى قراءة أذكار المساء ',
    notificationBody: 'لأذكار المساء فضل عظيم لا تفوته',
    snackBarEnabeldTitle: 'تم تفعيل تذكير أذكار المساء',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بقراءة أذكار المساء',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار أذكار المساء',
    alarmPeriod: ALarmPeriod.daily,
    notificationType: NotificationType.nightAzkar,
    notificationSound: NotificationSound.random,
  );

//!------------- prayers ----------------------------
  AlarmProp fajrPrayProp = AlarmProp(
    id: 9,
    time: Time(0, 0).obs,
    storageKey: 'fajrPrayProp',
    notificationTitle: 'اذان الفجر',
    notificationBody: 'تبقى القليل لموعد اذان الفجر',
    snackBarEnabeldTitle: 'تم تفعيل تذكير اذان الفجر',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك باذان الفجر',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار اذان الفجر',
    alarmPeriod: ALarmPeriod.daily,
    notificationType: NotificationType.pray,
    notificationSound: NotificationSound.azhan,
  );
  AlarmProp sunPrayProp = AlarmProp(
    id: 9,
    time: Time(0, 0).obs,
    storageKey: 'sunPrayProp',
    notificationTitle: 'شروق الشمس',
    notificationBody: 'تبقى القليل لموعد شروق الشمس',
    snackBarEnabeldTitle: 'تم تفعيل تذكير شروق الشمس',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك بموعد شروق الشمس',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار  شروق الشمس',
    alarmPeriod: ALarmPeriod.daily,
    notificationType: NotificationType.pray,
    notificationSound: NotificationSound.azhan,
  );
  AlarmProp duhrPrayProp = AlarmProp(
    id: 10,
    time: Time(0, 0).obs,
    storageKey: 'duhrPrayProp',
    notificationTitle: 'اذان الظهر',
    notificationBody: 'تبقى القليل لموعد اذان الظهر',
    snackBarEnabeldTitle: 'تم تفعيل تذكير اذان الظهر',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك باذان الظهر',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار اذان الظهر',
    alarmPeriod: ALarmPeriod.daily,
    notificationType: NotificationType.pray,
    notificationSound: NotificationSound.azhan,
  );
  AlarmProp asrPrayProp = AlarmProp(
    id: 11,
    time: Time(0, 0).obs,
    storageKey: 'asrPrayProp',
    notificationTitle: 'اذان العصر',
    notificationBody: 'تبقى القليل لموعد اذان العصر',
    snackBarEnabeldTitle: 'تم تفعيل تذكير اذان العصر',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك باذان العصر',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار اذان العصر',
    alarmPeriod: ALarmPeriod.daily,
    notificationType: NotificationType.pray,
    notificationSound: NotificationSound.azhan,
  );
  AlarmProp maghribPrayProp = AlarmProp(
    id: 12,
    time: Time(0, 0).obs,
    storageKey: 'maghribPrayProp',
    notificationTitle: 'اذان  لمغرب',
    notificationBody: 'تبقى القليل لموعد اذان المغرب',
    snackBarEnabeldTitle: 'تم تفعيل تذكير اذان المغرب',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك باذان المغرب',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار اذان المغرب',
    alarmPeriod: ALarmPeriod.daily,
    notificationType: NotificationType.pray,
    notificationSound: NotificationSound.azhan,
  );
  AlarmProp ishaPrayProp = AlarmProp(
    id: 13,
    time: Time(0, 0).obs,
    storageKey: 'ishaPrayProp',
    notificationTitle: 'اذان العشاء',
    notificationBody: 'تبقى القليل لموعد اذان العشاء',
    snackBarEnabeldTitle: 'تم تفعيل تذكير اذان العشاء',
    snackBarEnabeldBody: 'سيصلك اشعار لتذكيرك باذان العشاء',
    snackBarDesabledTitle: 'تم تعطيل الاشعار ',
    snackBarDesabeldBody: 'لن يصلك اشعار اذان العشاء',
    alarmPeriod: ALarmPeriod.daily,
    notificationType: NotificationType.pray,
    notificationSound: NotificationSound.azhan,
  );

  int distanceBetweenAlarmAndAzan = 10;
  AlarmsCtr() {
//!------------- azkar ----------------------------
    setPropToStorage(azkarProp);
//!------------- quran ----------------------------
    setPropToStorage(kahfSureProp);
    setPropToStorage(quranPageEveryDayProp);
//!------------- fast ----------------------------
    setPropToStorage(mondayFastProp);
    setPropToStorage(thursdayFastProp);
    setPropToStorage(whitedayFastProp);
//!------------- azkar ----------------------------
    setPropToStorage(morningAzkarProp);
    setPropToStorage(nightAzkarProp);
//!------------- hadith ----------------------------
    setPropToStorage(hadithEveryDayProp);
//!------------- phalastine ----------------------------
    setPropToStorage(phalastineProp);
//!------------- prayers ----------------------------
    setPropToStorage(fajrPrayProp);
    setPropToStorage(duhrPrayProp);
    setPropToStorage(asrPrayProp);
    setPropToStorage(maghribPrayProp);
    setPropToStorage(ishaPrayProp);
  }

  void resetNullAndEnabledAlarms() {
    if (azkarProp.isActive.value) {
      changeState(alarmProp: azkarProp, newValue: false, showSnackBar: false);
      changeState(alarmProp: azkarProp, newValue: true, showSnackBar: false);
    }
    if (kahfSureProp.isActive.value) {
      changeState(alarmProp: kahfSureProp, newValue: false, showSnackBar: false);
      changeState(alarmProp: kahfSureProp, newValue: true, showSnackBar: false);
    }
    if (quranPageEveryDayProp.isActive.value) {
      changeState(alarmProp: quranPageEveryDayProp, newValue: false, showSnackBar: false);
      changeState(alarmProp: quranPageEveryDayProp, newValue: true, showSnackBar: false);
    }
    if (mondayFastProp.isActive.value) {
      changeState(alarmProp: mondayFastProp, newValue: false, showSnackBar: false);
      changeState(alarmProp: mondayFastProp, newValue: true, showSnackBar: false);
    }
    if (thursdayFastProp.isActive.value) {
      changeState(alarmProp: thursdayFastProp, newValue: false, showSnackBar: false);
      changeState(alarmProp: thursdayFastProp, newValue: true, showSnackBar: false);
    }
    if (whitedayFastProp.isActive.value) {
      changeState(alarmProp: whitedayFastProp, newValue: false, showSnackBar: false);
      changeState(alarmProp: whitedayFastProp, newValue: true, showSnackBar: false);
    }
    if (morningAzkarProp.isActive.value) {
      changeState(alarmProp: morningAzkarProp, newValue: false, showSnackBar: false);
      changeState(alarmProp: morningAzkarProp, newValue: true, showSnackBar: false);
    }
    if (nightAzkarProp.isActive.value) {
      changeState(alarmProp: nightAzkarProp, newValue: false, showSnackBar: false);
      changeState(alarmProp: nightAzkarProp, newValue: true, showSnackBar: false);
    }
    if (hadithEveryDayProp.isActive.value) {
      changeState(alarmProp: hadithEveryDayProp, newValue: false, showSnackBar: false);
      changeState(alarmProp: hadithEveryDayProp, newValue: true, showSnackBar: false);
    }
    if (phalastineProp.isActive.value) {
      changeState(alarmProp: phalastineProp, newValue: false, showSnackBar: false);
      changeState(alarmProp: phalastineProp, newValue: true, showSnackBar: false);
    }
    if (fajrPrayProp.isActive.value) {
      changeState(alarmProp: fajrPrayProp, newValue: false, showSnackBar: false);
      changeState(alarmProp: fajrPrayProp, newValue: true, showSnackBar: false);
    }
    if (duhrPrayProp.isActive.value) {
      changeState(alarmProp: duhrPrayProp, newValue: false, showSnackBar: false);
      changeState(alarmProp: duhrPrayProp, newValue: true, showSnackBar: false);
    }
    if (asrPrayProp.isActive.value) {
      changeState(alarmProp: asrPrayProp, newValue: false, showSnackBar: false);
      changeState(alarmProp: asrPrayProp, newValue: true, showSnackBar: false);
    }
    if (maghribPrayProp.isActive.value) {
      changeState(alarmProp: maghribPrayProp, newValue: false, showSnackBar: false);
      changeState(alarmProp: maghribPrayProp, newValue: true, showSnackBar: false);
    }
    if (ishaPrayProp.isActive.value) {
      changeState(alarmProp: ishaPrayProp, newValue: false, showSnackBar: false);
      changeState(alarmProp: ishaPrayProp, newValue: true, showSnackBar: false);
    }
  }

  void setPropToStorage(AlarmProp prop) {
    !isAlarmDontHaveStoredValue(prop) ? prop.fromJson(jsonDecode(getStorage.read(prop.storageKey))) : prop = prop;
  }

  bool isAlarmDontHaveStoredValue(AlarmProp prop) => getStorage.read(prop.storageKey) == null;

  changeState({required AlarmProp alarmProp, required bool newValue, bool showSnackBar = true}) async {
    bool isUpdating = false;
    if (alarmProp.isActive.value) isUpdating = true;

    alarmProp.isActive.value = newValue;
    getStorage.write(alarmProp.storageKey, jsonEncode(alarmProp.toJson()));
    if (newValue) {
      // NotificationService.showNotificationNow(
      //     title: alarmProp.notificationTitle, body: alarmProp.notificationBody, payload: 'payload');
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
          title: alarmProp.snackBarDesabledTitle.tr,
          message: alarmProp.snackBarDesabeldBody.tr,
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
      colorText: MyColors.whiteBlack,
      backgroundColor: MyColors.background,
      boxShadows: [BoxShadow(color: MyColors.primary.withOpacity(.5), blurRadius: 30, spreadRadius: 2)],
      titleText: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: MyColors.whiteBlack),
      ),
      messageText: Text(
        message,
        style: TextStyle(fontSize: 16, color: MyColors.whiteBlack),
      ),
    );
  }
}
