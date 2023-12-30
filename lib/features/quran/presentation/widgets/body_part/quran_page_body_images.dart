import 'package:flutter/material.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import 'package:zad_almumin/core/utils/resources/app_images.dart';

class QuranPageBodyImages extends StatelessWidget {
  QuranPageBodyImages({required this.page});
  int page;
  @override
  Widget build(BuildContext context) {
    List<Widget> images = [
      Center(
          child: Image.asset(
        AppImages.quranPage(page),
        color: context.themeColors.onBackground,
      )),
      Center(child: Image.asset(AppImages.quranPageBackground(page))),
    ];
    return Stack(children: images);
  }
}
