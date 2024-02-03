import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../quran_questions.dart';

class QuestionAnswerOptions extends StatelessWidget {
  const QuestionAnswerOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: AppSizes.spaceBetweanParts),
        BlocBuilder<QuranQuestionsCubit, QuranQuestionsState>(
          builder: (context, state) {
            return context.read<QuranQuestionsCubit>().state.answersType == AyahsAnswersType.dropDownMenu
                ? const QuranQuestionsDropDownAnswers()
                : const QuranQuestionsButtonAnswers();
          },
        ),
        SizedBox(height: AppSizes.spaceBetweanParts),
      ],
    );
  }
}
