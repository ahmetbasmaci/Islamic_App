import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import '../../../quran_questions.dart';

class QuranQuestionsButtonAnswers extends StatelessWidget {
  const QuranQuestionsButtonAnswers({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.2,
      child: BlocBuilder<QuranQuestionsCubit, QuranQuestionsState>(
        builder: (context, state) {
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3.5,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return QuranQuestionsButtonAnswerItem(
                quranQuestionButtonModel: context.read<QuranQuestionsCubit>().quranQuestionButtonModels[index],
              );
            },
          );
        },
      ),
    );
  }
}
