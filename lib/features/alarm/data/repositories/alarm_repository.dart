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
      case ALarmPart.dua:
        return alarmGetDatapartDataSource.getDuaAlarmPartData;
      case ALarmPart.hadith:
        return alarmGetDatapartDataSource.getHadithAlarmPartData;
      case ALarmPart.dailyAzkar:
        return alarmGetDatapartDataSource.getDailyAzkarAlarmPartData;
      case ALarmPart.quran:
        return alarmGetDatapartDataSource.getQuranAlarmPartData;
      case ALarmPart.fast:
        return alarmGetDatapartDataSource.getFastAlarmPartData;
      case ALarmPart.pray:
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
