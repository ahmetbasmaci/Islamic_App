import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';
import 'package:zad_almumin/features/quran/quran.dart';
import '../../../../../core/utils/enums/enums.dart';

class QuranSearchSuggestionResultOrder extends StatelessWidget {
  final String query;
  const QuranSearchSuggestionResultOrder({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: context
          .read<QuranSearchCubit>()
          .state
          .searchFilterList
          .map((filterChipModel) => _searchResultOrder(context, filterChipModel))
          .toList(),
    );
  }

  Widget _searchResultOrder(BuildContext context, FilterChipModel filterChipModel) {
    if (!filterChipModel.isSelected) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _suggestionTitle(context, filterChipModel),
        SizedBox(height: AppSizes.screenPadding),
        suggestionResutlBySearchFilterType(filterChipModel.searchFilter),
        const Divider(),
        SizedBox(height: AppSizes.screenPadding),
      ],
    );
  }

  Align _suggestionTitle(BuildContext context, FilterChipModel filterChipModel) {
    return Align(
      alignment: context.isArabicLang ? Alignment.topRight : Alignment.topLeft,
      child: Text(filterChipModel.text),
    );
  }

  Widget suggestionResutlBySearchFilterType(SearchFilter searchFilter) {
    switch (searchFilter) {
      case SearchFilter.surahs:
        return QuranSearchSurahsSuggestionResult(query: query);
      case SearchFilter.ayahs:
        return QuranSearchAyahsSuggestionResult(query: query);
      case SearchFilter.pages:
        return QuranSearchPagesSuggestionresult(query: query);
    }
  }
}
