import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';

abstract class IFavoriteButtonRepository {
  Future<Either<Failure, bool>> checkItemIfFavorite(String contentId);
  Future<Either<Failure, Unit>> removeItem(String content);
  Future<Either<Failure, Unit>> addItem(String content);
}
