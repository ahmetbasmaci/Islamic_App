// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:zad_almumin/pages/azkar_page.dart';
import 'package:zad_almumin/pages/home_page.dart';
import 'package:zad_almumin/pages/prayerTimes/prayer_times.dart';
import 'package:zad_almumin/pages/quran/quran_page.dart';
import 'package:zad_almumin/pages/settings/settings_ctr.dart';
import '../moduls/enums.dart';
import '../pages/alarms/classes/alarm_prop.dart';
import 'json_service.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  NotificationService() {
    init();
  }
  static init() async {
    await _configureLocalTimeZone();

    await _flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: IOSInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        ),
        macOS: MacOSInitializationSettings(),
      ),
      onSelectNotification: onSelectedNotification,
    );
  }

  static void onSelectedNotification(String? payload) async {
    Transition getRandomTransition() => Transition.values.elementAt(Random().nextInt(Transition.values.length));
    void goToPage(Widget page) =>
        Get.to(() => page, transition: getRandomTransition(), duration: Duration(milliseconds: 500));

    if (payload != null) {
      Get.closeAllSnackbars();

      if (payload == NotificationType.kahfQuran.name)
        goToPage(QuranPage(showInKahf: true));
      else if (payload == NotificationType.randomQuran.name)
        goToPage(QuranPage());
      else if (payload == NotificationType.fast.name)
        goToPage(HomePage());
      else if (payload == NotificationType.moorningAzkar.name)
        goToPage(AzkarPage(zikrType: ZikrType.azkar, zikrIndexInJson: 0));
      else if (payload == NotificationType.nightAzkar.name)
        goToPage(AzkarPage(zikrType: ZikrType.azkar, zikrIndexInJson: 1));
      else if (payload == NotificationType.hadith.name)
        goToPage(HomePage());
      else if (payload == NotificationType.pray.name) goToPage(PrayerTimes());
    }
  }

  static Future<void> _configureLocalTimeZone() async {
    //initilize the tz.local timezone
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

//! -----------------------------  helper methods ----------------------------- //
  static Future<void> checkPendingNotificationRequests() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
    print('pending alarms ${pendingNotificationRequests.length}');
  }

  static String getNotificationSound(NotificationSound notificationSound) {
    String soundName = '';

    if (notificationSound == NotificationSound.random) {
      int randomSound = Random().nextInt(3);

      if (randomSound == 0)
        soundName = 'subhan_allah';
      else if (randomSound == 1)
        soundName = 'alhamdulillah';
      else
        soundName = 'allah_akbar';
    } else if (notificationSound == NotificationSound.hadith)
      soundName = 'hadith_alarm';
    else if (notificationSound == NotificationSound.azhan) soundName = 'adhan_madina';

    return soundName;
  }

  static NotificationDetails _getNotificationDetails({
    required NotificationSound notificationSound,
    required String bigTitle,
    required String bigBody,
  }) {
    String soundName = getNotificationSound(notificationSound);
    bool isNotificationOn = Get.find<SettingsCtr>().isNotificationSoundOn.value;
    return NotificationDetails(
        android: AndroidNotificationDetails(
      soundName + isNotificationOn.toString(),
      soundName,
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      playSound: isNotificationOn,
      // playSound: Get.find<SettingsCtr>().isNotificationSoundOn.value,
      sound: RawResourceAndroidNotificationSound(soundName),
      ticker: 'ticker',
      styleInformation: BigTextStyleInformation(
        bigBody,
        htmlFormatBigText: true,
        contentTitle: '<b>$bigTitle</b>',
        htmlFormatContentTitle: true,
        summaryText: '',
        htmlFormatSummaryText: true,
      ),
    ));
  }

//! -----------------------------  default alarms ----------------------------- //
  static Future showNotificationNow(
      {int id = 999, required String title, required String body, required String payload}) async {
    await Future.delayed(Duration(seconds: 0));
    await _flutterLocalNotificationsPlugin.show(0, title, body,
        _getNotificationDetails(notificationSound: NotificationSound.random, bigTitle: title, bigBody: body),
        payload: 'item x');
  }

//! -----------------------------  once alarm ----------------------------- //
  static Future setOnceNotification({required AlarmProp alarmProp}) async {
    await Future.delayed(Duration(seconds: 0));
    if (alarmProp.notificationType == NotificationType.hadith)
      alarmProp.notificationBody = (await JsonService.getHadithData()).content;
    else if (alarmProp.notificationType == NotificationType.azkar)
      alarmProp.notificationBody = await JsonService.getRandomZikr();

    await _flutterLocalNotificationsPlugin.show(
      alarmProp.id,
      alarmProp.notificationTitle,
      alarmProp.notificationBody,
      _getNotificationDetails(
        notificationSound: alarmProp.notificationSound,
        bigTitle: alarmProp.notificationTitle,
        bigBody: alarmProp.notificationBody,
      ),
      payload: alarmProp.notificationType.name,
    );
  }

  static Future setRepeatNotification({required AlarmProp alarmProp}) async {
    //get random content
    if (alarmProp.notificationType == NotificationType.hadith)
      alarmProp.notificationBody = (await JsonService.getHadithData()).content;
    else if (alarmProp.notificationType == NotificationType.azkar)
      alarmProp.notificationBody = await JsonService.getRandomZikr();

    //set random duration by selected repeat type
    Duration duration = Duration(seconds: 0);
    if (alarmProp.zikrRepeat == ZikrRepeat.high)
      duration = Duration(minutes: Random().nextInt(40) + 40); //40-80
    else if (alarmProp.zikrRepeat == ZikrRepeat.high)
      duration = Duration(minutes: Random().nextInt(70) + 80); //80-150
    else if (alarmProp.zikrRepeat == ZikrRepeat.high)
      duration = Duration(minutes: Random().nextInt(150) + 150); //150-300
    else if (alarmProp.zikrRepeat == ZikrRepeat.high)
      duration = Duration(minutes: Random().nextInt(200) + 600); //300-500

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      alarmProp.id,
      alarmProp.notificationTitle,
      alarmProp.notificationBody,
      tz.TZDateTime.now(tz.local).add(duration),
      _getNotificationDetails(
        notificationSound: alarmProp.notificationSound,
        bigTitle: alarmProp.notificationTitle,
        bigBody: alarmProp.notificationBody,
      ),
      payload: alarmProp.notificationType.name,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    await Future.delayed(duration * 2);

    if (alarmProp.isActive.value) setRepeatNotification(alarmProp: alarmProp);
  }

//! -----------------------------  daily alarm ----------------------------- //
  static Future setDailyNotification({required AlarmProp alarmProp}) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      alarmProp.id,
      alarmProp.notificationTitle,
      alarmProp.notificationBody,
      _selectHourAndMinute(hour: alarmProp.time.value.hour, minute: alarmProp.time.value.minute),
      _getNotificationDetails(
        notificationSound: alarmProp.notificationSound,
        bigTitle: alarmProp.notificationTitle,
        bigBody: alarmProp.notificationType == NotificationType.hadith
            ? (await JsonService.getHadithData()).content
            : alarmProp.notificationBody,
      ),
      payload: alarmProp.notificationType.name,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

//! -----------------------------  weeckly alarm ----------------------------- //
  static Future setWeecklyNotifivation({required AlarmProp alarmProp}) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      alarmProp.id,
      alarmProp.notificationTitle,
      alarmProp.notificationBody,
      _selectDateTime(dateTime: alarmProp.day, hour: alarmProp.time.value.hour, minute: alarmProp.time.value.minute),
      _getNotificationDetails(
        notificationSound: alarmProp.notificationSound,
        bigTitle: alarmProp.notificationTitle,
        bigBody: alarmProp.notificationBody,
      ),
      payload: alarmProp.notificationType.name,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

//! -----------------------------  monthly alarms ----------------------------- //
  static Future setWhiteDaysFastNotification({required AlarmProp alarmProp}) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      alarmProp.id,
      alarmProp.notificationTitle,
      alarmProp.notificationBody,
      _selectHicriDateTime(hour: alarmProp.time.value.hour, minute: alarmProp.time.value.minute),
      _getNotificationDetails(
        notificationSound: alarmProp.notificationSound,
        bigTitle: alarmProp.notificationTitle,
        bigBody: alarmProp.notificationBody,
      ),
      payload: alarmProp.notificationType.name,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
    );
  }

//! -----------------------------  cancell alarms ----------------------------- //
  static Future<void> cancelNotification({required int id}) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

//! -----------------------------  set time methods ----------------------------- //
  static tz.TZDateTime _selectDateTime({required int dateTime, required int hour, int minute = 0}) {
    tz.TZDateTime scheduledDate = _selectHourAndMinute(hour: hour, minute: minute);
    while (scheduledDate.weekday != dateTime) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  static tz.TZDateTime _selectHicriDateTime({required int hour, int minute = 0}) {
    tz.TZDateTime scheduledDate = _selectHourAndMinute(hour: hour, minute: minute);
    int hDay = HijriCalendar.fromDate(scheduledDate).hDay;
    while (hDay != 12) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
      hDay = HijriCalendar.fromDate(scheduledDate).hDay;
    }
    return scheduledDate;
  }

  static tz.TZDateTime _selectHourAndMinute({required int hour, int minute = 0}) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
