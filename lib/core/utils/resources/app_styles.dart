import 'package:flutter/material.dart';
import '../../extentions/extentions.dart';

class AppStyles {
  static TextStyle title(BuildContext context) {
    return context.theme.textTheme.titleLarge ?? const TextStyle();
  }

  static TextStyle title2(BuildContext context) {
    return context.theme.textTheme.titleMedium ?? const TextStyle();
  }

  static TextStyle content(BuildContext context) {
    return context.theme.textTheme.bodyMedium ?? const TextStyle();
  }
}
