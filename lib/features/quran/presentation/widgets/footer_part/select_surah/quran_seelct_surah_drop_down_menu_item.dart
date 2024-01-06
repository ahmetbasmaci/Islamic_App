import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';

import '../../../../../../core/utils/resources/resources.dart';
import '../../../../quran.dart';

class QuranSeelctSurahDropDownMenuItem extends StatelessWidget {
  final Surah surah;
  const QuranSeelctSurahDropDownMenuItem({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return Text(
      surah.name.toString().removeTashkilAndSpace,
      style: context.read<QuranCubit>().state.selectedPageInfo.surahName == surah.name
          ? AppStyles.contentBold
          : AppStyles.content,
    );
  }
}
