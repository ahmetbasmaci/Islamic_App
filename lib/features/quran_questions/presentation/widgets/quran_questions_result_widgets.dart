import 'package:flutter/material.dart';
import 'package:zad_almumin/core/utils/resources/app_sizes.dart';
import 'package:zad_almumin/core/widget/space/space.dart';

import '../../quran_questions.dart';

class QuranQuestionsResultWidgets extends StatelessWidget {
  const QuranQuestionsResultWidgets({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const QuranQuestionsQuestionCard(),
        VerticalSpace(AppSizes.spaceBetweanParts),
        const QuestionAnswerOptions(),
        const Spacer(),
        const QuestionsFooter(),
      ],
    );
  }
}
