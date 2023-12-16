import 'package:dartz/dartz.dart';
import '../../error/failure/failure.dart';

abstract class IUsecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
