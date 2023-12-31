import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';

import '../../../../../core/helpers/navigator_helper.dart';
import '../../../quran.dart';

class QuranSearchPagesSuggestionresult extends StatelessWidget {
  final String query;
  const QuranSearchPagesSuggestionresult({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    if (query == '') return Container();
    return pagesSuggestionresult(context);
  }

  Widget pagesSuggestionresult(BuildContext context) {
    List<int> pagesResult = context.read<QuranSearchCubit>().searchPages(query);
    return Container(
      constraints: BoxConstraints(maxHeight: context.height * .2),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 5 / 1.5,
        ),
        shrinkWrap: true,
        physics: pagesResult.isEmpty ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
        itemCount: pagesResult.length,
        itemBuilder: ((context, index) {
          return _resuItItem(context, pagesResult, index);
        }),
      ),
    );
  }

  ListTile _resuItItem(BuildContext context, List<int> pagesResult, int index) {
    return ListTile(
      title: Text(pagesResult[index].toString()),
      onTap: () {
        NavigatorHelper.pop();
        context.read<QuranCubit>().goToPage(pagesResult[index] - 1);
      },
    );
  }
}
