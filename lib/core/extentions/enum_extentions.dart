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

extension QuranReadersExtentions on QuranReaders {
  String get translatedName {
    switch (this) {
      case QuranReaders.yaserAldosary:
        return AppStrings.of(Constants.context).yaserAldosary;
      case QuranReaders.yaserAlsalamah:
        return AppStrings.of(Constants.context).yaserAlsalamah;
      case QuranReaders.ibrahimAldosary:
        return AppStrings.of(Constants.context).ibrahimAldosary;
      case QuranReaders.aymanSwaid:
        return AppStrings.of(Constants.context).aymanSwaid;
      case QuranReaders.alhasri:
        return AppStrings.of(Constants.context).alhasri;
      case QuranReaders.almenshawi:
        return AppStrings.of(Constants.context).almenshawi;
      case QuranReaders.abdulBased:
        return AppStrings.of(Constants.context).abdulBased;
      case QuranReaders.alafasi:
        return AppStrings.of(Constants.context).alafasi;
      case QuranReaders.abdullahBasfar:
        return AppStrings.of(Constants.context).abdullahBasfar;
      case QuranReaders.abuBakrAlshatiri:
        return AppStrings.of(Constants.context).abuBakrAlshatiri;
      case QuranReaders.ahmedAlajamy:
        return AppStrings.of(Constants.context).ahmedAlajamy;
      case QuranReaders.haniRifai:
        return AppStrings.of(Constants.context).haniRifai;
      case QuranReaders.abdullaahAwwaad:
        return AppStrings.of(Constants.context).abdullaahAwwaad;
      case QuranReaders.ahmedNeana:
        return AppStrings.of(Constants.context).ahmedNeana;
      case QuranReaders.warshAbdulBasit:
        return AppStrings.of(Constants.context).warshAbdulBasit;
      case QuranReaders.akramAlALqimy:
        return AppStrings.of(Constants.context).akramAlALqimy;
      case QuranReaders.faresAbbad:
        return AppStrings.of(Constants.context).faresAbbad;
      case QuranReaders.maherAlmuaqly:
        return AppStrings.of(Constants.context).maherAlmuaqly;
      case QuranReaders.nabilRifa3i:
        return AppStrings.of(Constants.context).nabilRifa3i;
      case QuranReaders.naserAlqatami:
        return AppStrings.of(Constants.context).naserAlqatami;
      case QuranReaders.saoodAlShuraym:
        return AppStrings.of(Constants.context).saoodAlShuraym;
      case QuranReaders.mahmoudAliAlBanna:
        return AppStrings.of(Constants.context).mahmoudAliAlBanna;
    }
  }
}
