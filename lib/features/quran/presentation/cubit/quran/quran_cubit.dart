import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:zad_almumin/core/helpers/dialogs_helper.dart';
import 'package:zad_almumin/core/helpers/navigator_helper.dart';
import 'package:zad_almumin/core/helpers/toats_helper.dart';
import 'package:zad_almumin/core/utils/app_router.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';
import 'package:zad_almumin/features/quran/quran.dart';

import '../../../../tafseer/tafseer.dart';
part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  final IQuranDataRepository quranDataRepository;
  final ITafseerRepository tafseerManagerRepository;
  QuranCubit({
    required this.quranDataRepository,
    required this.tafseerManagerRepository,
  }) : super(QuranState.initial());

  ScrollController scrollController = ScrollController();
  late TabController tabCtr;

  final ItemScrollController _itemScrollController = ItemScrollController();
  ItemScrollController get itemScrollController => _itemScrollController;

  void initPage(TickerProvider quranTicker, bool showInKahf) {
    _initTabController(quranTicker);
    _setTabCtrListener();

    _goToSavedPage(showInKahf);

    _hideTopFooterPartsVisabilety();

    bool quranViewModeInImages = _getSavedQuranViewMode;

    double quranFontSize = _getSavedQuranFontSize;

    bool showTafseerPage = _getSavedQuranTafsserMode;

    List<MarkedPage> markedPages = _getSavedSavedMarkedPages;

    List<Ayah> markedAyah = _getSavedSavedMarkedAyahs;

    emit(state.copyWith(
      quranViewModeInImages: quranViewModeInImages,
      quranFontSize: quranFontSize,
      showTafseerPage: showTafseerPage,
      markedPages: markedPages,
      markedAyahs: markedAyah,
    ));
  }

  void goToPage(int page) {
    tabCtr.index = page;
  }

  void updateCurrentPageInfoBySurahName(String surahName) {
    Surah surah = getSurahByName(surahName);
    updateCurrentPageInfoBySurah(surah);
  }

  void updateCurrentPageInfoBySurahNumber(int surahNumber) {
    Surah surah = getSurahByNumber(surahNumber);
    updateCurrentPageInfoBySurah(surah);
  }

  void updateCurrentPageInfoBySurah(Surah surah) {
    SelectedPageInfo newSelectedPage = SelectedPageInfo(
      juz: surah.ayahs.first.juz,
      pageNumber: surah.ayahs.first.page - 1,
      surahNumber: surah.number,
      surahName: surah.name,
    );
    goToPage(newSelectedPage.pageNumber);
    emit(state.copyWith(selectedPageInfo: newSelectedPage));
  }

  void updateSelectedAyah(Ayah ayah) {
    emit(state.copyWith(selectedAyah: ayah));
    if (isAudioPlaying) {
      if (state.selectedPageInfo.pageNumber != ayah.page || state.selectedPageInfo.surahName != ayah.surahName) {
        goToPage(ayah.page - 1);
      }
    }
  }

  void updateSelectedAyahByNumber(int ayahNumber) {
    Ayah ayah = Ayah.empty();

    //first ayah in fatiha (basmalah)
    if (state.selectedPageInfo.surahNumber == 1) {
      ayah = getAyah(state.selectedPageInfo.surahNumber, ayahNumber + 1);
    } else {
      ayah = getAyah(state.selectedPageInfo.surahNumber, ayahNumber);
    }
    updateSelectedAyah(ayah);
  }

  void changeQuranViewMode() async {
    await quranDataRepository.saveQuranViewMode(!state.quranViewModeInImages);
    emit(state.copyWith(
      quranViewModeInImages: !state.quranViewModeInImages,
    ));
  }

  void updateQuranFontSize(double fontSize) async {
    await quranDataRepository.saveQuranFontSize(fontSize);
    emit(state.copyWith(quranFontSize: fontSize));
  }

  void showAddQuranPageMarkDialog() async {
    var markedList = state.markedPages;

    MarkedPage pageProp = markedList.firstWhere(
      (element) => element.pageNumber == state.selectedPageInfo.pageNumber,
      orElse: () => MarkedPage(
        pageNumber: state.selectedPageInfo.pageNumber,
        juz: state.selectedPageInfo.juz,
        surahName: state.selectedPageInfo.surahName,
        isMarked: false,
      ),
    );
    bool resultOk = await DialogsHelper.showAddQuranPageMarkDialog(pageProp);
    if (resultOk) {
      if (pageProp.isMarked) {
        markedList.removeWhere((element) => element.pageNumber == pageProp.pageNumber);
        ToatsHelper.show('تم ازالة العلامة');
      } else {
        pageProp.isMarked = true;
        markedList.add(pageProp);
        ToatsHelper.show('تم اضافة العلامة');
      }
    }
    var savingResult = await quranDataRepository.savedMarkedPages(markedList);

    savingResult.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (r) => emit(state.copyWith(markedPages: markedList)),
    );
  }

  void addBookMarkToAyah(Ayah ayah) async {
    var markedList = state.markedAyahs;

    ayah.isMarked = !ayah.isMarked;
    if (markedList.contains(ayah)) {
      markedList.remove(ayah);
      ToatsHelper.show('تم ازالة العلامة');
    } else {
      markedList.add(ayah);
      ToatsHelper.show('تم اضافة العلامة');
    }
    var savingResult = await quranDataRepository.savedMarkedAyahs(markedList);

    savingResult.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (r) => emit(state.copyWith(markedAyahs: markedList)),
    );
  }

  void updateResitationSettingsStartAyah(Ayah newStartAyah) {
    emit(
      state.copyWith(
        resitationSettings: state.resitationSettings.copyWith(
          startAyah: newStartAyah,
          endAyah: newStartAyah.number > state.resitationSettings.endAyah.number
              ? getSurahByNumber(newStartAyah.surahNumber).ayahs.last
              : null,
        ),
      ),
    );
  }

  void updateResitationSettingsEndAyah(Ayah ayah) {
    emit(state.copyWith(
      resitationSettings: state.resitationSettings.copyWith(endAyah: ayah),
    ));
  }

  void updateResitationSettingsUnlimitedRepeatAyah(bool newValue) {
    emit(state.copyWith(
      resitationSettings: state.resitationSettings.copyWith(isUnlimitRepeatAyah: newValue),
    ));
  }

  void updateResitationSettingsUnlimitedRepeatAll(bool newValue) {
    emit(state.copyWith(
      resitationSettings: state.resitationSettings.copyWith(isUnlimitRepeatAll: newValue),
    ));
  }

  void updateResitationSettingsInecreaseRepeatAllCount() {
    emit(state.copyWith(
      resitationSettings:
          state.resitationSettings.copyWith(repeetAllCount: state.resitationSettings.repeetAllCount + 1),
    ));
  }

  void updateResitationSettingsInecreaseRepeatAyahCount() {
    emit(state.copyWith(
      resitationSettings:
          state.resitationSettings.copyWith(repeetAyahCount: state.resitationSettings.repeetAyahCount + 1),
    ));
  }

  void updateResitationSettingsDecreaseRepeatAllCount() {
    if (state.resitationSettings.repeetAllCount == 1) return;
    emit(state.copyWith(
      resitationSettings:
          state.resitationSettings.copyWith(repeetAllCount: state.resitationSettings.repeetAllCount - 1),
    ));
  }

  void updateResitationSettingsDecreaseRepeatAyahCount() {
    if (state.resitationSettings.repeetAyahCount == 1) return;
    emit(state.copyWith(
      resitationSettings:
          state.resitationSettings.copyWith(repeetAyahCount: state.resitationSettings.repeetAyahCount - 1),
    ));
  }

  void endDrawerSavedItemPressed(int page) {
    goToPage(page);

    NavigatorHelper.pop();
  }

  void _initTabController(TickerProvider quranTicker) {
    tabCtr = TabController(length: 604, vsync: quranTicker);
  }

  void _goToSavedPage(bool showInKahf) {
    if (showInKahf) {
      //check if user open quran page from kahf notification
      goToPage(294);
      _updateCurrentPageInfo();
    } else {
      //check last opend page
      var result = quranDataRepository.getSavedCurrentPageIndex;
      result.fold(
        (l) => emit(state.copyWith(message: l.message)),
        (pageIndex) {
          goToPage(pageIndex);
          _updateCurrentPageInfo();
        },
      );
    }
  }

  void _setTabCtrListener() {
    tabCtr.addListener(() => _updateCurrentPageInfo());
  }

  void _updateCurrentPageInfo() async {
    await quranDataRepository.saveCurrentPageIndex(tabCtr.index);
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
        );

        emit(state.copyWith(selectedPageInfo: newSelectedPage));
        _updateSelectStartEndAyahs();
      },
    );
  }

  void _updateSelectStartEndAyahs() {
    if (state.selectedPageInfo.surahNumber != state.resitationSettings.startAyah.surahNumber) {
      List<Ayah> ayahs = getSurahByNumber(state.selectedPageInfo.surahNumber).ayahs;

      emit(
        state.copyWith(
          resitationSettings: state.resitationSettings.copyWith(
            startAyah: ayahs[1],
            endAyah: ayahs.last,
          ),
        ),
      );
    } else if (state.resitationSettings.startAyah.number == 0) {}
  }

  void _hideTopFooterPartsVisabilety() {
    if (!state.showTopFooterPart) return;
    emit(state.copyWith(showTopFooterPart: false));
  }

  void _showTopFooterPartsVisabilety() {
    if (state.showTopFooterPart) return;
    emit(state.copyWith(showTopFooterPart: true));
  }

  void _triggerTopFooterPartsVisabilety() {
    if (state.showTopFooterPart)
      _hideTopFooterPartsVisabilety();
    else
      _showTopFooterPartsVisabilety();
  }

  void hideSelectedAyah() {
    emit(state.copyWith(selectedAyah: Ayah.empty()));
  }

  void pagePressed() {
    _triggerTopFooterPartsVisabilety();

    if (isAudioPlaying) return;

    hideSelectedAyah();
  }

  bool get isAudioPlaying {
    var result = quranDataRepository.isAudioPlaying;
    bool isPlaying = false;
    result.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (value) {
        isPlaying = value;
      },
    );
    return isPlaying;
  }

  void changeShowTafseerPage() async {
    var result = await tafseerManagerRepository.getTafsers;
    result.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (tafseers) {
        if (tafseers.isEmpty) {
          ToatsHelper.show('لا يوجد تفاسير محملة');
          NavigatorHelper.pushNamed(AppRoutes.tafseer);
          return;
        }
        emit(state.copyWith(showTafseerPage: !state.showTafseerPage));
      },
    );
  }

  bool get _getSavedQuranViewMode {
    bool quranViewModeInImages = true;
    var result = quranDataRepository.getSavedQuranViewMode;
    result.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (savedMode) => quranViewModeInImages = savedMode,
    );
    return quranViewModeInImages;
  }

  double get _getSavedQuranFontSize {
    double quranFontSize = AppSizes.minQuranFontSize;
    var result = quranDataRepository.getSavedQuranFontSize;
    result.fold(
      (l) => null,
      (savedSize) => quranFontSize = savedSize,
    );
    return quranFontSize;
  }

  bool get _getSavedQuranTafsserMode {
    bool showTafseerPage = false;
    var result = quranDataRepository.getSavedQuranTafsserMode;
    result.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (savedTafseerMode) => showTafseerPage = savedTafseerMode,
    );
    return showTafseerPage;
  }

  List<MarkedPage> get _getSavedSavedMarkedPages {
    List<MarkedPage> resutlList = [];
    var resutl = quranDataRepository.getSavedMarkedPages;

    resutl.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (savedMarkedPages) => resutlList = savedMarkedPages,
    );
    return resutlList;
  }

  List<Ayah> get _getSavedSavedMarkedAyahs {
    List<Ayah> resutlList = [];
    var resutl = quranDataRepository.getSavedMarkedAyahs;

    resutl.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (savedMarkedPages) => resutlList = savedMarkedPages,
    );
    return resutlList;
  }

  List<Surah> get allSurahs {
    List<Surah> surahs = [];
    var result = quranDataRepository.allSurahs;
    result.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (r) => surahs = r,
    );
    return surahs;
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

  List<Ayah> getAyahsDialogList(bool isStartAyah) {
    List<Ayah> ayahs = [];
    int surahNumber = state.resitationSettings.startAyah.surahNumber;
    ayahs.addAll(getSurahByNumber(surahNumber).ayahs);
    ayahs.removeWhere((element) => element.isBasmalah);
    if (!isStartAyah) {
      if (state.resitationSettings.startAyah.number == 0) {
        emit(state.copyWith(
          resitationSettings: state.resitationSettings.copyWith(
            startAyah: state.resitationSettings.startAyah.copyWith(number: 1),
          ),
        ));
      }
      ayahs.removeRange(0, state.resitationSettings.startAyah.number - 1);
    }

    return ayahs;
  }

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

  Ayah getResitationSettingsAyah({required bool isStartAyah}) {
    if (isStartAyah) {
      return state.resitationSettings.startAyah;
    } else {
      return state.resitationSettings.endAyah;
    }
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
}
