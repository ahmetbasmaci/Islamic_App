import 'package:zad_almumin/features/alarm/domain/repositories/i_alarm_repository.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/params/params.dart';

class UpdateAlarmModelUseCase extends IUseCase<void, UpdateAlarmModelParams> {
  IAlarmRepository alarmrepository;

  UpdateAlarmModelUseCase({required this.alarmrepository});
  @override
  void call(UpdateAlarmModelParams params) {
    return alarmrepository.updateAlarmModel(params.alarmModel);
  }
}
