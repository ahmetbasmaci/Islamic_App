import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import '../../../core/extentions/extentions.dart';

class MyContentConfig extends ContentConfig {
  MyContentConfig({
    required BuildContext context,
    required String title,
    required String description,
    required String pathImage,
  }) : super(
          title: title,
          description: description,
          pathImage: pathImage,
          styleTitle:
              context.theme.textTheme.headlineSmall, //MyTexts.quranStyle(fontSize: 25, color: MyColors.whiteBlack),
          styleDescription:
              context.theme.textTheme.bodyMedium, //MyTexts.quranStyle(fontSize: 20, color: MyColors.whiteBlack),
        );
}
