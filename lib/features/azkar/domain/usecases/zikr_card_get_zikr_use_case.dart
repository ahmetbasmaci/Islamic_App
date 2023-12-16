import 'package:dartz/dartz.dart';
import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecase/i_use_case_async.dart';
import '../../../../core/utils/params/params.dart';

import '../../azkar.dart';

class ZikrCardGetZikrUseCase implements IUseCaseAsync<List<ZikrCardModel>, GetZikrCardDataParams> {
  final IAzkarRepository azkarRepository;

  ZikrCardGetZikrUseCase({required this.azkarRepository});
  @override
  Future<Either<Failure, List<ZikrCardModel>>> call(params) async {
    return azkarRepository.getAllZikrModels(params.zikrCategory);
  }
}
