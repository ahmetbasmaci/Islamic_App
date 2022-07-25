import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zad_almumin/constents/colors.dart';
import '../constents/sizes.dart';

TextStyle _headLine1 = GoogleFonts.harmattan(
  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
);

TextStyle _headLine2 = GoogleFonts.harmattan(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  shadows: [
    Shadow(
      blurRadius: 20,
      offset: Offset(0, 0),
      color: Colors.black.withOpacity(.5),
    ),
  ],
);

TextStyle _headLine3 = GoogleFonts.harmattan(
    fontSize: 16, fontWeight: FontWeight.bold, shadows: [Shadow(blurRadius: 20, offset: Offset(0, 3))]);

TextStyle _headLine4 = GoogleFonts.harmattan(fontSize: 19, fontWeight: FontWeight.bold, color: MyColors.settingsTitle);

TextStyle _headLine5 = GoogleFonts.harmattan(fontSize: 14, color: MyColors.settingsContent);

TextStyle _headLine6 = GoogleFonts.harmattan(fontSize: 20, fontWeight: FontWeight.bold);

TextStyle _bodyText1 = GoogleFonts.harmattan(fontSize: 19, height: 1.8, wordSpacing: 2.5);

TextStyle _bodyText2 = GoogleFonts.harmattan(fontSize: 17, color: MyColors.info);

TextStyle _subtitle1 = GoogleFonts.harmattan();

TextStyle _subtitle2 = GoogleFonts.harmattan(fontSize: 18, fontWeight: FontWeight.bold);

class ThemeService {
  final ThemeData lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: MyColors.background,
    appBarTheme: AppBarTheme(
      color: MyColors.background,
      iconTheme: IconThemeData(
        color: MyColors.primary,
        size: MySiezes.icon,
      ),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: MyColors.primary,
      ),
    ),
    drawerTheme: DrawerThemeData(backgroundColor: MyColors.background),
    iconTheme: IconThemeData(color: MyColors.primary, size: MySiezes.icon),
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: MyColors.primary, elevation: 10),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(MyColors.primary),
        foregroundColor: MaterialStateProperty.all(Color.fromARGB(255, 255, 255, 255)),
        elevation: MaterialStateProperty.all(10),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Color.fromARGB(255, 199, 5, 5)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    ),
    backgroundColor: MyColors.background,
    indicatorColor: MyColors.primary,
    bottomAppBarColor: MyColors.primary,
    textTheme: TextTheme(
      headline1: _headLine1.copyWith(color: MyColors.primary),
      headline2: _headLine2.copyWith(color: MyColors.insideHeader),
      headline3: _headLine3,
      headline4: _headLine4.copyWith(color: MyColors.settingsTitle),
      headline5: _headLine5.copyWith(color: MyColors.settingsContent),
      headline6: _headLine6.copyWith(color: MyColors.white),
      bodyText1: _bodyText1.copyWith(color: MyColors.content),
      bodyText2: _bodyText2.copyWith(color: MyColors.info),
      subtitle1: _subtitle1.copyWith(color: MyColors.black),
      subtitle2: _subtitle2.copyWith(color: MyColors.primary),
    ),
  );

  final ThemeData darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: MyColors.backgroundDark,
    appBarTheme: AppBarTheme(
      backgroundColor: MyColors.backgroundDark,
      iconTheme: IconThemeData(
        color: MyColors.primaryDark,
        size: MySiezes.icon,
      ),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: MyColors.primaryDark,
      ),
    ),
    drawerTheme: DrawerThemeData(backgroundColor: MyColors.backgroundDark),
    iconTheme: IconThemeData(color: MyColors.primaryDark, size: MySiezes.icon),
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: MyColors.primaryDark, elevation: 10),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(MyColors.primaryDark),
        foregroundColor: MaterialStateProperty.all(Color.fromARGB(255, 255, 255, 255)),
        elevation: MaterialStateProperty.all(10),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Color.fromARGB(255, 199, 5, 5)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    ),
    primaryColor: MyColors.primaryDark,
    backgroundColor: MyColors.backgroundDark,
    indicatorColor: MyColors.primaryDark,
    bottomAppBarColor: MyColors.primaryDark,
    textTheme: TextTheme(
      headline1: _headLine1.copyWith(color: MyColors.primaryDark),
      headline2: _headLine2.copyWith(color: MyColors.insideHeader),
      headline3: _headLine3,
      headline4: _headLine4.copyWith(color: MyColors.white),
      headline5: _headLine5.copyWith(color: MyColors.settingsContentDark),
      headline6: _headLine6.copyWith(color: MyColors.white),
      bodyText1: _bodyText1.copyWith(color: MyColors.contentDark),
      bodyText2: _bodyText2.copyWith(color: MyColors.info),
      subtitle1: _subtitle1.copyWith(color: MyColors.white),
      subtitle2: _subtitle2.copyWith(color: MyColors.primaryDark),
    ),
  );

  final _getStorage = GetStorage();
  final _darkKeyTheme = 'isDarkMode';

  void _saveThemeData(bool newThemeMode) {
    _getStorage.write(_darkKeyTheme, newThemeMode);
  }

  bool _isSavedDarkMode() {
    return _getStorage.read(_darkKeyTheme) ?? false;
  }

  ThemeMode getThemeMode() {
    return _isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  void changeThemeMode(bool newThemeMode) {
    Get.changeThemeMode(newThemeMode ? ThemeMode.dark : ThemeMode.light);
    _saveThemeData(newThemeMode);
  }
}
