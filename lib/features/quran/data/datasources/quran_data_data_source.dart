import 'dart:math';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import 'package:zad_almumin/core/packages/local_storage/local_storage.dart';
import 'package:zad_almumin/core/utils/storage_keys.dart';
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
  void saveCurrentPageIndex(int page);
  int get getSavedCurrentPageIndex;
  List<dynamic> get getSavedSearchFilterList;
  void savedSearchFilterList(List<Map> listMap);
  List<int> searchPages(int num);
  List<Surah> searchSurahs(String query);
  List<Ayah> searchAyahs(String query);
  bool get getSavedQuranViewMode;
  void saveQuranViewMode(bool quranViewModeInImages);
  double get getSavedQuranFontSize;
  void saveQuranFontSize(double fontSize);
  bool get getSavedQuranTafsserMode;
  void saveQuranTafsserMode(bool quranTafsserMode);
  QuranReaders get getSavedSelectedReader;
  void savedSelectedReader(QuranReaders quranReader);
  List<MarkedPage> get getSavedMarkedPages;
  void savedMarkedPages(List<MarkedPage> markedPages);
   List<Ayah> get getSavedMarkedAyahs;
 void savedMarkedAyahs(List<Ayah> markedAyahs);
}

class QuranDataDataSource implements IQuranDataDataSource {
  final ILocalStorage _localStorage;

  QuranDataDataSource({required ILocalStorage localStorage}) : _localStorage = localStorage {
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
      (element) => element.name.withOutTashkil == surahName.withOutTashkil,
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
          (element) => element.name.withOutTashkil.contains(surahName.withOutTashkil),
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
    List<dynamic> data = await JsonService.readJson(AppJsonPaths.allQuranPath);
    if (data.isEmpty) return;
    _surahs = data.map((e) => Surah.fromjson(e)).toList();
  }

  @override
  int get getSavedCurrentPageIndex => _localStorage.read<int>(StorageKeys.pageIndex) ?? 0;

  @override
  void saveCurrentPageIndex(int page) {
    _localStorage.write(StorageKeys.pageIndex, page);
  }

  @override
  List<dynamic> get getSavedSearchFilterList => _localStorage.read(StorageKeys.searchFilterList) ?? [];

  @override
  void savedSearchFilterList(List<Map> listMap) {
    _localStorage.write(StorageKeys.searchFilterList, listMap);
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
      if (_surahs[i].name.withOutTashkil.contains(query.withOutTashkil)) matchedSurahs.add(_surahs[i]);
    }
    return matchedSurahs;
  }

  @override
  List<Ayah> searchAyahs(String query) {
    List<Ayah> matchedAyahs = [];
    for (var i = 0; i < alSurahs.length; i++) {
      for (var j = 0; j < alSurahs[i].ayahs.length; j++) {
        if (alSurahs[i].ayahs[j].text.withOutTashkil.contains(query.withOutTashkil))
          matchedAyahs.add(_surahs[i].ayahs[j]);
      }
    }
    return matchedAyahs;
  }

  @override
  bool get getSavedQuranViewMode => _localStorage.read<bool>(StorageKeys.quranViewModeInImages) ?? true;

  @override
  void saveQuranViewMode(bool quranViewModeInImages) {
    _localStorage.write(StorageKeys.quranViewModeInImages, quranViewModeInImages);
  }

  @override
  double get getSavedQuranFontSize => _localStorage.read<double>(StorageKeys.quranFontSize) ?? 20.0;

  @override
  bool get getSavedQuranTafsserMode => _localStorage.read<bool>(StorageKeys.quranTafsserMode) ?? false;

  @override
  void saveQuranFontSize(double fontSize) {
    _localStorage.write(StorageKeys.quranFontSize, fontSize);
  }

  @override
  void saveQuranTafsserMode(bool quranTafsserMode) {
    _localStorage.write(StorageKeys.quranTafsserMode, quranTafsserMode);
  }

  @override
  QuranReaders get getSavedSelectedReader {
    return QuranReaders.values[_localStorage.read<int>(StorageKeys.selectedReader) ?? 0];
  }

  @override
  void savedSelectedReader(QuranReaders quranReader) {
    _localStorage.write(StorageKeys.selectedReader, quranReader.index);
  }

  @override
  List<MarkedPage> get getSavedMarkedPages {
    return _localStorage.read<List<MarkedPage>>(StorageKeys.markedPages) ?? [];
  }

  @override
  void savedMarkedPages(List<MarkedPage> markedPages) {
    _localStorage.write(StorageKeys.markedPages, markedPages);
  }
  
  @override
  List<Ayah> get getSavedMarkedAyahs
  {
    return _localStorage.read<List<Ayah>>(StorageKeys.markedAyahs) ?? [];
  }
  
  @override
  void savedMarkedAyahs(List<Ayah> markedAyahs) {
    _localStorage.write(StorageKeys.markedAyahs, markedAyahs);
  }
}
