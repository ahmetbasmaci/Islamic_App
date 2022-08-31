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

// TextStyle _bodyText1 = GoogleFonts.kadwa(, fontSize: 16, height: 1.8, wordSpacing: 3.5);
TextStyle _bodyText1 = GoogleFonts.almarai(fontSize: 16, height: 2.2, fontWeight: FontWeight.w300, wordSpacing: 3.5,);

TextStyle _bodyText2 = GoogleFonts.harmattan(fontSize: 17, color: MyColors.info, wordSpacing: 3.5);

TextStyle _subtitle1 = GoogleFonts.harmattan();

TextStyle _subtitle2 = GoogleFonts.harmattan(fontSize: 16);

class ThemeService {
  final ThemeData lightThemeMode = ThemeData.light().copyWith(
    // fontFamily: 'me_quran_volt_newmet',
    listTileTheme: ListTileThemeData(
      selectedColor: MyColors.primary_,
      iconColor: MyColors.primary_,
      textColor: MyColors.primary_,
      selectedTileColor: MyColors.primary_.withOpacity(.8),
    ),
    scaffoldBackgroundColor: MyColors.backgroundLight,
    appBarTheme: AppBarTheme(
      color: MyColors.backgroundLight,
      iconTheme: IconThemeData(
        color: MyColors.primary_,
        size: MySiezes.icon,
      ),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: MyColors.primary_,
      ),
    ),
    drawerTheme: DrawerThemeData(backgroundColor: MyColors.backgroundLight),
    iconTheme: IconThemeData(color: MyColors.primary_, size: MySiezes.icon),
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: MyColors.primary_, elevation: 10),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(MyColors.primary_),
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
    backgroundColor: MyColors.backgroundLight,
    indicatorColor: MyColors.primary_,
    bottomAppBarColor: MyColors.primary_,
    textTheme: TextTheme(
      headline1: _headLine1.copyWith(color: MyColors.primary_),
      headline2: _headLine2.copyWith(color: MyColors.second_),
      headline3: _headLine3,
      headline4: _headLine4.copyWith(color: MyColors.settingsTitle),
      headline5: _headLine5.copyWith(color: MyColors.settingsContent),
      headline6: _headLine6.copyWith(color: MyColors.white),
      bodyText1: _bodyText1.copyWith(color: MyColors.content),
      bodyText2: _bodyText2.copyWith(color: MyColors.info),
      subtitle1: _subtitle1.copyWith(color: MyColors.black),
      subtitle2: _subtitle2.copyWith(color: MyColors.primary_),
    ),
  );

  final ThemeData darkThemeMode = ThemeData.dark().copyWith(
    listTileTheme: ListTileThemeData(
      selectedColor: MyColors.primaryDark,
      iconColor: MyColors.primaryDark,
      textColor: MyColors.primaryDark,
      selectedTileColor: MyColors.primaryDark.withOpacity(.8),
    ),
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
      headline2: _headLine2.copyWith(color: MyColors.second_),
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
    return _getStorage.read<bool>(_darkKeyTheme) ?? false;
  }

  ThemeMode getThemeMode() {
    return _isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  void changeThemeMode(bool newThemeMode) {
    _saveThemeData(newThemeMode);
    Get.changeThemeMode(newThemeMode ? ThemeMode.dark : ThemeMode.light);
  }
}
