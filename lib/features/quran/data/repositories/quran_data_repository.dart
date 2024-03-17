import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import 'package:zad_almumin/core/packages/audio_manager/model/audio_stream_model.dart';
import 'package:zad_almumin/core/utils/enums/enums.dart';
import '../../../../core/error/exceptions/app_exceptions.dart';
import '../../quran.dart';

class QuranDataRepository implements IQuranDataRepository {
  final IQuranDataDataSource quranDataDataSource;
  final IQuranAudioDataSource quranAudioDataSource;
  final IQuranAudioProgressDataSource quranAudioProgressDataSource;

  QuranDataRepository({
    required this.quranDataDataSource,
    required this.quranAudioDataSource,
    required this.quranAudioProgressDataSource,
  });

  @override
  Either<Failure, List<Surah>> get allSurahs {
    try {
      var result = quranDataDataSource.alSurahs;
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, Ayah> getAyah(int surahNumber, int ayahNumber) {
    try {
      var result = quranDataDataSource.getAyah(surahNumber, ayahNumber);
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, List<Ayah>> getAyahsInPage(int page) {
    try {
      var result = quranDataDataSource.getAyahsInPage(page);
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, int> getJuzNumberByPage(int page) {
    try {
      var result = quranDataDataSource.getJuzNumberByPage(page);
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, List<Surah>> getMatchedSurah(String surahName) {
    try {
      var result = quranDataDataSource.getMatchedSurah(surahName);
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, int> getPageInJuz(int page) {
    try {
      var result = quranDataDataSource.getPageInJuz(page);
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, Ayah> getRandomAyah() {
    try {
      var result = quranDataDataSource.getRandomAyah();
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, Ayah> getRandomAyahBySureNumber(int sureNumber) {
    try {
      var result = quranDataDataSource.getRandomAyahBySureNumber(sureNumber);
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, Surah> getSurahByName(String surahName) {
    try {
      var result = quranDataDataSource.getSurahByName(surahName);
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, Surah> getSurahByNumber(int surahNumber) {
    try {
      var result = quranDataDataSource.getSurahByNumber(surahNumber);
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, Surah> getSurahByPage(int page) {
    try {
      var result = quranDataDataSource.getSurahByPage(page);
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, bool> get isEmpty {
    try {
      var result = quranDataDataSource.isEmpty;
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, bool> get isNotEmpty {
    try {
      var result = quranDataDataSource.isNotEmpty;
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, int> get surahsCount {
    try {
      var result = quranDataDataSource.surahsCount;
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, int> get getSavedCurrentPageIndex {
    try {
      var result = quranDataDataSource.getSavedCurrentPageIndex;
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveCurrentPageIndex(int page) async {
    try {
      await quranDataDataSource.saveCurrentPageIndex(page);
      return const Right(null);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, List<dynamic>> get getSavedSearchFilterList {
    try {
      var result = quranDataDataSource.getSavedSearchFilterList;
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> savedSearchFilterList(List<FilterChipModel> filterChipModels) async {
    try {
      await quranDataDataSource.savedSearchFilterList(filterChipModels);
      return const Right(null);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, List<int>> searchPages(int num) {
    try {
      var result = quranDataDataSource.searchPages(num);
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, List<Surah>> searchSurahs(String query) {
    try {
      var result = quranDataDataSource.searchSurahs(query);
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, List<Ayah>> searchAyahs(String query) {
    try {
      var result = quranDataDataSource.searchAyahs(query);
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, bool> get getSavedQuranViewMode {
    try {
      var result = quranDataDataSource.getSavedQuranViewMode;
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveQuranViewMode(bool quranViewModeInImages) async {
    try {
      await quranDataDataSource.saveQuranViewMode(quranViewModeInImages);
      return const Right(null);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, double> get getSavedQuranFontSize {
    try {
      var result = quranDataDataSource.getSavedQuranFontSize;
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, bool> get getSavedQuranTafsserMode {
    try {
      var result = quranDataDataSource.getSavedQuranTafsserMode;
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveQuranFontSize(double fontSize) async {
    try {
      await quranDataDataSource.saveQuranFontSize(fontSize);
      return const Right(null);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveQuranTafsserMode(bool quranTafsserMode) async {
    try {
      await quranDataDataSource.saveQuranTafsserMode(quranTafsserMode);
      return const Right(null);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, QuranReader> get getSavedSelectedReader {
    try {
      var result = quranDataDataSource.getSavedSelectedReader;
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> savedSelectedReader(QuranReader quranReader) async {
    try {
      await quranDataDataSource.savedSelectedReader(quranReader);
      return const Right(null);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, List<MarkedPage>> get getSavedMarkedPages {
    try {
      var result = quranDataDataSource.getSavedMarkedPages;
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> savedMarkedPages(List<MarkedPage> markedPages) async {
    try {
      await quranDataDataSource.savedMarkedPages(markedPages);
      return const Right(null);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, List<Ayah>> get getSavedMarkedAyahs {
    try {
      var result = quranDataDataSource.getSavedMarkedAyahs;
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> savedMarkedAyahs(List<Ayah> markedAyahs) async {
    try {
      await quranDataDataSource.savedMarkedAyahs(markedAyahs);
      return const Right(null);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AudioStreamModel>> getAudioProgress() async {
    try {
      var result = await quranAudioProgressDataSource.getAudioProgress();
      return Right(result);
    } catch (e) {
      return Left(AudioFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> playPauseSingleAudio(
    List<Ayah> ayahs,
    int startAyahIndex,
    QuranReader quranReader,
    Function(Ayah complatedAyah, bool partEnded) onComplated,
  ) async {
    try {
      bool audioComplated = await quranAudioDataSource.playPauseMultibleAudio(
        ayahs,
        startAyahIndex,
        quranReader,
        onComplated,
      );
      return Right(audioComplated);
    } on AudioException catch (e) {
      return Left(AudioFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> stopAudio() async {
    try {
      bool audioComplated = await quranAudioDataSource.stopAudio();
      return Right(audioComplated);
    } on AudioException catch (e) {
      return Left(AudioFailure(e.message));
    }
  }

  @override
  Either<Failure, bool> get isAudioPlaying {
    try {
      var result = quranAudioDataSource.isAudioPlaying;
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }
}
