
import '../../../../core/utils/params/params.dart';
import '../../data/models/alarm_part_model.dart';

abstract class IAlarmRepository {
 AlarmPartModel getAlarmPartData(GetAlarmDataPartParams params);
}
