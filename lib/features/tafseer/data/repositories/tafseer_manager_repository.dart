import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import '../../tafseer.dart';
import '../datasources/tafseer_selected_data_source.dart';

class TafseerManagerRepository implements ITafseerManagerRepository {
  final ITafseerManagertaSource tafseerManagerDataSource;
  final ITafseerDownloaderDataSource tafseerDownloaderDataSource;
  final ITafseerFileDataSource tafseerFileDataSource;
  final ITafseerSelectedDataSource tafseerSelectedDataSource;
  TafseerManagerRepository({
    required this.tafseerManagerDataSource,
    required this.tafseerDownloaderDataSource,
    required this.tafseerFileDataSource,
    required this.tafseerSelectedDataSource,
  });
  @override
  Future<Either<Failure, List<TafseerManagerModel>>> get getTafsers async {
    try {
      var result = await tafseerManagerDataSource.getTafsers;
      return Future.value(Right(result));
    } catch (e) {
      debugPrint(e.toString());
      return Future.value(Left(JsonFailure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, bool>> checkTafseerIfDownloaded(int tafseerId) async {
    try {
      var result = await tafseerFileDataSource.checkTafseerIfDownloaded(tafseerId);
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, StreamedResponse>> downloadTafseerStream(int tafseerId) async {
    try {
      var result = await tafseerDownloaderDataSource.downloadTafseerStream(tafseerId);
      return Future.value(Right(result));
    } catch (e) {
      debugPrint(e.toString());
      return Future.value(Left(JsonFailure(e.toString())));
    }
  }

  @override
  Either<Failure, Unit> writeDataIntoFileIntoFileAsBytesSync(int tafseerid, List<int> data) {
    try {
      tafseerFileDataSource.writeDataIntoFileIntoFileAsBytesSync(tafseerid, data);
      return const Right(unit);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveSelectedTafseer(int tafseerId) async {
    try {
      tafseerSelectedDataSource.saveSelectedTafseer(tafseerId);
      return Future.value(const Right(unit));
    } catch (e) {
      debugPrint(e.toString());
      return Future.value(Left(JsonFailure(e.toString())));
    }
  }
}
