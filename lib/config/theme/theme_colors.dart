import 'package:flutter/material.dart';

class ThemeColors {
  final Color background;
  final Color primary;
  final Color secondary;
  final Color third;
  final Color succes;
  final Color error;
  final Color warning;
  final Color onBackground;

  ThemeColors({
    required this.background,
    required this.primary,
    required this.secondary,
    required this.third,
    required this.succes,
    required this.error,
    required this.warning,
    this.onBackground = Colors.transparent,
  });
}
