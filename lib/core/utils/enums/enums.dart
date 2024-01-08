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

enum SearchFilter { surahs, ayahs, pages }

enum DownloadState { notDownloaded, downloading, downloaded }

enum FireBaseStorageFileName { tafseers }
