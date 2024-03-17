import 'package:flutter/material.dart';
import '../../../../quran.dart';

class QuranFooterResitationSettingsBody extends StatelessWidget {
  const QuranFooterResitationSettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuranFooterResitationSettingsSelectReader(),
        Divider(),
        QuranFooterResitationSettingsSelectAyahsLimits(),
        Divider(),
        // QuranFooterResitationSettingsSelectRepeat(),
        // Divider(),
      ],
    );
  }
}
