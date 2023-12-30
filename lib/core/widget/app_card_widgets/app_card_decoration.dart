import 'package:flutter/material.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import 'package:zad_almumin/core/utils/constants.dart';

import '../../utils/resources/app_sizes.dart';

class AppCardDecoration extends BoxDecoration {
  const AppCardDecoration({this.color_, this.boxShadow_});
  AppCardDecoration.withPrimery()
      : color_ = Constants.context.themeColors.background,
        boxShadow_ = BoxShadow(
          color: Constants.context.themeColors.primary.withOpacity(0.8),
          blurRadius: .8,
          spreadRadius: .2,
          offset: const Offset(0, 5),
        );
  final Color? color_;
  final BoxShadow? boxShadow_;
  @override
  BorderRadius get borderRadius => BorderRadius.circular(AppSizes.cardRadius);

  @override
  Color get color => color_ ?? Colors.transparent;
  @override
  List<BoxShadow> get boxShadow => [
        boxShadow_ ?? const BoxShadow(),
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          spreadRadius: .5,
        ),
      ];
}
