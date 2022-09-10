import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:zad_almumin/pages/alarms/alarms_page.dart';
import 'package:zad_almumin/pages/quran/quran_page.dart';
import 'package:zad_almumin/pages/quran/quran_text.dart';
import 'package:zad_almumin/services/app_local.dart';
import 'package:zad_almumin/services/theme_service.dart';
import 'package:zad_almumin/pages/azkar_page.dart';
import 'package:zad_almumin/pages/home_page.dart';
import 'package:zad_almumin/pages/settings_page.dart';
import 'bacground_audio_page.dart';
import 'classes/controllers.dart';
import 'constents/constents.dart';
import 'pages/favorite/favorite_page.dart';

import 'dart:async';
import 'dart:math';
import 'package:audio_service/audio_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as rcDart;

// global variable.
late AudioHandler audioHandler;
void main() async {
  await GetStorage.init();

  WidgetsFlutterBinding.ensureInitialized();

  Controllers();

  // await JustAudioBackground.init(
  //   androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
  //   androidNotificationChannelName: 'Audio playback',
  //   androidNotificationOngoing: true,
  // );
  audioHandler = await AudioService.init(
    builder: () => AudioPlayerHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  String lastOpendPageId = '';

  @override
  Widget build(BuildContext context) {
    // SqlDb().deleteDB();

    lastOpendPageId = Constants.getNewOpendPageId();

    return GetMaterialApp(
      navigatorKey: Constants.navigatorKey,
      localizationsDelegates: [
        AppLocale.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [const Locale('ar')],
      localeResolutionCallback: (locales, supportedLocales) {
        return supportedLocales.first;
      },
      locale: Locale('ar'),
      // routes: {
      //   QuranText.id: (context) => QuranText(),
      //   HomePage.id: (context) => HomePage(),
      //   SettingsPage.id: (context) => SettingsPage(),
      //   AlarmPage.id: (context) => AlarmPage(),
      //   FavoritePage.id: (context) => FavoritePage(),
      //   AzkarPage.id: (context) => AzkarPage(),
      //   QuranPage.id: (context) => QuranPage(),
      // },
      // initialRoute: lastOpendPageId,
      debugShowCheckedModeBanner: false,
      theme: ThemeService().lightThemeMode,
      darkTheme: ThemeService().darkThemeMode,
      themeMode: ThemeService().getThemeMode(),
      home: MainScreen(),
    );
  }
}
