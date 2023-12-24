import 'package:zad_almumin/config/local/l10n.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/utils/constants.dart';
import '../../features/alarm/data/models/alarm_model.dart';
import '../../features/pray_times/data/models/time.dart';
import '../utils/enums/enums.dart';

extension AlarmModelExtension on AlarmModel {
  bool get isPeriodicAlarm => this is PeriodicAlarmModel;
}

extension TimeExtension on Time {
  String get formated => '${hour.formated2}:${minute.formated2}';
}

extension AlarmTypeExtentions on AlarmType {
  bool get isAdhanType =>
      this == AlarmType.fajrAdhan ||
      this == AlarmType.duhrAdhan ||
      this == AlarmType.asrAdhan ||
      this == AlarmType.maghribAdhan ||
      this == AlarmType.ishaAdhan;
}

extension RepeatAlarmTypeExtentions on RepeatAlarmType {
  String get translatedName {
    switch (this) {
      case RepeatAlarmType.high:
        return AppStrings.of(Constants.context).high;
      case RepeatAlarmType.medium:
        return AppStrings.of(Constants.context).medium;
      case RepeatAlarmType.low:
        return AppStrings.of(Constants.context).low;
      case RepeatAlarmType.rare:
        return AppStrings.of(Constants.context).rare;
      case RepeatAlarmType.none:
        return AppStrings.of(Constants.context).none;
      default:
        return '';
    }
  }
}

extension PrayTimeTypeExtentions on PrayTimeType {
  String get translatedName {
    switch (this) {
      case PrayTimeType.fajr:
        return AppStrings.of(Constants.context).fajr;
      case PrayTimeType.sun:
        return AppStrings.of(Constants.context).sun;
      case PrayTimeType.duhr:
        return AppStrings.of(Constants.context).duhr;
      case PrayTimeType.asr:
        return AppStrings.of(Constants.context).asr;
      case PrayTimeType.maghrib:
        return AppStrings.of(Constants.context).maghrib;
      case PrayTimeType.isha:
        return AppStrings.of(Constants.context).isha;
      case PrayTimeType.none:
        return AppStrings.of(Constants.context).none;
    }
  }
}

extension TimeExtentions on Time {
  String get timeToString {
    return '${hour.formated2}:${minute.formated2}';
  }
}

extension WeekDaysExtentions on WeekDays {
  String get translatedName {
    switch (this) {
      case WeekDays.saturday:
        return AppStrings.of(Constants.context).saturday;
      case WeekDays.sunday:
        return AppStrings.of(Constants.context).sunday;
      case WeekDays.monday:
        return AppStrings.of(Constants.context).monday;
      case WeekDays.tuesday:
        return AppStrings.of(Constants.context).tuesday;
      case WeekDays.wednesday:
        return AppStrings.of(Constants.context).wednesday;
      case WeekDays.thursday:
        return AppStrings.of(Constants.context).thursday;
      case WeekDays.friday:
        return AppStrings.of(Constants.context).friday;
      case WeekDays.none:
        return AppStrings.of(Constants.context).none;
    }
  }
}
