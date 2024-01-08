import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../../../../core/utils/params/params.dart';
import '../../data/models/alarm_model.dart';
import '../../data/models/alarm_part_model.dart';

abstract class IAlarmRepository {
   Either<Failure,AlarmPartModel> getAlarmPartData(GetAlarmDataPartParams params);
   Either<Failure,Unit> updateAlarmModel(AlarmModel alarmPartModel);
}
