import 'package:flutter/material.dart';
import 'package:zad_almumin/constents/my_colors.dart';

class QuranPageBodyImages extends StatelessWidget {
  QuranPageBodyImages({required this.page});
  int page;
  @override
  Widget build(BuildContext context) {
    List<Widget> images = [
      Center(child: Image.asset('assets/images/quran pages/00$page.png', color: MyColors.quranText())),
      Center(child: Image.asset('assets/images/quran pages/000$page.png')),
    ];
    return Stack(children: images);
  }
}
