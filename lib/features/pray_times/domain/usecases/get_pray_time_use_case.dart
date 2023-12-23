import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import 'package:zad_almumin/core/utils/usecase/usecase.dart';
import 'package:zad_almumin/features/pray_times/domain/repositories/i_pray_times_repository.dart';

import '../../../../core/utils/params/params.dart';
import '../../data/models/praies_in_day_model.dart';

class GetPrayTimeUseCase extends IUsecase<PraiesInDayModel, GetPrayTimeParams> {
  IPrayTimesRepository prayTimesRepository;

  GetPrayTimeUseCase({required this.prayTimesRepository});
  @override
  Future<Either<Failure, PraiesInDayModel>> call(params) {
    return prayTimesRepository.getPrayTime(params.position, params.date);
  }
}
