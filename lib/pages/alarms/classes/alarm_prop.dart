import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../../moduls/enums.dart';
import '../../../services/notification_api.dart';

class AlarmProp {
  AlarmProp({
    required this.id,
    required this.time,
    required this.storageKey,
    required this.notificationTitle,
    required this.notificationBody,
    required this.snackBarEnabeldTitle,
    required this.snackBarEnabeldBody,
    required this.snackBarDesabledTitle,
    required this.snackBarDesabeldBody,
    required this.alarmPeriod,
    required this.notificationType,
    this.notificationSound = NotificationSound.random,
    this.day = 0,
  });
  RxBool isActive = false.obs;
  int id;
  Rx<Time> time;
  String storageKey;
  String notificationTitle;
  String notificationBody;
  String snackBarEnabeldTitle;
  String snackBarEnabeldBody;
  String snackBarDesabledTitle;
  String snackBarDesabeldBody;
  int day;
  ALarmPeriod alarmPeriod;
  NotificationType notificationType;
  NotificationSound notificationSound;

  Map<String, dynamic> toJson() => {
        'hour': time.value.hour.toString(),
        'minute': time.value.minute.toString(),
        'isActive': isActive.value,
      };

  fromJson(Map<String, dynamic> json) {
    time.value = Time(int.parse(json['hour']), int.parse(json['minute']));
    isActive.value = json['isActive'];
  }
}
