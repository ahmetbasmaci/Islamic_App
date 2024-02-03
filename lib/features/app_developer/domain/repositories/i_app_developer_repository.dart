import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';

abstract class IAppDeveloperRepository {
  Future<Either<Failure, Unit>> saveMessageToDb(String name, String message);
}
