import 'dart:math';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import 'package:zad_almumin/core/packages/local_storage/local_storage.dart';
import 'package:zad_almumin/core/utils/storage_keys.dart';
import '../../../../core/services/json_service.dart';
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
}
