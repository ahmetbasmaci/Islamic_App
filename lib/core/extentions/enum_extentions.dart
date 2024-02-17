import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/utils/resources/app_constants.dart';
import '../../config/local/l10n.dart';
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
        return AppStrings.of(AppConstants.context).high;
      case RepeatAlarmType.medium:
        return AppStrings.of(AppConstants.context).medium;
      case RepeatAlarmType.low:
        return AppStrings.of(AppConstants.context).low;
      case RepeatAlarmType.rare:
        return AppStrings.of(AppConstants.context).rare;
      case RepeatAlarmType.none:
        return AppStrings.of(AppConstants.context).none;
      default:
        return '';
    }
  }
}

extension PrayTimeTypeExtentions on PrayTimeType {
  String get translatedName {
    switch (this) {
      case PrayTimeType.fajr:
        return AppStrings.of(AppConstants.context).fajr;
      case PrayTimeType.sun:
        return AppStrings.of(AppConstants.context).sun;
      case PrayTimeType.duhr:
        return AppStrings.of(AppConstants.context).duhr;
      case PrayTimeType.asr:
        return AppStrings.of(AppConstants.context).asr;
      case PrayTimeType.maghrib:
        return AppStrings.of(AppConstants.context).maghrib;
      case PrayTimeType.isha:
        return AppStrings.of(AppConstants.context).isha;
      case PrayTimeType.none:
        return AppStrings.of(AppConstants.context).none;
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
        return AppStrings.of(AppConstants.context).saturday;
      case WeekDays.sunday:
        return AppStrings.of(AppConstants.context).sunday;
      case WeekDays.monday:
        return AppStrings.of(AppConstants.context).monday;
      case WeekDays.tuesday:
        return AppStrings.of(AppConstants.context).tuesday;
      case WeekDays.wednesday:
        return AppStrings.of(AppConstants.context).wednesday;
      case WeekDays.thursday:
        return AppStrings.of(AppConstants.context).thursday;
      case WeekDays.friday:
        return AppStrings.of(AppConstants.context).friday;
      case WeekDays.none:
        return AppStrings.of(AppConstants.context).none;
    }
  }
}

extension QuranReadersExtentions on QuranReader {
  String get translatedName {
    switch (this) {
      case QuranReader.yaserAldosary:
        return AppStrings.of(AppConstants.context).yaserAldosary;
      case QuranReader.yaserAlsalamah:
        return AppStrings.of(AppConstants.context).yaserAlsalamah;
      case QuranReader.ibrahimAldosary:
        return AppStrings.of(AppConstants.context).ibrahimAldosary;
      case QuranReader.aymanSwaid:
        return AppStrings.of(AppConstants.context).aymanSwaid;
      case QuranReader.alhasri:
        return AppStrings.of(AppConstants.context).alhasri;
      case QuranReader.almenshawi:
        return AppStrings.of(AppConstants.context).almenshawi;
      case QuranReader.abdulBased:
        return AppStrings.of(AppConstants.context).abdulBased;
      case QuranReader.alafasi:
        return AppStrings.of(AppConstants.context).alafasi;
      case QuranReader.abdullahBasfar:
        return AppStrings.of(AppConstants.context).abdullahBasfar;
      case QuranReader.abuBakrAlshatiri:
        return AppStrings.of(AppConstants.context).abuBakrAlshatiri;
      case QuranReader.ahmedAlajamy:
        return AppStrings.of(AppConstants.context).ahmedAlajamy;
      case QuranReader.haniRifai:
        return AppStrings.of(AppConstants.context).haniRifai;
      case QuranReader.abdullaahAwwaad:
        return AppStrings.of(AppConstants.context).abdullaahAwwaad;
      case QuranReader.ahmedNeana:
        return AppStrings.of(AppConstants.context).ahmedNeana;
      case QuranReader.warshAbdulBasit:
        return AppStrings.of(AppConstants.context).warshAbdulBasit;
      case QuranReader.akramAlALqimy:
        return AppStrings.of(AppConstants.context).akramAlALqimy;
      case QuranReader.faresAbbad:
        return AppStrings.of(AppConstants.context).faresAbbad;
      case QuranReader.maherAlmuaqly:
        return AppStrings.of(AppConstants.context).maherAlmuaqly;
      case QuranReader.nabilRifa3i:
        return AppStrings.of(AppConstants.context).nabilRifa3i;
      case QuranReader.naserAlqatami:
        return AppStrings.of(AppConstants.context).naserAlqatami;
      case QuranReader.saoodAlShuraym:
        return AppStrings.of(AppConstants.context).saoodAlShuraym;
      case QuranReader.mahmoudAliAlBanna:
        return AppStrings.of(AppConstants.context).mahmoudAliAlBanna;
      case QuranReader.abdullahMatroud:
        return AppStrings.of(AppConstants.context).abdullahMatroud;
    }
  }
}

extension SearchFilterExtentions on SearchFilter {
  String get translatedName {
    switch (this) {
      case SearchFilter.surahs:
        return AppStrings.of(AppConstants.context).surahs;
      case SearchFilter.ayahs:
        return AppStrings.of(AppConstants.context).ayahs;
      case SearchFilter.pages:
        return AppStrings.of(AppConstants.context).pages;
    }
  }
}

extension AyahsAnswersTypeExtentions on AyahsAnswersType {
  String get translatedName {
    switch (this) {
      case AyahsAnswersType.buttons:
        return AppStrings.of(AppConstants.context).buttons;
      case AyahsAnswersType.dropDownMenu:
        return AppStrings.of(AppConstants.context).dropDownMenu;
    }
  }
}

extension FavoriteZikrCategoryExtentions on FavoriteZikrCategory {
  String get translatedName {
    switch (this) {
      case FavoriteZikrCategory.all:
        return AppStrings.of(AppConstants.context).all;
      case FavoriteZikrCategory.allahNames:
        return AppStrings.of(AppConstants.context).allahNames;
      case FavoriteZikrCategory.azkar:
        return AppStrings.of(AppConstants.context).azkar;
      case FavoriteZikrCategory.quran:
        return AppStrings.of(AppConstants.context).quran;
      case FavoriteZikrCategory.hadiths:
        return AppStrings.of(AppConstants.context).hadiths;
    }
  }
}

extension AudioPlayerTypeExtention on AudioPlayerType {
  bool get isPlaying {
    return this == AudioPlayerType.playingSingle || this == AudioPlayerType.playingMultible;
  }
}
