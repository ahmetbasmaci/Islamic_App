import 'package:dartz/dartz.dart';

import '../error/failure/failure.dart';

abstract class IUseCaseAsync<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
