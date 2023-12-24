import 'package:flutter/material.dart';
import 'package:zad_almumin/config/local/l10n.dart';
import 'package:zad_almumin/core/utils/constants.dart';

import '../../features/alarm/data/models/alarm_model.dart';
import '../../features/pray_times/data/models/time.dart';
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
  String get arabicNumber => toString()
      .replaceAll('0', '٠')
      .replaceAll('1', '١')
      .replaceAll('2', '٢')
      .replaceAll('3', '٣')
      .replaceAll('4', '٤')
      .replaceAll('5', '٥')
      .replaceAll('6', '٦')
      .replaceAll('7', '٧')
      .replaceAll('8', '٨')
      .replaceAll('9', '٩');
}

extension StringExtentions on String {
  bool get isBasmalah => contains('بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ');
  Time get apiTimeStringToTimeModel {
    try {
      final time = split(':');
      return Time(hour: int.parse(time[0]), minute: int.parse(time[1]));
    } catch (e) {
      return Time(hour: 0, minute: 0);
    }
  }
}
