import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failure/failure.dart';
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
  Either<Failure, AlarmPartModel> getAlarmPartData(GetAlarmDataPartParams params) {
    switch (params.aLarmType) {
      case AlarmPart.dua:
        return Right(alarmGetDatapartDataSource.getDuaAlarmPartData);
      case AlarmPart.hadith:
        return Right(alarmGetDatapartDataSource.getDuaAlarmPartData);
      case AlarmPart.dailyAzkar:
        return Right(alarmGetDatapartDataSource.getDailyAzkarAlarmPartData);
      case AlarmPart.quran:
        return Right(alarmGetDatapartDataSource.getQuranAlarmPartData);
      case AlarmPart.fast:
        return Right(alarmGetDatapartDataSource.getFastAlarmPartData);
      case AlarmPart.pray:
        return Right(alarmGetDatapartDataSource.getPrayAlarmPartData);
      default:
        throw UnimplementedError();
    }
  }

  @override
  Either<Failure, Unit> updateAlarmModel(AlarmModel alarmModel) {
    try {
      alarmGetDatapartDataSource.updateAlarmModel(alarmModel);
      return const Right(unit);
    } catch (e) {
      debugPrint(e.toString());
      return Left(JsonFailure(e.toString()));
    }
  }
}
