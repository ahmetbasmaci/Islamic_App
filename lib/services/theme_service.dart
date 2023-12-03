// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/localization/my_local_ctr.dart';
import 'package:zad_almumin/moduls/enums.dart';
import '../constents/my_sizes.dart';

class ThemeCtr extends GetxController {
  ThemeCtr() {
    updateThemes();
  }

  TextStyle bodySmall_main = TextStyle();
  TextStyle bodySmall_quran = TextStyle();
  TextStyle bodyMedium_zikrTitle = TextStyle();
  TextStyle displaySmall_content = TextStyle();
  TextStyle bodyLarge_blockTitle = TextStyle();
  TextStyle labelSmall_settingsTitle = TextStyle();
  TextStyle labelMedium_settingContent = TextStyle();
  TextStyle headLine6_headers = TextStyle();
  TextStyle displayMedium_Info = TextStyle();
  TextStyle displayLarge_dropDownItem = TextStyle();
  TextStyle titleSmall_dropDownTitle = TextStyle();
  TextStyle titleLarge_outsideCard = TextStyle();

  RxBool isDarkMode = false.obs;
  Rx<ThemeData> lightThemeMode = ThemeData.light().obs;
  Rx<ThemeData> darkThemeMode = ThemeData.dark().obs;
  Rx<ThemeData> currentThemeMode = ThemeData().obs;
  final MyLocalCtr _localCtr = Get.find<MyLocalCtr>();
  final _getStorage = GetStorage();
  final _darkKeyTheme = 'isDarkMode';

  void updateThemes() {
    updatePrimeryColor();

    updateTextStyles();

    lightThemeMode.value = ThemeData.light().copyWith(
      timePickerTheme: TimePickerThemeData(
        dialHandColor: MyColors.primary,
        dayPeriodBorderSide: BorderSide(color: MyColors.primary, width: 1),
      ),
      primaryColor: MyColors.primaryLight,
      scaffoldBackgroundColor: MyColors.backgroundLight,
      drawerTheme: DrawerThemeData(backgroundColor: MyColors.backgroundLight),
      iconTheme: IconThemeData(color: MyColors.primaryLight, size: MySiezes.icon),
      floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: MyColors.primaryLight, elevation: 10),
      indicatorColor: MyColors.primaryLight,
      bottomAppBarTheme: BottomAppBarTheme(color: MyColors.primaryLight),
      listTileTheme: ListTileThemeData(
        selectedColor: MyColors.primaryLight,
        iconColor: MyColors.primaryLight,
        textColor: MyColors.black,
        selectedTileColor: MyColors.primaryLight.withOpacity(.8),
      ),
      appBarTheme: AppBarTheme(
        color: MyColors.backgroundLight,
        iconTheme: IconThemeData(color: MyColors.primaryLight, size: MySiezes.icon),
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: MyColors.primaryLight),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(MyColors.primaryLight),
          foregroundColor: MaterialStateProperty.all(MyColors.white),
          elevation: MaterialStateProperty.all(10),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(MyColors.wrongLight),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(MyColors.primaryLight),
        checkColor: MaterialStateProperty.all(MyColors.backgroundLight),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: MyColors.primaryLight,
        onPrimary: MyColors.primaryLight,
        secondary: MyColors.second,
        onSecondary: MyColors.primaryLight,
        error: MyColors.primaryLight,
        onError: MyColors.primaryLight,
        background: MyColors.backgroundLight,
        onBackground: MyColors.backgroundLight,
        surface: MyColors.backgroundLight,
        onSurface: MyColors.primaryLight,
        shadow: Colors.transparent,
      ),
      textTheme: TextTheme(
        bodySmall: bodySmall_main.copyWith(color: Colors.black),
        bodyMedium: bodyMedium_zikrTitle.copyWith(color: MyColors.primaryLight),
        bodyLarge: bodyLarge_blockTitle,
        labelSmall: labelSmall_settingsTitle.copyWith(color: MyColors.settingsTitle),
        labelMedium: labelMedium_settingContent.copyWith(color: MyColors.settingsContentLight),
        labelLarge: headLine6_headers.copyWith(color: MyColors.white), //default
        displaySmall: displaySmall_content.copyWith(color: MyColors.contentLight),
        displayMedium: displayMedium_Info.copyWith(color: MyColors.secondLight),
        displayLarge: displayLarge_dropDownItem.copyWith(color: MyColors.black),
        titleSmall: titleSmall_dropDownTitle.copyWith(color: MyColors.primaryLight),
        titleMedium: bodySmall_quran.copyWith(color: MyColors.primaryLight),
        titleLarge: titleLarge_outsideCard.copyWith(color: MyColors.primaryLight),
      ),
    );

    darkThemeMode.value = ThemeData.dark().copyWith(
      timePickerTheme: TimePickerThemeData(
        dialHandColor: MyColors.primary,
        dayPeriodBorderSide: BorderSide(color: MyColors.primary, width: 1),
      ),
      primaryColor: MyColors.primaryDark,
      scaffoldBackgroundColor: MyColors.backgroundDark,
      drawerTheme: DrawerThemeData(backgroundColor: MyColors.backgroundDark),
      iconTheme: IconThemeData(color: MyColors.primaryDark, size: MySiezes.icon),
      floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: MyColors.primaryDark, elevation: 10),
      indicatorColor: MyColors.primaryDark,
      listTileTheme: ListTileThemeData(
        selectedColor: MyColors.primaryDark,
        iconColor: MyColors.primaryDark,
        textColor: MyColors.white,
        selectedTileColor: MyColors.primaryDark.withOpacity(.8),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: MyColors.backgroundDark,
        iconTheme: IconThemeData(color: MyColors.primaryDark, size: MySiezes.icon),
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: MyColors.primaryDark),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(MyColors.primaryDark),
          foregroundColor: MaterialStateProperty.all(MyColors.white),
          elevation: MaterialStateProperty.all(10),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(MyColors.wrongDark),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(MyColors.primaryDark),
        checkColor: MaterialStateProperty.all(MyColors.backgroundDark),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: MyColors.primaryDark,
        onPrimary: MyColors.primaryDark,
        secondary: MyColors.primaryDark,
        onSecondary: MyColors.primaryDark,
        error: MyColors.primaryDark,
        onError: MyColors.primaryDark,
        background: MyColors.backgroundDark,
        onBackground: MyColors.backgroundDark,
        surface: MyColors.backgroundDark,
        onSurface: MyColors.primaryDark,
        shadow: Colors.transparent,
      ),
      textTheme: TextTheme(
        bodySmall: bodySmall_main.copyWith(color: Colors.white),
        bodyMedium: bodyMedium_zikrTitle.copyWith(color: MyColors.primaryDark),
        bodyLarge: bodyLarge_blockTitle,
        labelSmall: labelSmall_settingsTitle.copyWith(color: MyColors.white),
        labelMedium: labelMedium_settingContent.copyWith(color: MyColors.settingsContentDark),
        labelLarge: headLine6_headers.copyWith(color: MyColors.white, shadows: []),
        displaySmall: displaySmall_content.copyWith(color: MyColors.contentDark),
        displayMedium: displayMedium_Info.copyWith(color: MyColors.secondDark),
        displayLarge: displayLarge_dropDownItem.copyWith(color: MyColors.white),
        titleSmall: titleSmall_dropDownTitle.copyWith(color: MyColors.primaryDark),
        titleMedium: bodySmall_quran.copyWith(color: MyColors.white),
        titleLarge: titleLarge_outsideCard.copyWith(color: MyColors.primaryDark),
      ),
    );
  }

  void updatePrimeryColor() {
    GetStorage storage = GetStorage();
    int primaryLigth = storage.read<int>('primary_') ?? MyColors.primaryLight.value;
    int primaryDark = storage.read<int>('primaryDark') ?? MyColors.primaryDark.value;
    MyColors.updatePrimaryColor(primaryLigth, primaryDark);
  }

  void updateTextStyles() {
    GetStorage storage = GetStorage();
    String defaultFontMain = _localCtr.currentLocal.languageCode == "ar"
        ? storage.read<String>('defaultFontMain') ?? MyFonts.uthmanic.name
        : FontStyle.normal.name;
    String defaultFontQuran = storage.read<String>('defaultFontQuran') ?? MyFonts.uthmanic.name;
    bodySmall_main = TextStyle(
      fontSize: 17,
      height: 1.8,
      wordSpacing: 5.5,
      fontWeight: FontWeight.w500,
      fontFamily: defaultFontMain,
    );
    bodySmall_quran = TextStyle(
      fontSize: 17,
      height: 1.8,
      wordSpacing: 5.5,
      fontWeight: FontWeight.w500,
      fontFamily: defaultFontQuran,
    );
    bodyMedium_zikrTitle = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.bold,
      fontFamily: defaultFontMain,
    );
    displaySmall_content = TextStyle(
      fontSize: 17,
      height: 1.8,
      wordSpacing: 3.5,
      fontFamily: defaultFontMain,
    );

    bodyLarge_blockTitle = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.bold,
      fontFamily: defaultFontMain,
    );

    labelSmall_settingsTitle = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      fontFamily: defaultFontMain,
    );

    labelMedium_settingContent = TextStyle(
      fontSize: 15,
      color: MyColors.settingsContentLight,
      fontFamily: defaultFontMain,
    );

    headLine6_headers = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: defaultFontMain,
    );
    titleLarge_outsideCard = TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.bold,
      fontFamily: defaultFontMain,
    );

    displayMedium_Info = TextStyle(
      fontSize: 15,
      color: MyColors.second,
      wordSpacing: 3.5,
      fontFamily: defaultFontMain,
    );

    displayLarge_dropDownItem = TextStyle(
      fontFamily: defaultFontMain,
    );

    titleSmall_dropDownTitle = TextStyle(
      fontSize: 19,
      fontFamily: defaultFontMain,
    );
  }

  void _saveThemeData(bool newThemeMode) => _getStorage.write(_darkKeyTheme, newThemeMode);

  bool _isSavedDarkMode() => _getStorage.read<bool>(_darkKeyTheme) ?? false;

  ThemeMode getThemeMode() => _isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;

  void changeThemeMode(bool isDarkMode) async {
    updateThemes();
    currentThemeMode.value = isDarkMode ? darkThemeMode.value : lightThemeMode.value;
    Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    _saveThemeData(isDarkMode);
    this.isDarkMode.value = Get.isDarkMode;
  }
}
