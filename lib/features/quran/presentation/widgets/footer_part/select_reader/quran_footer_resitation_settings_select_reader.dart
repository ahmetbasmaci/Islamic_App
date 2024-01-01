import 'package:flutter/material.dart';

import '../../../../quran.dart';

class QuranFooterResitationSettingsSelectReader extends StatelessWidget {
  const QuranFooterResitationSettingsSelectReader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('القارئ:'),
        QuranSelectReaderDropDown(),
      ],
    );
  }
}
