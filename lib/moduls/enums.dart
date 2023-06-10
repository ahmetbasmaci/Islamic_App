enum ZikrType { all, azkar, allahNames, quran, hadith, sermon, none }

enum ALarmPeriod { daily, weekly, monthly, once, repeat }

enum QuestionType { ayahInJuzAndPage, surahInJuz }

enum PrayerTimeType { fajr, sun, duhr, asr, maghrib, isha }

enum NotificationType { azkar, kahfQuran, randomQuran, fast, moorningAzkar, nightAzkar, hadith, pray }

enum NotificationSound { random, hadith, azhan }

enum SearchFilter { surah, ayah, page }

enum ZikrRepeat { high, medium, low, rare, none }

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

enum MyFonts { uthmanic, uthmanic2, kfgqpc, naskh, arquran, maddina, noorehira, scheherazade }

extension MyFontsExtention on MyFonts {
  String get arabicName {
    switch (this) {
      case MyFonts.uthmanic:
        return 'العثماني';
      case MyFonts.uthmanic2:
        return 'العثماني 2';
      case MyFonts.kfgqpc:
        return 'الكوفي';
      case MyFonts.naskh:
        return 'النسخ';
      // case MyFonts.kufi:
      //   return 'الكوفي';
      case MyFonts.arquran:
        return 'العربي';
      case MyFonts.maddina:
        return 'المدينة';
      case MyFonts.noorehira:
        return 'نور هيرا';
      case MyFonts.scheherazade:
        return 'شهرزاد';
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
  haniRifai,
  abdullaahAwwaad,
  ahmedNeana,
  warshAbdulBasit,
  akramAlALqimy,
  faresAbbad,
  maherAlmuaqly,
  nabilRifa3i,
  naserAlqatami,
  saoodAlShuraym,
  mahmoudAliAlBanna,
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
      case QuranReaders.haniRifai:
        return 'هاني رفاعي';
      case QuranReaders.abdullaahAwwaad:
        return 'عبدالله عواد';
      case QuranReaders.ahmedNeana:
        return 'أحمد نعينع';
      case QuranReaders.warshAbdulBasit:
        return 'ورش - عبد الباسط';
      case QuranReaders.akramAlALqimy:
        return 'أكرم العلاقمي';
      case QuranReaders.faresAbbad:
        return 'فارس عباد';
      case QuranReaders.maherAlmuaqly:
        return 'ماهر المعيقلي';
      case QuranReaders.nabilRifa3i:
        return 'نبيل الرفاعي';
      case QuranReaders.naserAlqatami:
        return 'ناصر القطامي';
      case QuranReaders.saoodAlShuraym:
        return 'سعود الشريم';
      case QuranReaders.mahmoudAliAlBanna:
        return 'محمود علي البنا';
      default:
        return 'null';
    }
  }
}

enum TafseerType { alcalaleyn }

extension TafseerTypeValue on TafseerType {
  int get id {
    switch (this) {
      case TafseerType.alcalaleyn:
        return 2;
    }
  }
    String get arabicName {
    switch (this) {
      case TafseerType.alcalaleyn:
        return "تفسير الجلالين";
    }
  }
}
