import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import 'package:zad_almumin/core/extentions/enum_extentions.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';
import '../../../../../core/utils/enums/enums.dart';
import '../../../quran_questions.dart';

class QuranQuestionSelectQuestionTypeWidget extends StatelessWidget {
  const QuranQuestionSelectQuestionTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _title(),
        BlocBuilder<QuranQuestionsCubit, QuranQuestionsState>(
          builder: (context, state) {
            return _ansertTypeDropDown(context);
          },
        )
      ],
    );
  }

  Text _title() => Text('اختر طريقة الاجابة:', style: AppStyles.contentBold);

  DropdownButton<AyahsAnswersType> _ansertTypeDropDown(BuildContext context) {
    return DropdownButton<AyahsAnswersType>(
      value: context.read<QuranQuestionsCubit>().state.answersType,
      onChanged: (val) => context.read<QuranQuestionsCubit>().changeAnswerType(val!),
      iconEnabledColor: context.themeColors.primary,
      items: List.generate(
        AyahsAnswersType.values.length,
        (index) => DropdownMenuItem(
          value: AyahsAnswersType.values.elementAt(index),
          child: Text(AyahsAnswersType.values.elementAt(index).translatedName),
        ),
      ),
    );
  }
}
