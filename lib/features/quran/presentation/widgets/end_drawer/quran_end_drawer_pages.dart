import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';

import '../../../quran.dart';

class QuranEndDrawerPages extends StatelessWidget {
  const QuranEndDrawerPages({super.key});

  @override
  Widget build(BuildContext context) {
    List<Ayah> markedAyahs = context.read<QuranCubit>().state.markedAyahs;
    List<MarkedPage> markedPages = context.read<QuranCubit>().state.markedPages;
    return Expanded(
      child: PageView(
        controller: context.read<QuranEndDrawerCubit>().pageController,
        children: [
          _markedPagesItem(markedPages),
          _markedAyahsItem(markedAyahs),
        ],
      ),
    );
  }

  QuranEndDrawerPageBodyItem _markedAyahsItem(List<Ayah> markedAyahs) {
    return QuranEndDrawerPageBodyItem(
      itemsCount: markedAyahs.length,
      itemChild: (int index) => QuranEndDrawerMarkedItemListTile(
        title: markedAyahs[index].text,
        subtitle:
            '${markedAyahs[index].surahName.removeTashkil}  |  ${'الصفحة'} ${markedAyahs[index].page} | ${'الجزء'} ${markedAyahs[index].juz}',
        page: markedAyahs[index].page,
      ),
    );
  }

  QuranEndDrawerPageBodyItem _markedPagesItem(List<MarkedPage> markedPages) {
    return QuranEndDrawerPageBodyItem(
      itemsCount: markedPages.length,
      itemChild: (int index) => QuranEndDrawerMarkedItemListTile(
        title: '${'الجزء'} ${markedPages[index].juz}',
        subtitle: '${markedPages[index].surahName.removeTashkil}  |  ${'الصفحة'} ${markedPages[index].pageNumber}',
        page: markedPages[index].pageNumber,
      ),
    );
  }
}
