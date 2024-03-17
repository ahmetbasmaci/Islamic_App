import 'package:flutter/material.dart';
import 'package:zad_almumin/core/widget/dividers/dividers.dart';
import '../../../../quran.dart';

class QuranFooterResitationSettingsBody extends StatelessWidget {
  const QuranFooterResitationSettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuranFooterResitationSettingsSelectReader(),
        AppHorizontalDivider(),
        QuranFooterResitationSettingsSelectAyahsLimits(),
        // AppHorizontalDivider(),
        //QuranFooterResitationSettingsSelectRepeat(),
      ],
    );
  }
}
