import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import '../../../../../core/utils/resources/resources.dart';
import '../../../quran_questions.dart';

class QuranQuestionAnswersInfo extends StatelessWidget {
  const QuranQuestionAnswersInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        correctAndWrongAnswersLabels2(context: context, isCorrect: true),
        correctAndWrongAnswersLabels2(context: context, isCorrect: false),
      ],
    );
  }

  Widget correctAndWrongAnswersLabels2({required BuildContext context, required bool isCorrect}) {
    return SizedBox(
      width: context.width * .45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isCorrect ? 'الاجابات الصحيحة:' : 'الاجابات الخاطئة:',
            style: AppStyles.contentBold.copyWith(
              color: isCorrect ? context.themeColors.success : context.themeColors.error,
            ),
          ),
          BlocBuilder<QuranQuestionsCubit, QuranQuestionsState>(
            builder: (context, state) {
              return Text(
                isCorrect
                    ? '${context.read<QuranQuestionsCubit>().state.trueAnswersCounter}'
                    : '${context.read<QuranQuestionsCubit>().state.wrongAnwersCounter}',
                style: AppStyles.contentBold.copyWith(
                  color: isCorrect ? context.themeColors.success : context.themeColors.error,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
