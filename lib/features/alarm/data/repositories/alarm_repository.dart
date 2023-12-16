

import '../../../../core/utils/params/params.dart';
import '../datasources/alarm_get_datapart_data_source.dart';

import '../models/alarm_part_model.dart';

import '../../../../core/utils/enums/enums.dart';
import '../../domain/repositories/i_alarm_repository.dart';

class AlarmRepository implements IAlarmRepository {
  IAlarmGetDatapartDataSource alarmGetDatapartDataSource;

  AlarmRepository({required this.alarmGetDatapartDataSource});

  @override
  AlarmPartModel getAlarmPartData(GetAlarmDataPartParams params) {
    switch (params.aLarmType) {
      case ALarmType.dua:
        return alarmGetDatapartDataSource.getDuaAlarmPartData;
      case ALarmType.hadith:
        return alarmGetDatapartDataSource.getHadithAlarmPartData;
      case ALarmType.dailyAzkar:
        return alarmGetDatapartDataSource.getDailyAzkarAlarmPartData;
      case ALarmType.quran:
        return alarmGetDatapartDataSource.getQuranAlarmPartData;
      case ALarmType.fast:
        return alarmGetDatapartDataSource.getFastAlarmPartData;
      case ALarmType.pray:
        return alarmGetDatapartDataSource.getPrayAlarmPartData;
      default:
        throw UnimplementedError();
    }
  }
}
