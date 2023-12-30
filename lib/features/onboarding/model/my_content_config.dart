import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import '../../../core/extentions/extentions.dart';
import '../../../core/utils/resources/resources.dart';

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
          styleDescription: AppStyles.content(context), //MyTexts.quranStyle(fontSize: 20, color: MyColors.whiteBlack),
        );
}
