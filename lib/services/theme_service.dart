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
  //write regin block
  //region
  TextStyle _bodySmall_main = TextStyle();
  TextStyle _bodySmall_quran = TextStyle();
  TextStyle _bodyMedium_zikrTitle = TextStyle();
  TextStyle _displaySmall_content = TextStyle();
  TextStyle _bodyLarge_blockTitle = TextStyle();
  TextStyle _labelSmall_settingsTitle = TextStyle();
  TextStyle _labelMedium_settingContent = TextStyle();
  TextStyle _headLine6_headers = TextStyle();
  TextStyle _displayMedium_Info = TextStyle();
  TextStyle _displayLarge_dropDownItem = TextStyle();
  TextStyle _titleSmall_dropDownTitle = TextStyle();

  //endregion

  RxBool isDarkMode = false.obs;
  Rx<ThemeData> lightThemeMode = ThemeData.light().obs;
  Rx<ThemeData> darkThemeMode = ThemeData.dark().obs;
  Rx<ThemeData> currentThemeMode = ThemeData().obs;
  final MyLocalCtr _localCtr = Get.find<MyLocalCtr>();
  final _getStorage = GetStorage();
  final _darkKeyTheme = 'isDarkMode';

  updateThemes() {
    updateTextStyles();

    lightThemeMode.value = ThemeData.light().copyWith(
      timePickerTheme: TimePickerThemeData(
        dialHandColor: MyColors.primary(),
        dayPeriodBorderSide: BorderSide(color: MyColors.primary(), width: 1),
      ),
      primaryColor: MyColors.primary_,
      scaffoldBackgroundColor: MyColors.backgroundLight,
      drawerTheme: DrawerThemeData(backgroundColor: MyColors.backgroundLight),
      iconTheme: IconThemeData(color: MyColors.primary_, size: MySiezes.icon),
      floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: MyColors.primary_, elevation: 10),
      indicatorColor: MyColors.primary_,
      bottomAppBarTheme: BottomAppBarTheme(color: MyColors.primary_),
      listTileTheme: ListTileThemeData(
        selectedColor: MyColors.primary_,
        iconColor: MyColors.primary_,
        textColor: MyColors.black,
        selectedTileColor: MyColors.primary_.withOpacity(.8),
      ),
      appBarTheme: AppBarTheme(
        color: MyColors.backgroundLight,
        iconTheme: IconThemeData(color: MyColors.primary_, size: MySiezes.icon),
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: MyColors.primary_),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(MyColors.primary_),
          foregroundColor: MaterialStateProperty.all(Color.fromARGB(255, 255, 255, 255)),
          elevation: MaterialStateProperty.all(10),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Color.fromARGB(255, 199, 5, 5)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        ),
      ),
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: MyColors.primary_,
        onPrimary: MyColors.primary_,
        secondary: MyColors.primary_,
        onSecondary: MyColors.primary_,
        error: MyColors.primary_,
        onError: MyColors.primary_,
        background: MyColors.backgroundLight,
        onBackground: MyColors.backgroundLight,
        surface: MyColors.backgroundLight,
        onSurface: MyColors.black,
        shadow: Colors.transparent,
      ),
      textTheme: TextTheme(
        bodySmall: _bodySmall_main.copyWith(color: Colors.black),
        bodyMedium: _bodyMedium_zikrTitle.copyWith(color: MyColors.second_),
        bodyLarge: _bodyLarge_blockTitle,
        labelSmall: _labelSmall_settingsTitle.copyWith(color: MyColors.settingsTitle),
        labelMedium: _labelMedium_settingContent.copyWith(color: MyColors.settingsContent),
        labelLarge: _headLine6_headers.copyWith(color: MyColors.white), //default
        displaySmall: _displaySmall_content.copyWith(color: MyColors.content),
        displayMedium: _displayMedium_Info.copyWith(color: MyColors.info),
        displayLarge: _displayLarge_dropDownItem.copyWith(color: MyColors.black),
        titleSmall: _titleSmall_dropDownTitle.copyWith(color: MyColors.primary_),
        titleMedium: _bodySmall_quran.copyWith(color: MyColors.primary_),
      ),
    );

    darkThemeMode.value = ThemeData.dark().copyWith(
      timePickerTheme: TimePickerThemeData(
        dialHandColor: MyColors.primary(),
        dayPeriodBorderSide: BorderSide(color: MyColors.primary(), width: 1),
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
          foregroundColor: MaterialStateProperty.all(Color.fromARGB(255, 255, 255, 255)),
          elevation: MaterialStateProperty.all(10),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Color.fromARGB(255, 199, 5, 5)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        ),
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
        onSurface: MyColors.white,
        shadow: Colors.transparent,
      ),
      textTheme: TextTheme(
        bodySmall: _bodySmall_main.copyWith(color: Colors.white),
        bodyMedium: _bodyMedium_zikrTitle.copyWith(color: MyColors.second_),
        bodyLarge: _bodyLarge_blockTitle,
        labelSmall: _labelSmall_settingsTitle.copyWith(color: MyColors.white),
        labelMedium: _labelMedium_settingContent.copyWith(color: MyColors.settingsContentDark),
        labelLarge: _headLine6_headers.copyWith(color: MyColors.white, shadows: []),
        displaySmall: _displaySmall_content.copyWith(color: MyColors.contentDark),
        displayMedium: _displayMedium_Info.copyWith(color: MyColors.info),
        displayLarge: _displayLarge_dropDownItem.copyWith(color: MyColors.white),
        titleSmall: _titleSmall_dropDownTitle.copyWith(color: MyColors.primaryDark),
        titleMedium: _bodySmall_quran.copyWith(color: MyColors.white),
      ),
    );
  }

  void updateTextStyles() {
    String? defaultFontMain = _localCtr.currentLocal.languageCode == "ar"
        ? GetStorage().read<String>('defaultFontMain') ?? MyFonts.uthmanic.name
        : null;
    String defaultFontQuran = GetStorage().read<String>('defaultFontQuran') ?? MyFonts.uthmanic.name;
    _bodySmall_main = TextStyle(
      fontSize: Get.width * .04,
      height: 1.8,
      wordSpacing: 5.5,
      fontWeight: FontWeight.w500,
      fontFamily: defaultFontMain,
    );
    _bodySmall_quran = TextStyle(
      fontSize: Get.width * .04,
      height: 1.8,
      wordSpacing: 5.5,
      fontWeight: FontWeight.w500,
      fontFamily: defaultFontQuran,
    );
    _bodyMedium_zikrTitle = TextStyle(
      fontSize: Get.width * .04,
      fontWeight: FontWeight.bold,
      fontFamily: defaultFontMain,
    );
    _displaySmall_content = TextStyle(
      fontSize: 17,
      height: 1.8,
      wordSpacing: 3.5,
      fontFamily: defaultFontMain,
    );

    _bodyLarge_blockTitle = TextStyle(
      fontSize: Get.width * .04,
      fontWeight: FontWeight.bold,
      fontFamily: defaultFontMain,
    );

    _labelSmall_settingsTitle = TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.bold,
      fontFamily: defaultFontMain,
    );

    _labelMedium_settingContent = TextStyle(
      fontSize: 14,
      color: MyColors.settingsContent,
      fontFamily: defaultFontMain,
    );

    _headLine6_headers = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: defaultFontMain,
    );

    _displayMedium_Info = TextStyle(
      fontSize: 17,
      color: MyColors.info,
      wordSpacing: 3.5,
      fontFamily: defaultFontMain,
    );

    _displayLarge_dropDownItem = TextStyle(
      fontFamily: defaultFontMain,
    );

    _titleSmall_dropDownTitle = TextStyle(
      fontSize: 16,
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
