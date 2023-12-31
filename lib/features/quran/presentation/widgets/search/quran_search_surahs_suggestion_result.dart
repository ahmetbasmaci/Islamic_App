import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/helpers/navigator_helper.dart';

import '../../../quran.dart';

class QuranSearchSurahsSuggestionResult extends StatelessWidget {
  final String query;
  const QuranSearchSurahsSuggestionResult({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    if (query == '') return Container();

    return surahsSuggestionResult(context);
  }

  Widget surahsSuggestionResult(BuildContext context) {
    List<Surah> surahsResult = context.read<QuranSearchCubit>().searchSurahs(query);
    return Container(
      constraints: BoxConstraints(maxHeight: context.height * .2),
      child: Scrollbar(
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: surahsResult.length,
          cacheExtent: 5,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 5 / 1.5,
          ),
          physics: surahsResult.isEmpty ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
          itemBuilder: ((context, index) {
            return _resultitem(context, surahsResult, index);
          }),
        ),
      ),
    );
  }

  ListTile _resultitem(BuildContext context, List<Surah> surahsResult, int index) {
    return ListTile(
      title: Text(
        '${surahsResult[index].name.replaceAll('سُورَةُ ', '')} : ${surahsResult[index].startAtPage}',
      ),
      onTap: () {
        NavigatorHelper.pop();
        context.read<QuranCubit>().goToPage(surahsResult[index].startAtPage - 1);
      },
    );
  }
}
