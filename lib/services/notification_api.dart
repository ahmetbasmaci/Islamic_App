// ignore_for_file: avoid_print

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:zad_almumin/pages/alarms_page.dart';

import 'json_service.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final NotificationDetails _notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('hadith_alarm'),
        ticker: 'ticker'),
  );
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

  static Future<void> checkPendingNotificationRequests() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
    print('pending alarms ${pendingNotificationRequests.length}');
  }

//! -----------------------------  default alarms ----------------------------- //
  static Future showNotificationNow(
      {int id = 999, required String title, required String body, required String payload}) async {
    await Future.delayed(Duration(seconds: 0));
    await _flutterLocalNotificationsPlugin.show(0, title, body, _notificationDetails, payload: 'item x');
  }

//! -----------------------------  daily alarm ----------------------------- //
  static Future setDailyNotification({required AlarmProp alarmProp}) async {

      await _flutterLocalNotificationsPlugin.zonedSchedule(
        alarmProp.id,
        alarmProp.notificationTitle,
        alarmProp.notificationBody,
        _selectHourAndMinute(hour: alarmProp.timeOfDay.hour, minute: alarmProp.timeOfDay.minute),
        _notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    
  }

//! -----------------------------  weackly alarm ----------------------------- //
  static Future setWeecklyNotifivation({required AlarmProp alarmProp}) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      alarmProp.id,
      alarmProp.notificationTitle,
      alarmProp.notificationBody,
      _selectDateTime(dateTime: alarmProp.day, hour: alarmProp.timeOfDay.hour, minute: alarmProp.timeOfDay.minute),
      _notificationDetails,
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
      _notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
    );
  }

//! -----------------------------  cancell alarms ----------------------------- //
  static Future<void> cancelNotification({required int id}) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

//! -----------------------------  helper methods ----------------------------- //
  static tz.TZDateTime _selectDateTime({required int dateTime, required int hour, int minute = 0}) {
    tz.TZDateTime scheduledDate = _selectHourAndMinute(hour: hour, minute: minute);
    while (scheduledDate.weekday != dateTime) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  static tz.TZDateTime _selectHicriDateTime({required int hour, int minute = 0}) {
    tz.TZDateTime scheduledDate = _selectHourAndMinute(hour: hour, minute: minute);
    var hDate = HijriCalendar.fromDate(DateTime.now());

    while (hDate.hDay != 12) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
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
