import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';
import '../../../../../core/utils/enums/enums.dart';
import '../../../quran_questions.dart';

//TODO add animation package
// import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
// import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class QuranQuestionsButtonAnswerItem extends StatelessWidget {
  final QuranQuestionBottonModel quranQuestionButtonModel;
  const QuranQuestionsButtonAnswerItem({super.key, required this.quranQuestionButtonModel});

  @override
  Widget build(BuildContext context) {
    Offset distance = context.read<QuranQuestionsCubit>().state.isPressed ? const Offset(1, 1) : const Offset(2, 2);
    double blure = context.read<QuranQuestionsCubit>().state.isPressed ? 5 : 10;
    return InkWell(
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          onTap: () => context.read<QuranQuestionsCubit>().buttonAnswerPressed(quranQuestionButtonModel),
          child: AnimatedContainer(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.center,
            decoration: AppDecorations.quranQuestionDecoration(
              backgroundColor: quranQuestionButtonModel.backgroundColor,
              distance: distance,
              blure: blure,
            ),
            child: _buttonText(context),
          ),
        );
  }

  Text _buttonText(BuildContext context) {
    return Text(
      context.read<QuranQuestionsCubit>().state.questionType == QuestionType.ayahInJuzAndPage
          ? '${'الجزء'} : ${quranQuestionButtonModel.juz}\n${'الصفحة'} : ${quranQuestionButtonModel.page}'
          : '${'الجزء'} : ${quranQuestionButtonModel.juz}',
      style: AppStyles.content.copyWith(color: quranQuestionButtonModel.textColor),
    );
  }
}
