import 'dart:math';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import 'package:zad_almumin/core/packages/local_storage/local_storage.dart';
import 'package:zad_almumin/core/utils/resources/app_storage_keys.dart';
import '../../../../core/services/json_service.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/resources/resources.dart';
import '../../quran.dart';

abstract class IQuranDataDataSource {
  List<Surah> get alSurahs;
  bool get isEmpty;
  bool get isNotEmpty;
  int get surahsCount;
  Surah getSurahByPage(int page);
  Surah getSurahByName(String surahName);
  Surah getSurahByNumber(int surahNumber);
  List<Ayah> getAyahsInPage(int page);
  List<Surah> getMatchedSurah(String surahName);
  Ayah getAyah(int surahNumber, int ayahNumber);
  Ayah getRandomAyah();
  Ayah getRandomAyahBySureNumber(int sureNumber);
  int getJuzNumberByPage(int page);
  int getPageInJuz(int page);
  Future<void> saveCurrentPageIndex(int page);
  int get getSavedCurrentPageIndex;
  List<dynamic> get getSavedSearchFilterList;
  Future<void> savedSearchFilterList(List<FilterChipModel> listMap);
  List<int> searchPages(int num);
  List<Surah> searchSurahs(String query);
  List<Ayah> searchAyahs(String query);
  bool get getSavedQuranViewMode;
  Future<void> saveQuranViewMode(bool quranViewModeInImages);
  double get getSavedQuranFontSize;
  Future<void> saveQuranFontSize(double fontSize);
  bool get getSavedQuranTafsserMode;
  Future<void> saveQuranTafsserMode(bool quranTafsserMode);
  QuranReaders get getSavedSelectedReader;
  Future<void> savedSelectedReader(QuranReaders quranReader);
  List<MarkedPage> get getSavedMarkedPages;
  Future<void> savedMarkedPages(List<MarkedPage> markedPages);
  List<Ayah> get getSavedMarkedAyahs;
  Future<void> savedMarkedAyahs(List<Ayah> markedAyahs);
}

class QuranDataDataSource implements IQuranDataDataSource {
  final ILocalStorage localStorage;
  final IJsonService jsonService;

  QuranDataDataSource({required this.localStorage, required this.jsonService}) {
    // _loadSurahs();
  }
  List<Surah> _surahs = [];
  @override
  bool get isEmpty => _surahs.isEmpty;
  @override
  bool get isNotEmpty => _surahs.isNotEmpty;
  @override
  int get surahsCount => _surahs.length;

  @override
  List<Surah> get alSurahs => _surahs;

  @override
  Surah getSurahByPage(int page) {
    Surah surah = _surahs.firstWhere(
      (element) => element.ayahs.first.page <= page && element.ayahs.last.page >= page,
      orElse: () => Surah.empty(),
    );

    return surah;
  }

  @override
  Surah getSurahByName(String surahName) {
    Surah surah = _surahs.firstWhere(
      (element) => element.name.removeTashkilAndSpace == surahName.removeTashkilAndSpace,
      orElse: () => Surah.empty(),
    );
    return surah;
  }

  @override
  Surah getSurahByNumber(int surahNumber) {
    // while (_surahs.isEmpty) {

    // }
    Surah surah = _surahs.firstWhere(
      (element) => element.number == surahNumber,
      orElse: () => Surah.empty(),
    );
    return surah;
  }

  @override
  List<Ayah> getAyahsInPage(int page) {
    // while (_surahs.isEmpty) {
    // await Future.delayed(const Duration(seconds: 1));
    // }

    List<Ayah> allAyahsInPage = [];
    for (var surah in _surahs) {
      // List<Ayah> ayahs = [];
      if (surah.ayahs.first.page <= page && surah.ayahs.last.page >= page) {
        for (var ayah in surah.ayahs) {
          // if (ayah.page == page) ayahs.add(ayah);
          if (ayah.page == page) allAyahsInPage.add(ayah);
        }
        // allAyahsInPage.add(ayahs);
      }
    }
    return allAyahsInPage;
  }

  @override
  List<Surah> getMatchedSurah(String surahName) {
    List<Surah> matchedSurah = _surahs
        .where(
          (element) => element.name.removeTashkilAndSpace.contains(surahName.removeTashkilAndSpace),
        )
        .toList();
    return matchedSurah;
  }

  @override
  Ayah getAyah(int surahNumber, int ayahNumber) {
    List<Ayah> ayahs = getSurahByNumber(surahNumber).ayahs;
    if (ayahs.length > ayahNumber)
      return ayahs.elementAt(ayahNumber);
    else {
      return getRandomAyah();
    }
  }

  @override
  Ayah getRandomAyah() {
    int randomSureNumber = Random().nextInt(114) + 1;
    return getRandomAyahBySureNumber(randomSureNumber);
  }

  @override
  Ayah getRandomAyahBySureNumber(int sureNumber) {
    List<Ayah> ayahs = getSurahByNumber(sureNumber).ayahs;
    int randomAyah = Random().nextInt(ayahs.length);
    return ayahs.elementAt(randomAyah);
  }

  @override
  int getJuzNumberByPage(int page) {
    final juz = (page / 20).ceil();
    return min(juz, 30);
  }

  @override
  int getPageInJuz(int page) => page % 20;

  Future<void> loadSurahs() async {
    List<dynamic> data = await jsonService.readJson(AppJsonPaths.allQuranPath);
    if (data.isEmpty) return;
    _surahs = data.map((e) => Surah.fromJson(e)).toList();
  }

  @override
  int get getSavedCurrentPageIndex => localStorage.read<int>(AppStorageKeys.pageIndex) ?? 0;

  @override
  Future<void> saveCurrentPageIndex(int page) async {
    await localStorage.write(AppStorageKeys.pageIndex, page);
  }

  @override
  List<dynamic> get getSavedSearchFilterList => localStorage.read(AppStorageKeys.searchFilterList) ?? [];

  @override
  Future<void> savedSearchFilterList(List<FilterChipModel> filterChipModels) async {
    List<Map> listMap = filterChipModels.map((e) => e.toJson()).toList();
    await localStorage.write(AppStorageKeys.searchFilterList, listMap);
  }

  @override
  List<int> searchPages(int num) {
    List<int> pages = [];
    for (var i = 1; i <= 604; i++) {
      if (i.toString().contains(num.toString())) pages.add(i);
    }
    return pages;
  }

  @override
  List<Surah> searchSurahs(String query) {
    List<Surah> matchedSurahs = [];
    for (var i = 0; i < alSurahs.length; i++) {
      if (_surahs[i].name.removeTashkilAndSpace.contains(query.removeTashkilAndSpace)) matchedSurahs.add(_surahs[i]);
    }
    return matchedSurahs;
  }

  @override
  List<Ayah> searchAyahs(String query) {
    List<Ayah> matchedAyahs = [];
    for (var i = 0; i < alSurahs.length; i++) {
      for (var j = 0; j < alSurahs[i].ayahs.length; j++) {
        if (alSurahs[i].ayahs[j].text.removeTashkilAndSpace.contains(query.removeTashkilAndSpace))
          matchedAyahs.add(_surahs[i].ayahs[j]);
      }
    }
    return matchedAyahs;
  }

  @override
  bool get getSavedQuranViewMode => localStorage.read<bool>(AppStorageKeys.quranViewModeInImages) ?? true;

  @override
  Future<void> saveQuranViewMode(bool quranViewModeInImages) async {
    await localStorage.write(AppStorageKeys.quranViewModeInImages, quranViewModeInImages);
  }

  @override
  double get getSavedQuranFontSize =>
      localStorage.read<double>(AppStorageKeys.quranFontSize) ?? AppSizes.minQuranFontSize;

  @override
  bool get getSavedQuranTafsserMode => localStorage.read<bool>(AppStorageKeys.quranTafsserMode) ?? false;

  @override
  Future<void> saveQuranFontSize(double fontSize) async {
    await localStorage.write(AppStorageKeys.quranFontSize, fontSize);
  }

  @override
  Future<void> saveQuranTafsserMode(bool quranTafsserMode) async {
    await localStorage.write(AppStorageKeys.quranTafsserMode, quranTafsserMode);
  }

  @override
  QuranReaders get getSavedSelectedReader {
    return QuranReaders.values[localStorage.read<int>(AppStorageKeys.selectedReader) ?? 0];
  }

  @override
  Future<void> savedSelectedReader(QuranReaders quranReader) async {
    await localStorage.write(AppStorageKeys.selectedReader, quranReader.index);
  }

  @override
  List<MarkedPage> get getSavedMarkedPages {
    var listMap = localStorage.read<List<dynamic>>(AppStorageKeys.markedPages) ?? [];
    return listMap.map((e) => MarkedPage.fromJson(e)).toList();
  }

  @override
  Future<void> savedMarkedPages(List<MarkedPage> markedPages) async {
    var listMap = markedPages.map((e) => e.toJson()).toList();
    await localStorage.write(AppStorageKeys.markedPages, listMap);
  }

  @override
  List<Ayah> get getSavedMarkedAyahs {
    var listMap = localStorage.read<List<dynamic>>(AppStorageKeys.markedAyahs) ?? [];
    return listMap.map((e) => Ayah.fromJson(e)).toList();
  }

  @override
  Future<void> savedMarkedAyahs(List<Ayah> markedAyahs) async {
    var listMap = markedAyahs.map((e) => e.toJson()).toList();
    await localStorage.write(AppStorageKeys.markedAyahs, listMap);
  }
}
