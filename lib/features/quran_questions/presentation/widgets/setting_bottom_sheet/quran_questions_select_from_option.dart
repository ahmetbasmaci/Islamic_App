import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';

import '../../../quran_questions.dart';

class QuranQuestionsSelectFromOption extends StatelessWidget {
  const QuranQuestionsSelectFromOption({super.key, required this.isPage});
  final bool isPage;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(isPage ? 'من الصفحة    ' : 'من الجزء    '),
        DropdownButton<int>(
          items: List.generate(
            isPage ? 20 : 30,
            (index) => DropdownMenuItem(value: index + 1, child: Text('${index + 1}')),
          ),
          value: isPage
              ? context.read<QuranQuestionsCubit>().state.pageFrom
              : context.read<QuranQuestionsCubit>().state.juzFrom,
          iconEnabledColor: context.themeColors.primary,
          onChanged: (val) {
            if (isPage) {
              context.read<QuranQuestionsCubit>().changePageFrom(val!);
              if (context.read<QuranQuestionsCubit>().state.selectedDropDownAnswerPage <
                  context.read<QuranQuestionsCubit>().state.pageFrom) {
                //  context.read<QuranQuestionsCubit>().state.answerPageDropDown =
                //     context.read<QuranQuestionsCubit>().state.pageFrom;
              }
            } else {
              context.read<QuranQuestionsCubit>().changeJuzFrom(val!);
              if (context.read<QuranQuestionsCubit>().state.selectedDropDownAnswerJuz <
                  context.read<QuranQuestionsCubit>().state.juzFrom) {
                //  context.read<QuranQuestionsCubit>().state.answerJuzDropDown =
                //     context.read<QuranQuestionsCubit>().state.juzFrom;
              }
            }
          },
        ),
      ],
    );
  }
}
