import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import '../../favorite_button.dart';

class FavoriteButtonRepository implements IFavoriteButtonRepository {
  final IFavoriteButtonCheckContentIfFavoriteDataSource checkContentIfFavoriteDataSource;
  final IFavoriteButtonReadWriteDataSource readWriteDataSource;

  FavoriteButtonRepository({
    required this.checkContentIfFavoriteDataSource,
    required this.readWriteDataSource,
  });

  @override
  Future<Either<Failure, Unit>> addItem(String content) async {
    try {
      await readWriteDataSource.addItem(content);
      return const Right(unit);
    } catch (e) {
      return Left(SqliteFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> checkItemIfFavorite(String contentId) async {
    try {
      final result = await checkContentIfFavoriteDataSource.checkItemIfFavorite(contentId);
      return Right(result);
    } catch (e) {
      return Left(SqliteFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeItem(String content) async {
    try {
      await readWriteDataSource.removeItem(content);
      return const Right(unit);
    } catch (e) {
      return Left(SqliteFailure(e.toString()));
    }
  }
}
