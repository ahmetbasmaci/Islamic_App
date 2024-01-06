import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';

import '../../../../../config/local/l10n.dart';
import '../../../../../core/utils/resources/resources.dart';
import '../../../quran.dart';

class QuranTextUpPart extends StatelessWidget {
  const QuranTextUpPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: context.width * 0.02),
        height: kToolbarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${AppStrings.of(context).juz}   ${context.read<QuranCubit>().state.selectedPageInfo.juz.arabicNumber}',
              style: AppStyles.contentBold,
            ),
            Text(
              context.read<QuranCubit>().state.selectedPageInfo.surahName,
              style: AppStyles.contentBold,
            ),
          ],
        ),
      ),
    );
  }
}
