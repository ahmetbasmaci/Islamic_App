import 'package:flutter/material.dart';

import '../../../../core/utils/resources/resources.dart';
import '../../quran_questions.dart';

class QuranQuestionOptionsButton extends StatelessWidget {
  const QuranQuestionOptionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
          icon: AppIcons.optinosVertical,
          onPressed: () => getBottomSheet(context),
        );
  }

  void getBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const QuranQuestionsSettingsBottomSheetWidget(),
    );
  }
}
