import 'package:flutter/material.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import '../../../quran.dart';

class QuranPageBodyTexts extends StatelessWidget {
  QuranPageBodyTexts({super.key, this.page = 0});
  final int page;
  late QuranCubit quranCubit;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: context.width * 0.04,
        right: context.width * 0.04,
        bottom: context.height * 0.01,
      ),
      constraints: BoxConstraints(minHeight: context.height),
      child: Column(
        children: [
          const QuranTextUpPart(),
          QuranTextBodyPart(page: page),
          QuranTextFooterPart(page: page),
        ],
      ),
    );
  }
}
