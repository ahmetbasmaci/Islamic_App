import 'package:flutter/material.dart';

import '../../../../core/utils/enums/enums.dart';

abstract class AlarmModel {
  final String title;
  final AlarmType alarmType;
  bool isActive;

  AlarmModel({
    required this.title,
    required this.isActive,
    required this.alarmType,
  });
}

class RepeatedAlarmModel extends AlarmModel {
  RepeatAlarmType repeatAlarmType;

  RepeatedAlarmModel({
    required super.title,
    required super.isActive,
    required super.alarmType,
    required this.repeatAlarmType,
  });
}

class PeriodicAlarmModel extends AlarmModel {
  ALarmPeriod alarmPeriod;
  TimeOfDay time;
  PeriodicAlarmModel({
    required super.title,
    required super.isActive,
    required super.alarmType,
    required this.alarmPeriod,
    required this.time,
  });
}
