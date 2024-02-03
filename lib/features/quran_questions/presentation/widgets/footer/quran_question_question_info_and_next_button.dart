import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/resources/resources.dart';
import '../../../quran_questions.dart';

class QuranQuestionQuestionInfoAndNextButton extends StatelessWidget {
  const QuranQuestionQuestionInfoAndNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        ElevatedButton(
          onPressed: () => context.read<QuranQuestionsCubit>().getNextQuestion(),
          child: Row(
            children: [
              const Text('تحديث'),
              SizedBox(width: AppSizes.spaceBetweanWidgets),
              AppIcons.refresh,
            ],
          ),
        )

        //Text.normal(title: ' السؤال رقم ${ayahsQuestionsCtr.quastionNumber.value}', color: context.themeColors.whiteBlack)
      ],
    );
  }
}
