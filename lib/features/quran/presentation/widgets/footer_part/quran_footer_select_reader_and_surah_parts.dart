import 'package:flutter/material.dart';
import '../../../quran.dart';

class QuranFooterSelectReaderAndSurahParts extends StatelessWidget {
  const QuranFooterSelectReaderAndSurahParts({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        QuranSelectReaderDropDown(),
        QuranSelectSurahDropDown(),
      ],
    );
  }
}
