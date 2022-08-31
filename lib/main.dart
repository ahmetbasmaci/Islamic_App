import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/pages/alarmsPage/alarms_page.dart';
import 'package:zad_almumin/pages/quranPage/quran_page.dart';
import 'package:zad_almumin/pages/quranPage/quran_text.dart';
import 'package:zad_almumin/services/app_local.dart';
import 'package:zad_almumin/services/theme_service.dart';
import 'package:zad_almumin/pages/azkar_page.dart';
import 'package:zad_almumin/pages/home_page.dart';
import 'package:zad_almumin/pages/settings_page.dart';
import 'classes/controllers.dart';
import 'constents/constents.dart';
import 'pages/favorite_page.dart';

void main() async {
  await GetStorage.init();

  WidgetsFlutterBinding.ensureInitialized();

  Controllers();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // SqlDb().deleteDB();

    return GetMaterialApp(
      navigatorKey: Constants.navigatorKey,
      localizationsDelegates: [
        AppLocale.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [const Locale('ar'), const Locale('en')],
      localeResolutionCallback: (locales, supportedLocales) {
        return supportedLocales.first;
      },
      locale: Locale('ar'),
      routes: {
        QuranText.id: (context) => QuranText(),
        HomePage.id: (context) => HomePage(),
        SettingsPage.id: (context) => SettingsPage(),
        AlarmPage.id: (context) => AlarmPage(),
        FavoritePage.id: (context) => FavoritePage(),
        AzkarPage.id: (context) => AzkarPage(),
        QuranPage.id: (context) => QuranPage(),
      },
      initialRoute: HomePage.id,
      debugShowCheckedModeBanner: false,
      theme: ThemeService().lightThemeMode,
      darkTheme: ThemeService().darkThemeMode,
      themeMode: ThemeService().getThemeMode(),
    );
  }
}
