import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import 'package:zad_almumin/core/utils/resources/app_sizes.dart';
import 'package:zad_almumin/features/quran_questions/presentation/cubit/quran_questions_cubit.dart';

class QuranQuestionsQuestionCard extends StatelessWidget {
  const QuranQuestionsQuestionCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.cardPadding),
      alignment: Alignment.center,
      height: context.height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        color: context.themeColors.background,
        border: Border.all(color: Colors.black, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.6),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
          BoxShadow(
            color: context.themeColors.primary.withOpacity(.6),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: BlocBuilder<QuranQuestionsCubit, QuranQuestionsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Text(
              state.successQuestionAyah.text,
              textAlign: TextAlign.justify,
            ),
          );
        },
      ),
    );
  }
}
