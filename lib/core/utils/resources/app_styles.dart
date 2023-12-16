import 'package:flutter/material.dart';
import '../../extentions/extentions.dart';

class AppStyles {
  static TextStyle title(BuildContext context) {
    return context.theme.textTheme.titleLarge ?? TextStyle();
  }

  static TextStyle title2(BuildContext context) {
    return context.theme.textTheme.titleMedium ?? TextStyle();
  }

  static TextStyle content(BuildContext context) {
    return context.theme.textTheme.bodyMedium ?? TextStyle();
  }
}
