// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:zad_almumin/pages/alarms_page.dart';

import 'json_service.dart';

enum NotificationSound { hadith, random }

class NotificationService {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // static final NotificationDetails _notificationDetails = NotificationDetails(
  //   android: AndroidNotificationDetails(
  //     'your channel id',
  //     'your channel name',
  //     channelDescription: 'your channel description',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     playSound: true,
  //     sound: RawResourceAndroidNotificationSound('hadith_alarm'),
  //     ticker: 'ticker',
  //   ),
  // );
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
    );
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

  static String _getRandomNotificationSound() {
    String soundName = '';
    int randomSound = Random().nextInt(3);

    if (randomSound == 0)
      soundName = 'subhan_allah';
    else if (randomSound == 1)
      soundName = 'alhamdulillah';
    else
      soundName = 'allah_akbar';

    return soundName;
  }

  static NotificationDetails _getNotificationDetails(
      {required NotificationSound notificationSound, required String bigTitle, required String bigBody}) {
    String soundName = '';
    if (notificationSound == NotificationSound.hadith)
      soundName = 'hadith_alarm';
    else
      soundName = _getRandomNotificationSound();
    return NotificationDetails(
        android: AndroidNotificationDetails(
      soundName,
      soundName,
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
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
    await Future.delayed(Duration(seconds: 0)); //TODO set the time to show alarm
    await _flutterLocalNotificationsPlugin.show(
      alarmProp.id,
      alarmProp.notificationTitle,
      alarmProp.notificationBody,
      _getNotificationDetails(
        notificationSound: NotificationSound.random,
        bigTitle: alarmProp.notificationTitle,
        bigBody: alarmProp.notificationBody,
      ),
    );
  }

//! -----------------------------  daily alarm ----------------------------- //
  static Future setDailyNotification({required AlarmProp alarmProp}) async {
    NotificationSound selectedAlarmType = NotificationSound.random;
    if (alarmProp.alarmType == ALarmType.hadith) {
      alarmProp.notificationBody = (await JsonService.getHadithData()).content;
      selectedAlarmType = NotificationSound.hadith;
    }
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      alarmProp.id,
      alarmProp.notificationTitle,
      alarmProp.notificationBody,
      _selectHourAndMinute(hour: alarmProp.timeOfDay.hour, minute: alarmProp.timeOfDay.minute),
      _getNotificationDetails(
        notificationSound: selectedAlarmType,
        bigTitle: alarmProp.notificationTitle,
        bigBody: alarmProp.notificationBody,
      ),
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
      _selectDateTime(dateTime: alarmProp.day, hour: alarmProp.timeOfDay.hour, minute: alarmProp.timeOfDay.minute),
      _getNotificationDetails(
        notificationSound: NotificationSound.random,
        bigTitle: alarmProp.notificationTitle,
        bigBody: alarmProp.notificationBody,
      ),
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
      _selectHicriDateTime(hour: 21, minute: 4),
      _getNotificationDetails(
        notificationSound: NotificationSound.random,
        bigTitle: alarmProp.notificationTitle,
        bigBody: alarmProp.notificationBody,
      ),
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
