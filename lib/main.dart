import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/classes/helper_methods.dart';
import 'package:zad_almumin/localization/my_local_ctr.dart';
import 'package:zad_almumin/pages/alarms/alarms_page.dart';
import 'package:zad_almumin/pages/ayahsTest/ayahs_questions.dart';
import 'package:zad_almumin/pages/quran/quran_page.dart';
import 'package:zad_almumin/pages/review_page.dart';
import 'package:zad_almumin/pages/user_reviews_page.dart';
import 'package:zad_almumin/localization/my_local.dart';
import 'package:zad_almumin/services/theme_service.dart';
import 'package:zad_almumin/pages/azkar_page.dart';
import 'package:zad_almumin/pages/home_page.dart';
import 'package:zad_almumin/pages/settings/settings_page.dart';
import 'package:zad_almumin/splash_screen.dart';
import 'classes/controllers_binding.dart';
import 'constents/constants.dart';
import 'pages/favorite/favorite_page.dart';
import 'pages/prayerTimes/prayer_times.dart';

void main() async {
  await GetStorage.init();
  await Constants.setMechineCode();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(MyLocalCtr());
  Get.put(ThemeCtr());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SqlDb().deleteDB();
    return GetMaterialApp(
      initialBinding: ControllerBinding(),
      navigatorKey: Constants.navigatorKey,
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()], //2. registered route observer
      locale: Get.find<MyLocalCtr>().currentLocal,
      translations: MyLocal(),
      routes: {
        SplashPage.id: (context) => SplashPage(),
        HomePage.id: (context) => HomePage(), //'/${HomePage.id}'
        SettingsPage.id: (context) => SettingsPage(),
        AlarmPage.id: (context) => AlarmPage(),
        FavoritePage.id: (context) => FavoritePage(),
        AzkarPage.id: (context) => AzkarPage(),
        QuranPage.id: (context) => QuranPage(),
        AyahsQuestions.id: (context) => AyahsQuestions(),
        ReviewPage.id: (context) => ReviewPage(),
        UserReviews.id: (context) => UserReviews(),
        PrayerTimes.id: (context) => PrayerTimes(),
      },
      // home: DebouncedSearchBar(),
      initialRoute: HelperMethods.isInDebugMode ? HelperMethods.getNewOpendPageId() : SplashPage.id,
      debugShowCheckedModeBanner: false,
      theme: Get.find<ThemeCtr>().lightThemeMode.value,
      darkTheme: Get.find<ThemeCtr>().darkThemeMode.value,
      themeMode: Get.find<ThemeCtr>().getThemeMode(),
    );
  }
}
