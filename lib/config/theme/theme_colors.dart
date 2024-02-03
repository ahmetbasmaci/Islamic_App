import 'package:flutter/material.dart';

class ThemeColors {
  final Color background;
  final Color primary;
  final Color secondary;
  final Color third;
  final Color success;
  final Color error;
  final Color warning;
  final Brightness brightness;
  final Color onError;
  final Color onSuccess;
  final Color onBackground;

  ThemeColors({
    required this.background,
    required this.primary,
    required this.secondary,
    required this.third,
    required this.success,
    required this.error,
    required this.warning,
    required this.brightness,
    required this.onError,
    required this.onSuccess,
    this.onBackground = Colors.transparent,
  });
}
