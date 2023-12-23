import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zad_almumin/features/alarm/domain/usecases/update_alarm_model_use_case.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/params/params.dart';
import '../../../pray_times/data/models/time.dart';
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
  AlarmPartModel getAlarmPart(AlarmPart aLarmType) {
    if (aLarmType == AlarmPart.dua && _duaAlarmPart != null) return _duaAlarmPart!;
    if (aLarmType == AlarmPart.hadith && _duaAlarmPart != null) return _hadithAlarmPart!;
    if (aLarmType == AlarmPart.dailyAzkar && _dailyAzkarAlarmPart != null) return _dailyAzkarAlarmPart!;
    if (aLarmType == AlarmPart.quran && _quranAlarmPart != null) return _quranAlarmPart!;
    if (aLarmType == AlarmPart.fast && _fastAlarmPart != null) return _fastAlarmPart!;
    if (aLarmType == AlarmPart.pray && _prayAlarmPart != null) return _prayAlarmPart!;

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

  void updateAlarmTime(PeriodicAlarmModel alarmModel, Time time) {
    alarmModel.time = time;
    updateAlarmModel(alarmModel);
  }

  void updateAlarmRepeated(RepeatedAlarmModel alarmModel, RepeatAlarmType newValue) {
    alarmModel.repeatAlarmType = newValue;
    updateAlarmModel(alarmModel);
  }
}
