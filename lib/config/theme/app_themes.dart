import 'package:flutter/material.dart';
import '../../core/utils/resources/app_fonts.dart';
import 'theme_colors.dart';

class AppThemes {
  static List<ThemeData> themes = [_light, _dark].toList();
  static final ThemeColors lightColor = ThemeColors(
    background: const Color(0xFFf5f5f5),
    primary: const Color(0xFFee4e02),
    secondary: const Color(0xFF02a3ee),
    third: const Color(0xFFa3ee02),
    succes: const Color(0xFF02ee4d),
    error: const Color(0xFFee022d),
    warning: const Color(0xFFeec302),
  );
  static final ThemeColors darkColor = ThemeColors(
    background: const Color(0xFF262626),
    primary: const Color(0xFFee4e02),
    secondary: const Color(0xFF02a3ee),
    third: const Color(0xFFa3ee02),
    succes: const Color(0xFF02ee4d),
    error: const Color(0xFFee022d),
    warning: const Color(0xFFeec302),
  );

  static final ThemeData _light = ThemeData(
    colorScheme: ColorScheme.light(
      primary: lightColor.primary,
      error: lightColor.error,
      secondary: lightColor.secondary,
      background: lightColor.background,
    ),
    iconTheme: _appIconThemeData(lightColor.primary),
    iconButtonTheme: _appIconButtonThemeData(lightColor.primary),
    textTheme: _appTextTheme,
  );

  static final ThemeData _dark = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: darkColor.primary,
      error: darkColor.error,
      secondary: darkColor.secondary,
      background: darkColor.background,
    ),
    iconTheme: _appIconThemeData(darkColor.primary),
    iconButtonTheme: _appIconButtonThemeData(darkColor.primary),
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
