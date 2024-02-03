import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';

import '../../../../../core/utils/enums/enums.dart';
import '../../../quran_questions.dart';

class QuranQuestionsSelectDifferentTestType extends StatelessWidget {
  const QuranQuestionsSelectDifferentTestType({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text('نوع الاختبار:'),
        DropdownButton<QuestionType>(
          value: context.read<QuranQuestionsCubit>().state.questionType,
          iconEnabledColor: context.themeColors.primary,
          onChanged: (QuestionType? val) {
            if (context.read<QuranQuestionsCubit>().state.questionType != val) {
              context.read<QuranQuestionsCubit>().changeQuestionType(val!);
              {
                // getNextQuestion(context);
              }
            }
          },
          items: [
            const DropdownMenuItem(value: QuestionType.ayahInJuzAndPage, child: Text('الايات')),
            const DropdownMenuItem(value: QuestionType.surahInJuz, child: Text('السور')),
          ],
        ),
      ],
    );
  }
}
