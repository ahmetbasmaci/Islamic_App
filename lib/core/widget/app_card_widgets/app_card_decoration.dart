import 'package:flutter/material.dart';

import '../../utils/resources/app_sizes.dart';

class AppCardDecoration extends BoxDecoration {
  const AppCardDecoration({this.color_, this.boxShadow_});
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
