import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';
import '../../../../../core/utils/enums/enums.dart';
import '../../../quran_questions.dart';

class QuranQuestionsSettingsBottomSheetWidget extends StatelessWidget {
  const QuranQuestionsSettingsBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _backgroundContainer(
      context: context,
      child: _body(context),
    );
  }

  Widget _backgroundContainer({required BuildContext context, required Widget child}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(AppSizes.screenPadding),
      decoration: BoxDecoration(
        color: context.themeColors.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.cardRadius),
          topRight: Radius.circular(AppSizes.cardRadius),
        ),
      ),
      child: child,
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<QuranQuestionsCubit, QuranQuestionsState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const QuranQuestionSelectQuestionTypeWidget(),
            const QuranQuestionsSelectDifferentTestType(),
            selectSpecificJuz(context),
            selectSpecificPage(context),
          ],
        );
      },
    );
  }

  Widget selectSpecificJuz(BuildContext context) {
    if (context.read<QuranQuestionsCubit>().state.questionType == QuestionType.ayahInJuzAndPage) return Container();

    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        QuranQuestionsSelectFromOption(isPage: false),
        QuranQuestionsSelectToOption(isPage: false),
      ],
    );
  }

  Widget selectSpecificPage(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        QuranQuestionsSelectFromOption(isPage: true),
        QuranQuestionsSelectToOption(isPage: true),
      ],
    );
  }
}
