import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import 'package:zad_almumin/core/utils/resources/app_sizes.dart';
import 'package:zad_almumin/core/utils/resources/app_styles.dart';

import '../../../../../core/utils/enums/enums.dart';
import '../../../quran_questions.dart';

class QuranQuestionsDropDownAnswers extends StatelessWidget {
  const QuranQuestionsDropDownAnswers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranQuestionsCubit, QuranQuestionsState>(
      builder: (context, state) {
        Offset distance = context.read<QuranQuestionsCubit>().state.isPressed ? const Offset(1, 1) : const Offset(2, 2);
        double blure = context.read<QuranQuestionsCubit>().state.isPressed ? 5 : 10;
        return Column(
          children: <Widget>[
            SizedBox(height: AppSizes.spaceBetweanWidgets),
            _selectOption(
              context: context,
              title: "اختر الجزء:",
              currectValue: context.read<QuranQuestionsCubit>().state.successQuestionAyah.juz,
              valueSelected: context.read<QuranQuestionsCubit>().state.selectedDropDownAnswerJuz,
              onChanged: (val) => context.read<QuranQuestionsCubit>().updateSelectedDropDownAnswerJuz(val!),
              items: _getSelectJuzOptions(context),
            ),
            SizedBox(height: AppSizes.spaceBetweanWidgets),
            _selectOption(
              context: context,
              title: "اختر الصفحة:",
              currectValue: context.read<QuranQuestionsCubit>().state.successQuestionAyah.page,
              valueSelected: context.read<QuranQuestionsCubit>().state.selectedDropDownAnswerPage,
              onChanged: (val) => context.read<QuranQuestionsCubit>().updateSelectedDropDownAnswerPage(val!),
              items: _getSelectPageOptions(context),
            ),
            SizedBox(height: AppSizes.spaceBetweanWidgets * 2),
            _confirmButton(context, distance, blure),
          ],
        );
      },
    );
  }

  Widget _confirmButton(BuildContext context, Offset distance, double blure) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      onTap: () => context.read<QuranQuestionsCubit>().dropDownAnswerPressed(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: context.width * .4,
        decoration: BoxDecoration(
          color: context.read<QuranQuestionsCubit>().state.ayahsAnswerStates == AyahsAnswerStates.none
              ? context.themeColors.background
              : context.read<QuranQuestionsCubit>().state.ayahsAnswerStates == AyahsAnswerStates.currect
                  ? context.themeColors.success
                  : context.themeColors.error,
          // borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          boxShadow: [
            BoxShadow(
              offset: -distance,
              color: context.themeColors.background,
              blurRadius: blure,
              // inset: context.read<QuranQuestionsCubit>().state.isPressed,
            ),
            BoxShadow(
              offset: distance,
              color: context.isDark ? const Color(0xff23262a) : const Color(0xffa7a9af),
              blurRadius: blure,
              spreadRadius: 1,
              // inset: context.read<QuranQuestionsCubit>().state.isPressed,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: const Text("تأكيد"),
      ),
    );
  }

  Widget _selectOption({
    required BuildContext context,
    required String title,
    required int currectValue,
    required int valueSelected,
    required Function(int?) onChanged,
    required List<DropdownMenuItem<int>> items,
  }) {
    if (!items.any((element) => element.value == valueSelected)) {
      valueSelected = items.first.value ?? 0;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(title),
        AnimatedOpacity(
          opacity: context.read<QuranQuestionsCubit>().state.ayahsAnswerStates == AyahsAnswerStates.wrong ? 1 : 0,
          duration: Duration(milliseconds: context.read<QuranQuestionsCubit>().state.isPressed ? 200 : 0),
          child: Text(
            currectValue.toString(),
            style: AppStyles.contentBold.copyWith(color: context.themeColors.success),
          ),
        ),
        DropdownButton<int>(
          value: valueSelected,
          onChanged: context.read<QuranQuestionsCubit>().state.isPressed ? null : onChanged,
          items: items,
        )
      ],
    );
  }

  List<DropdownMenuItem<int>> _getSelectPageOptions(BuildContext context) {
    List<DropdownMenuItem<int>> result = [];
    for (var index = 0;
        index <
            (context.read<QuranQuestionsCubit>().state.pageTo - context.read<QuranQuestionsCubit>().state.pageFrom) + 1;
        index++) {
      result.add(DropdownMenuItem(
        value: index + context.read<QuranQuestionsCubit>().state.pageFrom,
        child: Text('${index + context.read<QuranQuestionsCubit>().state.pageFrom}'),
      ));
    }
    // bool inRange = false;
    // for (var element in result) {
    //   if (element.value == context.read<QuranQuestionsCubit>().state.selectedDropDownAnswerPage) {
    //     inRange = true;
    //     break;
    //   }
    // }
    // if (!inRange)
    //   context.read<QuranQuestionsCubit>().state.answerPageDropDown = context.read<QuranQuestionsCubit>().state.pageFrom;
    return result;
  }

  List<DropdownMenuItem<int>> _getSelectJuzOptions(BuildContext context) {
    List<DropdownMenuItem<int>> result = [];
    for (var index = 0;
        index <
            (context.read<QuranQuestionsCubit>().state.juzTo - context.read<QuranQuestionsCubit>().state.juzFrom) + 1;
        index++) {
      result.add(DropdownMenuItem(
        value: index + context.read<QuranQuestionsCubit>().state.juzFrom,
        child: Text('${index + context.read<QuranQuestionsCubit>().state.juzFrom}'),
      ));
    }
    return result;
  }
}
