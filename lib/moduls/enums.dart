enum ZikrType { all, azkar, allahNames, quran, hadith, sermon, none }

enum ALarmPeriod { daily, weekly, monthly, once, repeat }

enum QuestionType { ayahInJuzAndPage, surahInJuz }

enum PrayerTimeType { fajr, sun, duhr, asr, maghrib, isha }

enum NotificationType { azkar, kahfQuran, randomQuran, fast, moorningAzkar, nightAzkar, hadith, pray }

enum NotificationSound { random, hadith, azhan }

enum SearchFilter { surah, ayah, page }

enum ZikrRepeat { high, normal, low, rare, none }

enum AyahsAnswersType { buttons, dropDownMenu }

enum AyahsAnswerStates { correct, wrong, none }

extension AyahsAnswerTypesExtention on AyahsAnswersType {
  String get arabicName {
    switch (this) {
      case AyahsAnswersType.buttons:
        return 'أسئلة بأزرار';
      case AyahsAnswersType.dropDownMenu:
        return 'أسئلة بقوائم';
      default:
        return 'null';
    }
  }
}

enum QuranReaders {
  yaserAldosary,
  yaserAlsalamah,
  ibrahimAldosary,
  aymanSwaid,
  alhasri,
  almenshawi,
  abdulBased,
  alafasi,
  abdullahBasfar,
  abuBakrAlshatiri,
  ahmedAlajamy,
}

extension QuranReadersExtention on QuranReaders {
  String get arabicName {
    switch (this) {
      case QuranReaders.yaserAldosary:
        return 'ياسر الدوسري';
      case QuranReaders.yaserAlsalamah:
        return 'ياسر السلامة';
      case QuranReaders.ibrahimAldosary:
        return 'ابراهيم الدوسري';
      case QuranReaders.aymanSwaid:
        return 'أيمن سويد';
      case QuranReaders.alhasri:
        return 'الحصري';
      case QuranReaders.almenshawi:
        return 'المنشاوي';
      case QuranReaders.abdulBased:
        return 'عبد الباسط';
      case QuranReaders.alafasi:
        return 'العفاسي';
      case QuranReaders.abdullahBasfar:
        return 'عبد الله بصفر';
      case QuranReaders.abuBakrAlshatiri:
        return 'ابو بكر الشاطري';
      case QuranReaders.ahmedAlajamy:
        return 'أحمد العجمي';
      default:
        return 'null';
    }
  }

  void talk() {}
}
