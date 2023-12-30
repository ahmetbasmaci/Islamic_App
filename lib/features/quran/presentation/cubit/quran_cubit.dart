import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../quran.dart';
part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  final IQuranDataRepository quranDataRepository;
  QuranCubit({required this.quranDataRepository}) : super(QuranState.initial());

  ScrollController scrollController = ScrollController();
  late TabController tabCtr;

  List<MarkedPage> markedList = [];

  final ItemScrollController _itemScrollController = ItemScrollController();
  ItemScrollController get itemScrollController => _itemScrollController;

  List<Ayah> getAyahsInCurrentPage() {
    List<Ayah> allAyahsInPage = [];
    var result = quranDataRepository.getAyahsInPage(state.selectedPageInfo.pageNumber);
    result.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (r) => allAyahsInPage = r,
    );
    return allAyahsInPage;
  }

  List<Ayah> getAyahsInPage(int page) {
    List<Ayah> allAyahsInPage = [];
    var result = quranDataRepository.getAyahsInPage(page);
    result.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (r) => allAyahsInPage = r,
    );
    return allAyahsInPage;
  }

  void setCurrentPage(TickerProvider quranTicker) {
    tabCtr = TabController(length: 604, vsync: quranTicker);

    if (state.showInKahf) {
      //check if user open quran page from kahf notification
      tabCtr.index = 294;
      updateCurrentPageCtr();
    } else {
      //check last opend page
      var result = quranDataRepository.getSavedCurrentPageIndex;
      result.fold(
        (l) => emit(state.copyWith(message: l.message)),
        (pageIndex) {
          tabCtr.index = pageIndex;
          updateCurrentPageCtr();
        },
      );
    }
  }

  void setTabCtrListener() {
    tabCtr.addListener(() => updateCurrentPageCtr());
  }

  void updateCurrentPageCtr() {
    //TODO GetStorage().write('pageIndex', tabCtr.index);
    quranDataRepository.saveCurrentPageIndex(tabCtr.index);
    var result = quranDataRepository.getAyahsInPage(tabCtr.index + 1);
    result.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (ayahsInPage) {
        if (ayahsInPage.isEmpty) return;
        Ayah ayah = ayahsInPage.first;
        SelectedPageInfo newSelectedPage = state.selectedPageInfo.copyWith(
          juz: ayah.juz,
          pageNumber: tabCtr.index + 1,
          surahNumber: ayah.surahNumber,
          surahName: ayah.surahName,
          startAyahNum: ayah.ayahNumber,
          endAyahNum: ayahsInPage.last.ayahNumber,
          totalAyahsNum: ayahsInPage.length,
        );
        emit(state.copyWith(selectedPageInfo: newSelectedPage));
      },
    );
  }

  void updateSelectedAyah(Ayah ayah) {
    emit(state.copyWith(selectedAyah: ayah));
  }

  void changeQuranImagesStyle() {
    emit(state.copyWith(showQuranImages: !state.showQuranImages));
  }

  void updateQuranFontSize(double fontSize) {
    emit(state.copyWith(quranFontSize: fontSize));
  }

  void pagePressed() {
    print('alskdjasd');
    bool isVisable = state.showTopFooterPart;
    emit(state.copyWith(showTopFooterPart: !isVisable));
  }

  void showMarkDialog() {
    //TODo
  }
  List<Surah> get alSurahs {
    List<Surah> surahs = [];
    var result = quranDataRepository.alSurahs;
    result.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (r) => surahs = r,
    );
    return surahs;
  }

  bool get isEmpty {
    bool isEmpty = false;
    var result = quranDataRepository.isEmpty;
    result.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (r) => isEmpty = r,
    );
    return isEmpty;
  }

  bool get isNotEmpty {
    bool isNotEmpty = false;
    var result = quranDataRepository.isNotEmpty;
    result.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (r) => isNotEmpty = r,
    );
    return isNotEmpty;
  }

  int get surahsCount {
    int surahsCount = 0;
    var result = quranDataRepository.surahsCount;
    result.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (r) => surahsCount = r,
    );
    return surahsCount;
  }

  Surah getSurahByPage(int page) {
    Surah surah = Surah.empty();
    var result = quranDataRepository.getSurahByPage(page);
    result.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (r) => surah = r,
    );
    return surah;
  }

  Surah getSurahByName(String surahName) {
    Surah surah = Surah.empty();
    var result = quranDataRepository.getSurahByName(surahName);
    result.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (r) => surah = r,
    );
    return surah;
  }

  Surah getSurahByNumber(int surahNumber) {
    Surah surah = Surah.empty();
    var result = quranDataRepository.getSurahByNumber(surahNumber);
    result.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (r) => surah = r,
    );
    return surah;
  }

  List<Surah> getMatchedSurah(String surahName) {
    List<Surah> surahs = [];
    var result = quranDataRepository.getMatchedSurah(surahName);
    result.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (r) => surahs = r,
    );
    return surahs;
  }

  Ayah getAyah(int surahNumber, int ayahNumber) {
    Ayah ayah = Ayah.empty();
    var result = quranDataRepository.getAyah(surahNumber, ayahNumber);
    result.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (r) => ayah = r,
    );
    return ayah;
  }

  Ayah getRandomAyah() {
    Ayah ayah = Ayah.empty();
    var result = quranDataRepository.getRandomAyah();
    result.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (r) => ayah = r,
    );
    return ayah;
  }

  Ayah getRandomAyahBySureNumber(int sureNumber) {
    Ayah ayah = Ayah.empty();
    var result = quranDataRepository.getRandomAyahBySureNumber(sureNumber);
    result.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (r) => ayah = r,
    );
    return ayah;
  }

  int getJuzNumberByPage(int page) {
    int juzNumberByPage = 0;
    var result = quranDataRepository.getJuzNumberByPage(page);
    result.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (r) => juzNumberByPage = r,
    );
    return juzNumberByPage;
  }

  int getPageInJuz(int page) {
    int pageInJuz = 0;
    var result = quranDataRepository.getPageInJuz(page);
    result.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (r) => pageInJuz = r,
    );
    return pageInJuz;
  }

  //
}
