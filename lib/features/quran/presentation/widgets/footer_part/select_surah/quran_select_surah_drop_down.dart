import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';

import '../../../../quran.dart';

class QuranSelectSurahDropDown extends StatelessWidget {
  const QuranSelectSurahDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        return DropdownButton<String>(
          items: context
              .read<QuranCubit>()
              .allSurahs
              .map(
                (item) => DropdownMenuItem(
                  value: item.name,
                  child: QuranSeelctSurahDropDownMenuItem(surah: item),
                ),
              )
              .toList(),
          value: context.read<QuranCubit>().state.selectedPageInfo.surahName.isEmpty
              ? context.read<QuranCubit>().allSurahs[0].name
              : context.read<QuranCubit>().state.selectedPageInfo.surahName,
          menuMaxHeight: context.height * .3,
          onChanged: (newVal) {
            context.read<QuranCubit>().updateCurrentPageInfoBySurahName(newVal!);
          },
        );
      },
    );
  }
}
