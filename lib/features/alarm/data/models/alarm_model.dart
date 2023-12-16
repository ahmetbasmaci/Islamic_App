import '../../../../core/utils/enums/enums.dart';

abstract class AlarmModel {
  final String title;
  bool isActive;

  AlarmModel({
    required this.title,
    required this.isActive,
  });
}
class RepeatedAlarmModel extends AlarmModel {
  final RepeatAlarmType repeatAlarmType;
  RepeatedAlarmModel({
    required super.title,
    required super.isActive,
    required this.repeatAlarmType,
  });
}

class PeriodicAlarmModel extends AlarmModel {
  final ALarmPeriod aLarmPeriod;
  PeriodicAlarmModel({
    required super.title,
    required super.isActive,
    required this.aLarmPeriod,
  });
}

