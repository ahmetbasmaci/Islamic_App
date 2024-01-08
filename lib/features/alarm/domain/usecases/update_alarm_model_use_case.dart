import 'package:dartz/dartz.dart';
import 'package:zad_almumin/features/alarm/domain/repositories/i_alarm_repository.dart';

import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/params/params.dart';

class UpdateAlarmModelUseCase extends IUseCase<Unit, UpdateAlarmModelParams> {
  IAlarmRepository alarmrepository;

  UpdateAlarmModelUseCase({required this.alarmrepository});
  @override
   Either<Failure,Unit> call(UpdateAlarmModelParams params) {
    return alarmrepository.updateAlarmModel(params.alarmModel);
  }
}
