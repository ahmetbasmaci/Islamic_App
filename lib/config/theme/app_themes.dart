import 'package:flutter/material.dart';
import '../../core/utils/resources/app_fonts.dart';

class AppThemes {
  static List<ThemeData> themes = [_light, _dark].toList();

  static const Color _lightPrimaryColor = Color.fromARGB(255, 27, 96, 30);
  static const Color _darkPrimaryColor = Color.fromARGB(255, 37, 74, 38);
  static final ThemeData _light = ThemeData(
    colorScheme: ColorScheme.light(primary: _lightPrimaryColor),
    iconTheme: _appIconThemeData(_lightPrimaryColor),
    iconButtonTheme: _appIconButtonThemeData(_lightPrimaryColor),
    textTheme: _appTextTheme,
  );

  static final ThemeData _dark = ThemeData(
    colorScheme: ColorScheme.dark(primary: _darkPrimaryColor),
    iconTheme: _appIconThemeData(_darkPrimaryColor),
    iconButtonTheme: _appIconButtonThemeData(_darkPrimaryColor),
    textTheme: _appTextTheme,
  );
  static IconThemeData _appIconThemeData(Color primaryColor) {
    return IconThemeData(color: primaryColor);
  }

  static IconButtonThemeData _appIconButtonThemeData(Color primaryColor) {
    return IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(primaryColor),
      ),
    );
  }

  static TextTheme get _appTextTheme {
    String fontFamily = AppFonts.uthmanic.name;
    return TextTheme(
      bodyMedium: TextStyle(fontFamily: fontFamily),
      bodyLarge: TextStyle(fontFamily: fontFamily),
    );
  }
}
