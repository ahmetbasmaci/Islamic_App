import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/services/theme_service.dart';
import 'package:zad_almumin/pages/account_page.dart';
import 'package:zad_almumin/pages/azkar_page.dart';
import 'package:zad_almumin/pages/home_page.dart';
import 'package:zad_almumin/pages/settings_page.dart';
import 'classes/controllers.dart';
import 'database/sqldb.dart';
import 'pages/favorite_page.dart';
import 'services/navigation_service.dart';

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
      navigatorKey: NavigationService.navigatorKey,
      routes: {
        HomePage.id: (context) => HomePage(),
        SettingsPage.id: (context) => SettingsPage(),
        AccountPage.id: (context) => AccountPage(),
        FavoritePage.id: (context) => FavoritePage(),
        AzkarPage.id: (context) => AzkarPage(),
      },
      initialRoute: HomePage.id,
      debugShowCheckedModeBanner: false,
      theme: ThemeService().lightThemeMode,
      darkTheme: ThemeService().darkThemeMode,
      themeMode: ThemeService().getThemeMode(),
      home: HomePage(),
    );
  }
}
/*
? quran page
Scaffold(
      body: Container(
        color: Color.fromARGB(255, 235, 235, 235),
        child: Center(
          child: Image.asset(
            'assets/images/50.png',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );

*/
