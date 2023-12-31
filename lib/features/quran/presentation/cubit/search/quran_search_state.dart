part of 'quran_search_cubit.dart';

class QuranSearchState extends Equatable {
  final List<FilterChipModel> searchFilterList;
  const QuranSearchState({required this.searchFilterList});

  QuranSearchState.init()
      : searchFilterList = <FilterChipModel>[
          FilterChipModel(
              text: SearchFilter.surahs.translatedName, isSelected: false, searchFilter: SearchFilter.surahs),
          FilterChipModel(text: SearchFilter.ayahs.translatedName, isSelected: false, searchFilter: SearchFilter.ayahs),
          FilterChipModel(text: SearchFilter.pages.translatedName, isSelected: false, searchFilter: SearchFilter.pages),
        ];
  @override
  List<Object> get props => [
        searchFilterList,
      ];
}
