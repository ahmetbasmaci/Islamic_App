import 'package:flutter/material.dart';
import 'package:zad_almumin/core/utils/resources/app_sizes.dart';
import '../../../quran_questions.dart';

class QuestionsFooter extends StatelessWidget {
  const QuestionsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const QuranQuestionQuestionInfoAndNextButton(),
        const Divider(thickness: 1, endIndent: 50, indent: 50),
        SizedBox(height: AppSizes.spaceBetweanWidgets),
        const QuranQuestionAnswersInfo(),
        SizedBox(height: AppSizes.spaceBetweanWidgets),
      ],
    );
  }
}
