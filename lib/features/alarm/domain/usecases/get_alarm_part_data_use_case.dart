import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/params/params.dart';
import '../../data/models/alarm_part_model.dart';
import '../repositories/i_alarm_repository.dart';

class GetAlarmPartDataUseCase extends IUseCase<AlarmPartModel, GetAlarmDataPartParams> {
  IAlarmRepository alarmrepository;

  GetAlarmPartDataUseCase({required this.alarmrepository});
  @override
  Either<Failure,AlarmPartModel> call(GetAlarmDataPartParams params) {
    return alarmrepository.getAlarmPartData(params);
  }
}
