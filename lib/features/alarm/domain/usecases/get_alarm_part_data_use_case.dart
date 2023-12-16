import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/params/params.dart';
import '../../data/models/alarm_part_model.dart';
import '../repositories/i_alarm_repository.dart';

class GetAlarmPartDataUseCase extends IUseCase<AlarmPartModel, GetAlarmDataPartParams> {
  IAlarmRepository alarmrepository;

  GetAlarmPartDataUseCase({required this.alarmrepository});
  @override
AlarmPartModel call(GetAlarmDataPartParams params) {
    return alarmrepository.getAlarmPartData(params);
  }
}
