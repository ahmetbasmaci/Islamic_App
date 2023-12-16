import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../azkar.dart';

abstract class IAzkarRepository {
  Future<Either<Failure, List<ZikrCardModel>>> getAllZikrModels(ZikrCategories zikrCategory);
  Future<Either<Failure, List<AllahNamesModel>>> getAllahNamesModels();
}
