import 'package:flutter/material.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import 'package:zad_almumin/core/utils/resources/app_constants.dart';

abstract class QuranQuestionBottonModel {
  final int juz;
  final int page;
  bool isPressed = false;
  QuranQuestionBottonModel({
    required this.juz,
    required this.page,
  });

  Color get backgroundColor;
  Color get textColor;
}

class QuranQuestionCurrectBottonModel extends QuranQuestionBottonModel {
  QuranQuestionCurrectBottonModel({
    required super.juz,
    required super.page,
  });
  @override
  Color get backgroundColor => AppConstants.context.themeColors.success;
  @override
  Color get textColor => AppConstants.context.themeColors.onSuccess;
}

class QuranQuestionWrongBottonModel extends QuranQuestionBottonModel {
  QuranQuestionWrongBottonModel({
    required super.juz,
    required super.page,
  });

  @override
  Color get backgroundColor => AppConstants.context.themeColors.error;
  @override
  Color get textColor => AppConstants.context.themeColors.onError;
}

class QuranQuestionDefaultBottonModel extends QuranQuestionBottonModel {
  QuranQuestionDefaultBottonModel({
    required super.juz,
    required super.page,
  });

  @override
  Color get backgroundColor => AppConstants.context.themeColors.background;
  @override
  Color get textColor => AppConstants.context.themeColors.onBackground;
}
