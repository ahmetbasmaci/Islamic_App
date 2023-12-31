import 'dart:core';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure/failure.dart';
import '../../quran.dart';

abstract class IQuranDataRepository {
  Either<Failure, List<Surah>> get alSurahs;
  Either<Failure, bool> get isEmpty;
  Either<Failure, bool> get isNotEmpty;
  Either<Failure, int> get surahsCount;
  Either<Failure, Surah> getSurahByPage(int page);
  Either<Failure, Surah> getSurahByName(String surahName);
  Either<Failure, Surah> getSurahByNumber(int surahNumber);
  Either<Failure, List<Ayah>> getAyahsInPage(int page);
  Either<Failure, List<Surah>> getMatchedSurah(String surahName);
  Either<Failure, Ayah> getAyah(int surahNumber, int ayahNumber);
  Either<Failure, Ayah> getRandomAyah();
  Either<Failure, Ayah> getRandomAyahBySureNumber(int sureNumber);
  Either<Failure, int> getJuzNumberByPage(int page);
  Either<Failure, int> getPageInJuz(int page);
  Either<Failure, void> saveCurrentPageIndex(int page);
  Either<Failure, int> get getSavedCurrentPageIndex;
  Either<Failure, List<dynamic>> get getSavedSearchFilterList;
  Either<Failure, void> savedSearchFilterList(List<Map> listMap);
  Either<Failure, List<int>> searchPages(int num);
  Either<Failure, List<Surah>> searchSurahs(String query);
  Either<Failure, List<Ayah>> searchAyahs(String query);
  Either<Failure, bool> get getSavedQuranViewMode;
  Either<Failure, void> saveQuranViewMode(bool quranViewModeInImages);
  Either<Failure, double> get getSavedQuranFontSize;
  Either<Failure, void> saveQuranFontSize(double fontSize);
  Either<Failure, bool> get getSavedQuranTafsserMode;
  Either<Failure, void> saveQuranTafsserMode(bool quranTafsserMode);
}
