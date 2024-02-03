import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';

import '../../../quran_questions.dart';

class QuranQuestionsSelectToOption extends StatelessWidget {
  const QuranQuestionsSelectToOption({super.key, required this.isPage});
  final bool isPage;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(isPage ? 'الى الصفحة    ' : 'الى الجزء    '),
        DropdownButton<int>(
          value: isPage
              ? context.read<QuranQuestionsCubit>().state.pageTo
              : context.read<QuranQuestionsCubit>().state.juzTo,
          iconEnabledColor: context.themeColors.primary,
          onChanged: (val) {
            if (isPage) {
              context.read<QuranQuestionsCubit>().changePageTo(val!);
              if (context.read<QuranQuestionsCubit>().state.selectedDropDownAnswerPage >
                  context.read<QuranQuestionsCubit>().state.pageTo) {
                // context.read<QuranQuestionsCubit>().state.selectedDropDownAnswerPage =
                //     context.read<QuranQuestionsCubit>().state.pageTo;
              }
            } else {
              context.read<QuranQuestionsCubit>().changeJuzTo(val!);
              if (context.read<QuranQuestionsCubit>().state.selectedDropDownAnswerJuz >
                  context.read<QuranQuestionsCubit>().state.juzTo) {
                //  context.read<QuranQuestionsCubit>().state.selectedDropDownAnswerJuz =
                //     context.read<QuranQuestionsCubit>().state.juzTo;
              }
            }
          },
          items: List.generate(
            isPage
                ? 21 - context.read<QuranQuestionsCubit>().state.pageFrom
                : 31 - context.read<QuranQuestionsCubit>().state.juzFrom,
            (index) => DropdownMenuItem(
              value: isPage
                  ? context.read<QuranQuestionsCubit>().state.pageFrom + index
                  : context.read<QuranQuestionsCubit>().state.juzFrom + index,
              child: Text(isPage
                  ? '${context.read<QuranQuestionsCubit>().state.pageFrom + index}'
                  : '${context.read<QuranQuestionsCubit>().state.juzFrom + index}'),
            ),
          ),
        ),
      ],
    );
  }
}
