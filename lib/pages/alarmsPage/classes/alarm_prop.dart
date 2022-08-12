import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../moduls/enums.dart';

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
