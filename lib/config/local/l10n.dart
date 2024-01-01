// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppStrings {
  AppStrings();

  static AppStrings? _current;

  static AppStrings get current {
    assert(_current != null,
        'No instance of AppStrings was loaded. Try to initialize the AppStrings delegate before accessing AppStrings.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppStrings> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppStrings();
      AppStrings._current = instance;

      return instance;
    });
  }

  static AppStrings of(BuildContext context) {
    final instance = AppStrings.maybeOf(context);
    assert(instance != null,
        'No instance of AppStrings present in the widget tree. Did you add AppStrings.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppStrings? maybeOf(BuildContext context) {
    return Localizations.of<AppStrings>(context, AppStrings);
  }

  // skipped getter for the '' key

  /// `Alarm`
  String get alarm {
    return Intl.message(
      'Alarm',
      name: 'alarm',
      desc: '',
      args: [],
    );
  }

  /// `Alarm Activated`
  String get alarmActivated {
    return Intl.message(
      'Alarm Activated',
      name: 'alarmActivated',
      desc: '',
      args: [],
    );
  }

  /// `Alarm Deactivated`
  String get alarmDeactivated {
    return Intl.message(
      'Alarm Deactivated',
      name: 'alarmDeactivated',
      desc: '',
      args: [],
    );
  }

  /// `Allah Names Azkars`
  String get allahNamesZikr {
    return Intl.message(
      'Allah Names Azkars',
      name: 'allahNamesZikr',
      desc: '',
      args: [],
    );
  }

  /// `App Developer`
  String get appDeveloper {
    return Intl.message(
      'App Developer',
      name: 'appDeveloper',
      desc: '',
      args: [],
    );
  }

  /// `Zad-Almumin`
  String get appName {
    return Intl.message(
      'Zad-Almumin',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Asr`
  String get asr {
    return Intl.message(
      'Asr',
      name: 'asr',
      desc: '',
      args: [],
    );
  }

  /// `Asr Pray`
  String get asrPray {
    return Intl.message(
      'Asr Pray',
      name: 'asrPray',
      desc: '',
      args: [],
    );
  }

  /// `Azhan Time`
  String get azhanTimeTitleAlarm {
    return Intl.message(
      'Azhan Time',
      name: 'azhanTimeTitleAlarm',
      desc: '',
      args: [],
    );
  }

  /// `Category Bookname: `
  String get categoryBookname {
    return Intl.message(
      'Category Bookname: ',
      name: 'categoryBookname',
      desc: '',
      args: [],
    );
  }

  /// `Change app language`
  String get changeLanguage {
    return Intl.message(
      'Change app language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Change app theme`
  String get changeTheme {
    return Intl.message(
      'Change app theme',
      name: 'changeTheme',
      desc: '',
      args: [],
    );
  }

  /// `Chapter Name: `
  String get chapterName {
    return Intl.message(
      'Chapter Name: ',
      name: 'chapterName',
      desc: '',
      args: [],
    );
  }

  /// `The text has been copied to the clipboard`
  String get copiedToClipboard {
    return Intl.message(
      'The text has been copied to the clipboard',
      name: 'copiedToClipboard',
      desc: '',
      args: [],
    );
  }

  /// `Daily Azkar`
  String get dailyAzkarTitleAlarm {
    return Intl.message(
      'Daily Azkar',
      name: 'dailyAzkarTitleAlarm',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get dark {
    return Intl.message(
      'Light',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Diferent Azkar`
  String get diferentAzkar {
    return Intl.message(
      'Diferent Azkar',
      name: 'diferentAzkar',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Dua For Phalastine People`
  String get duaForPhalastinePeople {
    return Intl.message(
      'Dua For Phalastine People',
      name: 'duaForPhalastinePeople',
      desc: '',
      args: [],
    );
  }

  /// `Dua`
  String get duaTitleAlarm {
    return Intl.message(
      'Dua',
      name: 'duaTitleAlarm',
      desc: '',
      args: [],
    );
  }

  /// `Duhr`
  String get duhr {
    return Intl.message(
      'Duhr',
      name: 'duhr',
      desc: '',
      args: [],
    );
  }

  /// `Duhr Pray`
  String get duhrPray {
    return Intl.message(
      'Duhr Pray',
      name: 'duhrPray',
      desc: '',
      args: [],
    );
  }

  /// `Eating Azkars`
  String get eatingZikr {
    return Intl.message(
      'Eating Azkars',
      name: 'eatingZikr',
      desc: '',
      args: [],
    );
  }

  /// `Evening Azkars`
  String get eveningZikr {
    return Intl.message(
      'Evening Azkars',
      name: 'eveningZikr',
      desc: '',
      args: [],
    );
  }

  /// `Fajr`
  String get fajr {
    return Intl.message(
      'Fajr',
      name: 'fajr',
      desc: '',
      args: [],
    );
  }

  /// `Fajr Pray`
  String get fajrPray {
    return Intl.message(
      'Fajr Pray',
      name: 'fajrPray',
      desc: '',
      args: [],
    );
  }

  /// `Fast`
  String get fastTitleAlarm {
    return Intl.message(
      'Fast',
      name: 'fastTitleAlarm',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get favorite {
    return Intl.message(
      'Favorite',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// `Friday`
  String get friday {
    return Intl.message(
      'Friday',
      name: 'friday',
      desc: '',
      args: [],
    );
  }

  /// `Gregorian Date`
  String get gregorianDate {
    return Intl.message(
      'Gregorian Date',
      name: 'gregorianDate',
      desc: '',
      args: [],
    );
  }

  /// `You can read Hadith and Fast Reminder`
  String get hadithAndFastReminderDesc {
    return Intl.message(
      'You can read Hadith and Fast Reminder',
      name: 'hadithAndFastReminderDesc',
      desc: '',
      args: [],
    );
  }

  /// `Hadith and Fast Reminder`
  String get hadithAndFastReminderTitle {
    return Intl.message(
      'Hadith and Fast Reminder',
      name: 'hadithAndFastReminderTitle',
      desc: '',
      args: [],
    );
  }

  /// `Praved Muhammed (PBUH) Hadith`
  String get hadithBigTitle {
    return Intl.message(
      'Praved Muhammed (PBUH) Hadith',
      name: 'hadithBigTitle',
      desc: '',
      args: [],
    );
  }

  /// `Hadith Bookname: `
  String get hadithBookName {
    return Intl.message(
      'Hadith Bookname: ',
      name: 'hadithBookName',
      desc: '',
      args: [],
    );
  }

  /// `Hadith ID: `
  String get hadithId {
    return Intl.message(
      'Hadith ID: ',
      name: 'hadithId',
      desc: '',
      args: [],
    );
  }

  /// `Praved Muhammed (PBUH) Said`
  String get hadithTitle {
    return Intl.message(
      'Praved Muhammed (PBUH) Said',
      name: 'hadithTitle',
      desc: '',
      args: [],
    );
  }

  /// `Hadith`
  String get hadithTitleAlarm {
    return Intl.message(
      'Hadith',
      name: 'hadithTitleAlarm',
      desc: '',
      args: [],
    );
  }

  /// `Haj Azkars`
  String get hajZikr {
    return Intl.message(
      'Haj Azkars',
      name: 'hajZikr',
      desc: '',
      args: [],
    );
  }

  /// `High`
  String get high {
    return Intl.message(
      'High',
      name: 'high',
      desc: '',
      args: [],
    );
  }

  /// `Hijri Date`
  String get hijriDate {
    return Intl.message(
      'Hijri Date',
      name: 'hijriDate',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Home Azkars`
  String get homeZikr {
    return Intl.message(
      'Home Azkars',
      name: 'homeZikr',
      desc: '',
      args: [],
    );
  }

  /// `Isha`
  String get isha {
    return Intl.message(
      'Isha',
      name: 'isha',
      desc: '',
      args: [],
    );
  }

  /// `Isha Pray`
  String get ishaPray {
    return Intl.message(
      'Isha Pray',
      name: 'ishaPray',
      desc: '',
      args: [],
    );
  }

  /// `Juz`
  String get juz {
    return Intl.message(
      'Juz',
      name: 'juz',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get light {
    return Intl.message(
      'Dark',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Low`
  String get low {
    return Intl.message(
      'Low',
      name: 'low',
      desc: '',
      args: [],
    );
  }

  /// `Maghrib`
  String get maghrib {
    return Intl.message(
      'Maghrib',
      name: 'maghrib',
      desc: '',
      args: [],
    );
  }

  /// `Maghrip Pray`
  String get maghripPray {
    return Intl.message(
      'Maghrip Pray',
      name: 'maghripPray',
      desc: '',
      args: [],
    );
  }

  /// `Main`
  String get mainPageTitle {
    return Intl.message(
      'Main',
      name: 'mainPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Medium`
  String get medium {
    return Intl.message(
      'Medium',
      name: 'medium',
      desc: '',
      args: [],
    );
  }

  /// `Monday`
  String get monday {
    return Intl.message(
      'Monday',
      name: 'monday',
      desc: '',
      args: [],
    );
  }

  /// `Monday Fasting`
  String get mondayFasting {
    return Intl.message(
      'Monday Fasting',
      name: 'mondayFasting',
      desc: '',
      args: [],
    );
  }

  /// `Morning Azkars`
  String get morningZikr {
    return Intl.message(
      'Morning Azkars',
      name: 'morningZikr',
      desc: '',
      args: [],
    );
  }

  /// `Mosque Azkars`
  String get mosqueZikr {
    return Intl.message(
      'Mosque Azkars',
      name: 'mosqueZikr',
      desc: '',
      args: [],
    );
  }

  /// `Muslim Zikrs`
  String get muslimZikrs {
    return Intl.message(
      'Muslim Zikrs',
      name: 'muslimZikrs',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get none {
    return Intl.message(
      'None',
      name: 'none',
      desc: '',
      args: [],
    );
  }

  /// `Pray Times`
  String get prayTimes {
    return Intl.message(
      'Pray Times',
      name: 'prayTimes',
      desc: '',
      args: [],
    );
  }

  /// `You can know the pray times`
  String get prayTimesDesc {
    return Intl.message(
      'You can know the pray times',
      name: 'prayTimesDesc',
      desc: '',
      args: [],
    );
  }

  /// `Pray Times`
  String get prayTimesTitle {
    return Intl.message(
      'Pray Times',
      name: 'prayTimesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Prev`
  String get prev {
    return Intl.message(
      'Prev',
      name: 'prev',
      desc: '',
      args: [],
    );
  }

  /// `Program Sections`
  String get programSections {
    return Intl.message(
      'Program Sections',
      name: 'programSections',
      desc: '',
      args: [],
    );
  }

  /// `Praved Muhammed (PBUH) Hadith`
  String get provetMuhammedHadith {
    return Intl.message(
      'Praved Muhammed (PBUH) Hadith',
      name: 'provetMuhammedHadith',
      desc: '',
      args: [],
    );
  }

  /// `You can answer questions about Quran`
  String get questinosAboutQuranDesc {
    return Intl.message(
      'You can answer questions about Quran',
      name: 'questinosAboutQuranDesc',
      desc: '',
      args: [],
    );
  }

  /// `Questinos About Quran`
  String get questinosAboutQuranTitle {
    return Intl.message(
      'Questinos About Quran',
      name: 'questinosAboutQuranTitle',
      desc: '',
      args: [],
    );
  }

  /// `Quran`
  String get quran {
    return Intl.message(
      'Quran',
      name: 'quran',
      desc: '',
      args: [],
    );
  }

  /// `A Random Verse From Quran`
  String get quranBigTitle {
    return Intl.message(
      'A Random Verse From Quran',
      name: 'quranBigTitle',
      desc: '',
      args: [],
    );
  }

  /// `Quran Revidion`
  String get quranRevidion {
    return Intl.message(
      'Quran Revidion',
      name: 'quranRevidion',
      desc: '',
      args: [],
    );
  }

  /// `You can read the Quran Tefsir`
  String get quranTefsirDesc {
    return Intl.message(
      'You can read the Quran Tefsir',
      name: 'quranTefsirDesc',
      desc: '',
      args: [],
    );
  }

  /// `Quran Tefsir`
  String get quranTefsirTitle {
    return Intl.message(
      'Quran Tefsir',
      name: 'quranTefsirTitle',
      desc: '',
      args: [],
    );
  }

  /// `Bismillah Alrahman Alraheem`
  String get quranTitle {
    return Intl.message(
      'Bismillah Alrahman Alraheem',
      name: 'quranTitle',
      desc: '',
      args: [],
    );
  }

  /// `Quran`
  String get quranTitleAlarm {
    return Intl.message(
      'Quran',
      name: 'quranTitleAlarm',
      desc: '',
      args: [],
    );
  }

  /// `Rare`
  String get rare {
    return Intl.message(
      'Rare',
      name: 'rare',
      desc: '',
      args: [],
    );
  }

  /// `Read Kahf Sura`
  String get readKahfSura {
    return Intl.message(
      'Read Kahf Sura',
      name: 'readKahfSura',
      desc: '',
      args: [],
    );
  }

  /// `Read Quean Page Everyday`
  String get readQueanPageEveryday {
    return Intl.message(
      'Read Quean Page Everyday',
      name: 'readQueanPageEveryday',
      desc: '',
      args: [],
    );
  }

  /// `Saturday`
  String get saturday {
    return Intl.message(
      'Saturday',
      name: 'saturday',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Sleep Azkars`
  String get sleepZikr {
    return Intl.message(
      'Sleep Azkars',
      name: 'sleepZikr',
      desc: '',
      args: [],
    );
  }

  /// `Sun`
  String get sun {
    return Intl.message(
      'Sun',
      name: 'sun',
      desc: '',
      args: [],
    );
  }

  /// `Sunday`
  String get sunday {
    return Intl.message(
      'Sunday',
      name: 'sunday',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Thursday`
  String get thursday {
    return Intl.message(
      'Thursday',
      name: 'thursday',
      desc: '',
      args: [],
    );
  }

  /// `Thursday Fasting`
  String get thursdayFasting {
    return Intl.message(
      'Thursday Fasting',
      name: 'thursdayFasting',
      desc: '',
      args: [],
    );
  }

  /// `Toilet Azkars`
  String get toiletZikr {
    return Intl.message(
      'Toilet Azkars',
      name: 'toiletZikr',
      desc: '',
      args: [],
    );
  }

  /// `Travel Azkars`
  String get travelZikr {
    return Intl.message(
      'Travel Azkars',
      name: 'travelZikr',
      desc: '',
      args: [],
    );
  }

  /// `Tuesday`
  String get tuesday {
    return Intl.message(
      'Tuesday',
      name: 'tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Update Pray Times`
  String get updatePrayTimes {
    return Intl.message(
      'Update Pray Times',
      name: 'updatePrayTimes',
      desc: '',
      args: [],
    );
  }

  /// `Wake Up Azkars`
  String get wakeUpZikr {
    return Intl.message(
      'Wake Up Azkars',
      name: 'wakeUpZikr',
      desc: '',
      args: [],
    );
  }

  /// `Wednesday`
  String get wednesday {
    return Intl.message(
      'Wednesday',
      name: 'wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Zad Almumin`
  String get welcomeToApp {
    return Intl.message(
      'Welcome to Zad Almumin',
      name: 'welcomeToApp',
      desc: '',
      args: [],
    );
  }

  /// `You can listen to the whole Quran`
  String get youCanListenAHoleQuran {
    return Intl.message(
      'You can listen to the whole Quran',
      name: 'youCanListenAHoleQuran',
      desc: '',
      args: [],
    );
  }

  /// `Allah Names`
  String get zikrAllahNamesBigTitle {
    return Intl.message(
      'Allah Names',
      name: 'zikrAllahNamesBigTitle',
      desc: '',
      args: [],
    );
  }

  /// `Muslim Azkars`
  String get zikrAllAzkarsBigTitle {
    return Intl.message(
      'Muslim Azkars',
      name: 'zikrAllAzkarsBigTitle',
      desc: '',
      args: [],
    );
  }

  /// `Font Size`
  String get fontSize {
    return Intl.message(
      'Font Size',
      name: 'fontSize',
      desc: '',
      args: [],
    );
  }

  /// `Font Type`
  String get FontType {
    return Intl.message(
      'Font Type',
      name: 'FontType',
      desc: '',
      args: [],
    );
  }

  /// `Add Book Mark`
  String get addBookMark {
    return Intl.message(
      'Add Book Mark',
      name: 'addBookMark',
      desc: '',
      args: [],
    );
  }

  /// `Tafsirs`
  String get tafsirs {
    return Intl.message(
      'Tafsirs',
      name: 'tafsirs',
      desc: '',
      args: [],
    );
  }

  /// `Surah Name`
  String get surahName {
    return Intl.message(
      'Surah Name',
      name: 'surahName',
      desc: '',
      args: [],
    );
  }

  /// `Ayah Number`
  String get ayahNumber {
    return Intl.message(
      'Ayah Number',
      name: 'ayahNumber',
      desc: '',
      args: [],
    );
  }

  /// `Yaser Aldosary`
  String get yaserAldosary {
    return Intl.message(
      'Yaser Aldosary',
      name: 'yaserAldosary',
      desc: '',
      args: [],
    );
  }

  /// `Yaser Alsalamah`
  String get yaserAlsalamah {
    return Intl.message(
      'Yaser Alsalamah',
      name: 'yaserAlsalamah',
      desc: '',
      args: [],
    );
  }

  /// `Ibrahim Aldosary`
  String get ibrahimAldosary {
    return Intl.message(
      'Ibrahim Aldosary',
      name: 'ibrahimAldosary',
      desc: '',
      args: [],
    );
  }

  /// `Ayman Swaid`
  String get aymanSwaid {
    return Intl.message(
      'Ayman Swaid',
      name: 'aymanSwaid',
      desc: '',
      args: [],
    );
  }

  /// `Alhasri`
  String get alhasri {
    return Intl.message(
      'Alhasri',
      name: 'alhasri',
      desc: '',
      args: [],
    );
  }

  /// `Almenshawi`
  String get almenshawi {
    return Intl.message(
      'Almenshawi',
      name: 'almenshawi',
      desc: '',
      args: [],
    );
  }

  /// `AbdulBased`
  String get abdulBased {
    return Intl.message(
      'AbdulBased',
      name: 'abdulBased',
      desc: '',
      args: [],
    );
  }

  /// `Alafasi`
  String get alafasi {
    return Intl.message(
      'Alafasi',
      name: 'alafasi',
      desc: '',
      args: [],
    );
  }

  /// `Abdullah Basfar`
  String get abdullahBasfar {
    return Intl.message(
      'Abdullah Basfar',
      name: 'abdullahBasfar',
      desc: '',
      args: [],
    );
  }

  /// `Abu Bakr Alshatiri`
  String get abuBakrAlshatiri {
    return Intl.message(
      'Abu Bakr Alshatiri',
      name: 'abuBakrAlshatiri',
      desc: '',
      args: [],
    );
  }

  /// `Ahmed Alajamy`
  String get ahmedAlajamy {
    return Intl.message(
      'Ahmed Alajamy',
      name: 'ahmedAlajamy',
      desc: '',
      args: [],
    );
  }

  /// `Hani Rifai`
  String get haniRifai {
    return Intl.message(
      'Hani Rifai',
      name: 'haniRifai',
      desc: '',
      args: [],
    );
  }

  /// `Abdullaah Awwaad`
  String get abdullaahAwwaad {
    return Intl.message(
      'Abdullaah Awwaad',
      name: 'abdullaahAwwaad',
      desc: '',
      args: [],
    );
  }

  /// `Ahmed Neana`
  String get ahmedNeana {
    return Intl.message(
      'Ahmed Neana',
      name: 'ahmedNeana',
      desc: '',
      args: [],
    );
  }

  /// `Warsh AbdulBasit`
  String get warshAbdulBasit {
    return Intl.message(
      'Warsh AbdulBasit',
      name: 'warshAbdulBasit',
      desc: '',
      args: [],
    );
  }

  /// `Akram AlALqimy`
  String get akramAlALqimy {
    return Intl.message(
      'Akram AlALqimy',
      name: 'akramAlALqimy',
      desc: '',
      args: [],
    );
  }

  /// `Fares Abbad`
  String get faresAbbad {
    return Intl.message(
      'Fares Abbad',
      name: 'faresAbbad',
      desc: '',
      args: [],
    );
  }

  /// `Maher Almuaqly`
  String get maherAlmuaqly {
    return Intl.message(
      'Maher Almuaqly',
      name: 'maherAlmuaqly',
      desc: '',
      args: [],
    );
  }

  /// `Nabil Rifa3i`
  String get nabilRifa3i {
    return Intl.message(
      'Nabil Rifa3i',
      name: 'nabilRifa3i',
      desc: '',
      args: [],
    );
  }

  /// `Naser Alqatami`
  String get naserAlqatami {
    return Intl.message(
      'Naser Alqatami',
      name: 'naserAlqatami',
      desc: '',
      args: [],
    );
  }

  /// `Saood AlShuraym`
  String get saoodAlShuraym {
    return Intl.message(
      'Saood AlShuraym',
      name: 'saoodAlShuraym',
      desc: '',
      args: [],
    );
  }

  /// `Mahmoud Ali AlBanna`
  String get mahmoudAliAlBanna {
    return Intl.message(
      'Mahmoud Ali AlBanna',
      name: 'mahmoudAliAlBanna',
      desc: '',
      args: [],
    );
  }

  /// `Surahs`
  String get surahs {
    return Intl.message(
      'Surahs',
      name: 'surahs',
      desc: '',
      args: [],
    );
  }

  /// `Ayahs`
  String get ayahs {
    return Intl.message(
      'Ayahs',
      name: 'ayahs',
      desc: '',
      args: [],
    );
  }

  /// `Pages`
  String get pages {
    return Intl.message(
      'Pages',
      name: 'pages',
      desc: '',
      args: [],
    );
  }

  /// `Page`
  String get page {
    return Intl.message(
      'Page',
      name: 'page',
      desc: '',
      args: [],
    );
  }

  /// `Search for Ayah or Sure or Page`
  String get searchForAyahOrSureOrPage {
    return Intl.message(
      'Search for Ayah or Sure or Page',
      name: 'searchForAyahOrSureOrPage',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `s`
  String get s {
    return Intl.message(
      's',
      name: 's',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppStrings> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'tr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppStrings> load(Locale locale) => AppStrings.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
