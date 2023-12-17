import 'package:flutter/material.dart';
import 'package:zad_almumin/config/local/l10n.dart';
import 'package:zad_almumin/core/utils/constants.dart';

import '../../features/alarm/data/models/alarm_model.dart';
import '../utils/enums/enums.dart';

extension ContextExtentions on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  ThemeData get theme => Theme.of(this);
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get backgroundColor => Theme.of(this).colorScheme.background;
  String? get currentRoute => ModalRoute.of(this)?.settings.name;
  String get localeCode => Localizations.localeOf(this).languageCode;
  bool get isArabicLang => localeCode == 'ar';

  double textScaler(double fontSize) => MediaQuery.of(this).textScaler.scale(fontSize);
}

extension IntExtentions on int {
  String get formated3 => toString().padLeft(3, '0');
  String get formated2 => toString().padLeft(2, '0');
}

extension StringExtentions on String {
  bool get isBasmalah => contains('بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ');
  TimeOfDay get toTimeOfDay {
    try {
      final time = split(':');
      return TimeOfDay(hour: int.parse(time[0]), minute: int.parse(time[1]));
    } catch (e) {
      return TimeOfDay(hour: 0, minute: 0);
    }
  }
}

extension AlarmModelExtension on AlarmModel {
  bool get isPeriodicAlarm => this is PeriodicAlarmModel;
}

extension TimeOfDayExtension on TimeOfDay {
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
