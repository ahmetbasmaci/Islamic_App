import 'package:flutter/material.dart';

import '../../features/alarm/data/models/alarm_model.dart';

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
  String get formated2 => toString().padLeft(3, '0');
}

extension StringExtentions on String {
  bool get isBasmalah => contains('بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ');
}
extension AlarmModelExtension on AlarmModel {
  bool get isPeriodicAlarm => this is PeriodicAlarmModel;
}