import 'package:dartz/dartz.dart';

import '../error/failure/failure.dart';

abstract class IUseCase<Type, Params> {
  Either<Failure, Type> call(Params params);
}
