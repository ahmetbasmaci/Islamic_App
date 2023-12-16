import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecase/i_use_case_async.dart';
import '../../../../core/utils/params/params.dart';
import '../../azkar.dart';

class ZikrCardGetAllahNamesUseCase implements IUseCaseAsync<List<AllahNamesModel>, NoParams> {
  final IAzkarRepository azkarRepository;

  ZikrCardGetAllahNamesUseCase({required this.azkarRepository});
  @override
  Future<Either<Failure, List<AllahNamesModel>>> call(params) async {
    return azkarRepository.getAllahNamesModels();
  }
}
