import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zad_almumin/features/alarm/domain/usecases/update_alarm_model_use_case.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/params/params.dart';
import '../../data/models/alarm_part_model.dart';
import '../../domain/usecases/get_alarm_part_data_use_case.dart';

import '../../data/models/alarm_model.dart';

part 'alarm_state.dart';

class AlarmCubit extends Cubit<AlarmState> {
  final GetAlarmPartDataUseCase _getAlarmPartDataUseCase;
  final UpdateAlarmModelUseCase _updateAlarmModelUseCase;
  AlarmCubit({
    required GetAlarmPartDataUseCase getAlarmPartDataUseCase,
    required UpdateAlarmModelUseCase triggerAlarmActivatingUseCase,
  })  : _updateAlarmModelUseCase = triggerAlarmActivatingUseCase,
        _getAlarmPartDataUseCase = getAlarmPartDataUseCase,
        super(AlarmInitial());
  AlarmPartModel? _duaAlarmPart;
  AlarmPartModel? _hadithAlarmPart;
  AlarmPartModel? _dailyAzkarAlarmPart;
  AlarmPartModel? _quranAlarmPart;
  AlarmPartModel? _fastAlarmPart;
  AlarmPartModel? _prayAlarmPart;
  AlarmPartModel getAlarmPart(ALarmPart aLarmType) {
    if (aLarmType == ALarmPart.dua && _duaAlarmPart != null) return _duaAlarmPart!;
    if (aLarmType == ALarmPart.hadith && _duaAlarmPart != null) return _hadithAlarmPart!;
    if (aLarmType == ALarmPart.dailyAzkar && _dailyAzkarAlarmPart != null) return _dailyAzkarAlarmPart!;
    if (aLarmType == ALarmPart.quran && _quranAlarmPart != null) return _quranAlarmPart!;
    if (aLarmType == ALarmPart.fast && _fastAlarmPart != null) return _fastAlarmPart!;
    if (aLarmType == ALarmPart.pray && _prayAlarmPart != null) return _prayAlarmPart!;

    var result = _getAlarmPartDataUseCase.call(
      GetAlarmDataPartParams(aLarmType: aLarmType),
    );

    return result;
  }

  void updateAlarmModel(AlarmModel alarmModel) {
    _updateAlarmModelUseCase.call(UpdateAlarmModelParams(alarmModel: alarmModel));
    emit(AlarmUpdatedState(alarmModel));
  }

  void triggerAlarmActivation(AlarmModel alarmModel) {
    alarmModel.isActive = !alarmModel.isActive;
    updateAlarmModel(alarmModel);
  }

  void updateAlarmTime(PeriodicAlarmModel alarmModel, TimeOfDay time) {
    alarmModel.time = time;
    updateAlarmModel(alarmModel);
  }

  void updateAlarmRepeated(RepeatedAlarmModel alarmModel, RepeatAlarmType newValue) {
    alarmModel.repeatAlarmType = newValue;
    updateAlarmModel(alarmModel);
  }
}
