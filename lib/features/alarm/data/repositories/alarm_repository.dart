import '../../../../core/utils/params/params.dart';
import '../datasources/alarm_get_datapart_data_source.dart';

import '../models/alarm_model.dart';
import '../models/alarm_part_model.dart';

import '../../../../core/utils/enums/enums.dart';
import '../../domain/repositories/i_alarm_repository.dart';

class AlarmRepository implements IAlarmRepository {
  IAlarmGetDatapartDataSource alarmGetDatapartDataSource;

  AlarmRepository({required this.alarmGetDatapartDataSource});

  @override
  AlarmPartModel getAlarmPartData(GetAlarmDataPartParams params) {
    switch (params.aLarmType) {
      case AlarmPart.dua:
        return alarmGetDatapartDataSource.getDuaAlarmPartData;
      case AlarmPart.hadith:
        return alarmGetDatapartDataSource.getHadithAlarmPartData;
      case AlarmPart.dailyAzkar:
        return alarmGetDatapartDataSource.getDailyAzkarAlarmPartData;
      case AlarmPart.quran:
        return alarmGetDatapartDataSource.getQuranAlarmPartData;
      case AlarmPart.fast:
        return alarmGetDatapartDataSource.getFastAlarmPartData;
      case AlarmPart.pray:
        return alarmGetDatapartDataSource.getPrayAlarmPartData;
      default:
        throw UnimplementedError();
    }
  }

  @override
  void updateAlarmModel(AlarmModel alarmModel) {
    alarmGetDatapartDataSource.updateAlarmModel(alarmModel);
  }
}
