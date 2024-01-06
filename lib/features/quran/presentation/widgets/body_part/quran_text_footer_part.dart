import 'package:flutter/material.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';

class QuranTextFooterPart extends StatelessWidget {
  final int page;
  const QuranTextFooterPart({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: context.height * 0.03,
        child: Center(
          child: Text(
            page.arabicNumber,
            // size: 16,
            // fontWeight: FontWeight.bold,
            // color: MyColors.quranPrimary,
          ),
        ),
      ),
    );
  }
}
