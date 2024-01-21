import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import '../../tafseer.dart';

class TafseerRepository implements ITafseerRepository {
  final ITafseerManagertaSource tafseerManagerDataSource;
  final ITafseerDownloaderDataSource tafseerDownloaderDataSource;
  final ITafseerFileDataSource tafseerFileDataSource;
  final ITafseerSelectedDataSource tafseerSelectedDataSource;
  TafseerRepository({
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
      return Future.value(Left(JsonFailure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, bool>> checkTafseerIfDownloaded(int tafseerId) async {
    try {
      var result = await tafseerFileDataSource.checkTafseerIfDownloaded(tafseerId);
      return Right(result);
    } catch (e) {
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, StreamedResponse>> downloadTafseerStream(int tafseerId) async {
    try {
      var result = await tafseerDownloaderDataSource.downloadTafseerStream(tafseerId);
      return Future.value(Right(result));
    } catch (e) {
      return Future.value(Left(JsonFailure(e.toString())));
    }
  }

  @override
  Either<Failure, Unit> writeDataIntoFileIntoFileAsBytesSync(int tafseerid, List<int> data) {
    try {
      tafseerFileDataSource.writeDataIntoFileIntoFileAsBytesSync(tafseerid, data);
      return const Right(unit);
    } catch (e) {
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveSelectedTafseer(SelectedTafseerIdModel tafseerIdModel) async {
    try {
      tafseerSelectedDataSource.saveSelectedTafseer(tafseerIdModel);
      return Future.value(const Right(unit));
    } catch (e) {
      return Future.value(Left(JsonFailure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, SelectedTafseerIdModel>> get getSelectedTafseerId async {
    try {
      var result = await tafseerSelectedDataSource.getSelectedTafseerId;
      return Future.value(Right(result));
    } catch (e) {
      return Future.value(Left(JsonFailure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateSelectedTafseer(int tafseerId) {
    // TODO: implement updateSelectedTafseer
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TafseersDataModel>> getTafseersData(int tafseerId) async {
    try {
      var result = await tafseerFileDataSource.getTafseersData(tafseerId);
      return Future.value(Right(result));
    } catch (e) {
      return Future.value(Left(JsonFailure(e.toString())));
    }
  }
}
