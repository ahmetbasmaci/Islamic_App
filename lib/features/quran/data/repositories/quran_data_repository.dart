import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:zad_almumin/core/error/failure/failure.dart';
import 'package:zad_almumin/features/quran/data/datasources/quran_data_data_source.dart';

import 'package:zad_almumin/features/quran/data/models/ayah.dart';

import 'package:zad_almumin/features/quran/data/models/surah.dart';

import '../../domain/repositories/i_quran_data_repository.dart';

class QuranDataRepository implements IQuranDataRepository {
  final IQuranDataDataSource _quranDataDataSource;

  QuranDataRepository({required IQuranDataDataSource quranDataDataSource}) : _quranDataDataSource = quranDataDataSource;

  @override
  Either<Failure, List<Surah>> get alSurahs {
    try {
      var result = _quranDataDataSource.alSurahs;
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, Ayah> getAyah(int surahNumber, int ayahNumber) {
    try {
      var result = _quranDataDataSource.getAyah(surahNumber, ayahNumber);
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, List<Ayah>> getAyahsInPage(int page) {
    try {
      var result = _quranDataDataSource.getAyahsInPage(page);
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, int> getJuzNumberByPage(int page) {
    try {
      var result = _quranDataDataSource.getJuzNumberByPage(page);
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, List<Surah>> getMatchedSurah(String surahName) {
    try {
      var result = _quranDataDataSource.getMatchedSurah(surahName);
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, int> getPageInJuz(int page) {
    try {
      var result = _quranDataDataSource.getPageInJuz(page);
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, Ayah> getRandomAyah() {
    try {
      var result = _quranDataDataSource.getRandomAyah();
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, Ayah> getRandomAyahBySureNumber(int sureNumber) {
    try {
      var result = _quranDataDataSource.getRandomAyahBySureNumber(sureNumber);
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, Surah> getSurahByName(String surahName) {
    try {
      var result = _quranDataDataSource.getSurahByName(surahName);
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, Surah> getSurahByNumber(int surahNumber) {
    try {
      var result = _quranDataDataSource.getSurahByNumber(surahNumber);
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, Surah> getSurahByPage(int page) {
    try {
      var result = _quranDataDataSource.getSurahByPage(page);
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, bool> get isEmpty {
    try {
      var result = _quranDataDataSource.isEmpty;
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, bool> get isNotEmpty {
    try {
      var result = _quranDataDataSource.isNotEmpty;
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, int> get surahsCount {
    try {
      var result = _quranDataDataSource.surahsCount;
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, int> get getSavedCurrentPageIndex {
    try {
      var result = _quranDataDataSource.getSavedCurrentPageIndex;
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, void> saveCurrentPageIndex(int page) {
    try {
      _quranDataDataSource.saveCurrentPageIndex(page);
      return const Right(null);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, List<dynamic>> get getSavedSearchFilterList {
    try {
      var result = _quranDataDataSource.getSavedSearchFilterList;
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, void> savedSearchFilterList(List<Map> listMap) {
    try {
      _quranDataDataSource.savedSearchFilterList(listMap);
      return const Right(null);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, List<int>> searchPages(int num) {
    try {
      var result = _quranDataDataSource.searchPages(num);
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, List<Surah>> searchSurahs(String query) {
    try {
      var result = _quranDataDataSource.searchSurahs(query);
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, List<Ayah>> searchAyahs(String query) {
    try {
      var result = _quranDataDataSource.searchAyahs(query);
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, bool> get getSavedQuranViewMode {
    try {
      var result = _quranDataDataSource.getSavedQuranViewMode;
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, void> saveQuranViewMode(bool quranViewModeInImages) {
    try {
      _quranDataDataSource.saveQuranViewMode(quranViewModeInImages);
      return const Right(null);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, double> get getSavedQuranFontSize {
    try {
      var result = _quranDataDataSource.getSavedQuranFontSize;
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, bool> get getSavedQuranTafsserMode {
    try {
      var result = _quranDataDataSource.getSavedQuranTafsserMode;
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, void> saveQuranFontSize(double fontSize) {
    try {
      _quranDataDataSource.saveQuranFontSize(fontSize);
      return const Right(null);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, void> saveQuranTafsserMode(bool quranTafsserMode) {
    try {
      _quranDataDataSource.saveQuranTafsserMode(quranTafsserMode);
      return const Right(null);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }
}
