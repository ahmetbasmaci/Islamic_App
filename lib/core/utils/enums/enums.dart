enum ZikrCategories {
  morning,
  evening,
  wakeUp,
  sleep,
  travel,
  eating,
  mosque,
  home,
  toilet,
  haj,
  allahNames,
}

enum FavoriteZikrCategory {
  all,
  azkar,
  allahNames,
  quran,
  hadiths,
}

enum AlarmPeriod { daily, weekly, monthly, once, repeat }

enum RepeatAlarmType { high, medium, low, rare, none }

enum AlarmPart { dua, hadith, dailyAzkar, quran, fast, pray }

enum AlarmType {
  duaPhalastine,
  hadith,
  diferentAzkar,
  morningAzkar,
  eveningAzkar,
  quranPageEveryDay,
  quranKahfSure,
  mondayFasting,
  thursdayFasting,
  fajrAdhan,
  duhrAdhan,
  asrAdhan,
  maghribAdhan,
  ishaAdhan,
}

enum PrayTimeType { fajr, sun, duhr, asr, maghrib, isha, none }

enum AppConnectivityResult { bluetooth, wifi, ethernet, mobile, none, vpn, other }

enum WeekDays { saturday, sunday, monday, tuesday, wednesday, thursday, friday, none }

enum QuranReader {
  yaserAldosary,
  yaserAlsalamah,
  ibrahimAldosary,
  aymanSwaid,
  alhasri,
  almenshawi,
  abdulBased,
  alafasi,
  abdullahBasfar,
  abdullahMatroud,
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

enum SearchFilter { surahs, ayahs, pages }

enum DownloadState { notDownloaded, downloading, downloaded }

enum FireBaseStorageFileName { tafseers }

enum QuestionType { ayahInJuzAndPage, surahInJuz }

enum AyahsAnswersType { buttons, dropDownMenu }

enum AyahsAnswerStates { currect, wrong, none }

enum AudioPlayerType { playingSingle, playingMultible, singlePauesed, multiblePaused, stopped, none }
