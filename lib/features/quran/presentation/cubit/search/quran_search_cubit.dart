import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/features/quran/quran.dart';
import '../../../../../core/utils/enums/enums.dart';
part 'quran_search_state.dart';

class QuranSearchCubit extends Cubit<QuranSearchState> {
  final IQuranDataRepository quranDataRepository;
  QuranSearchCubit({required this.quranDataRepository}) : super(QuranSearchState.init()) {
    readSavedData();
  }

  // final StreamController<List<Ayah>> _streamController = StreamController<List<Ayah>>.broadcast();
  // Stream<List<Ayah>> get ayahsStream => _streamController.stream;

  void readSavedData() {
    var result = quranDataRepository.getSavedSearchFilterList;
    result.fold(
      (l) => null,
      (dataList) {
        if (dataList.isEmpty) return;

        state.searchFilterList.clear();
        dataList.map((e) => state.searchFilterList.add(FilterChipModel.fromJson(e))).toList();
      },
    );
  }

  void saveSearchFilterList() {
    quranDataRepository.savedSearchFilterList(state.searchFilterList);
  }

  void updateSearchFilterList(int index, FilterChipModel oldFilterChip, FilterChipModel newFilterChip) {
    if (oldFilterChip == newFilterChip) return;

    //swap between old and new filter chips

    int oldChipIndex = -1;
    int newChipIndex = -1;
    for (var i = 0; i < state.searchFilterList.length; i++) {
      if (state.searchFilterList[i] == newFilterChip) {
        newChipIndex = i;
      } else if (state.searchFilterList[i] == oldFilterChip) {
        oldChipIndex = i;
      }
    }
    List<FilterChipModel> tempList = [];
    tempList.addAll(state.searchFilterList);
    tempList[oldChipIndex] = newFilterChip;
    tempList[newChipIndex] = oldFilterChip;

    emit(QuranSearchState(searchFilterList: tempList));
    saveSearchFilterList();
  }

  void updateSearchFilterChip(FilterChipModel filterChipModel, bool value) {
    List<FilterChipModel> tempList = [];
    state.searchFilterList.map((e) {
      tempList.add(FilterChipModel(
        text: e.text,
        isSelected: e == filterChipModel ? value : e.isSelected,
        searchFilter: e.searchFilter,
      ));
    }).toList();

    emit(QuranSearchState(searchFilterList: tempList));
    saveSearchFilterList();
  }

  List<int> searchPages(String query) {
    List<int> pages = [];

    int? num = int.tryParse(query);
    if (num == null) return pages;

    var result = quranDataRepository.searchPages(num);

    result.fold(
      (l) => null,
      (dataList) {
        if (dataList.isEmpty) return;

        pages.addAll(dataList);
      },
    );

    return pages;
  }

  List<Surah> searchSurahs(String query) {
    List<Surah> matchedSurahs = [];
    var result = quranDataRepository.searchSurahs(query);

    result.fold(
      (l) => null,
      (dataList) {
        if (dataList.isNotEmpty) matchedSurahs = dataList;
      },
    );
    return matchedSurahs;
  }

  List<Ayah> searchAyahs(String query) {
    List<Ayah> matchedAyahs = [];
    var result = quranDataRepository.searchAyahs(query);

    result.fold(
      (l) => null,
      (dataList) {
        if (dataList.isNotEmpty) matchedAyahs = dataList;
      },
    );
    return matchedAyahs;
  }
}
