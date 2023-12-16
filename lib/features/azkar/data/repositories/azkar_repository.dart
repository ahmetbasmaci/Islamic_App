import 'package:dartz/dartz.dart';
import '../../../../core/error/failure/failure.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../azkar.dart';

class AzkarRepository implements IAzkarRepository {
  final IZikrCardGetZikrDataSource zikrCardGetZikrDataSource;
  final IZikrCardGetAllahNamesDataSource zikrCardGetAllahNamesDataSource;

  AzkarRepository({
    required this.zikrCardGetZikrDataSource,
    required this.zikrCardGetAllahNamesDataSource,
  });
  @override
  Future<Either<Failure, List<ZikrCardModel>>> getAllZikrModels(ZikrCategories zikrCategory) async {
    try {
      var result = await zikrCardGetZikrDataSource.getAllZikrModels(zikrCategory);
      return Right(result);
    } catch (e) {
      print(e);
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AllahNamesModel>>> getAllahNamesModels() async {
    try {
      var result = await zikrCardGetAllahNamesDataSource.getAllahNamesModels();
      return Right(result);
    } catch (e) {
      print(e);
      return Left(JsonFailure(e.toString()));
    }
  }
}
