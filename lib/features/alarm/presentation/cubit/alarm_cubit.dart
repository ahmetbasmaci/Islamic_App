import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/params/params.dart';
import '../../data/models/alarm_part_model.dart';
import '../../domain/usecases/get_alarm_part_data_use_case.dart';

import '../../data/models/alarm_model.dart';

part 'alarm_state.dart';

class AlarmCubit extends Cubit<AlarmState> {
  final GetAlarmPartDataUseCase getAlarmPartDataUseCase;
  AlarmCubit({required this.getAlarmPartDataUseCase}) : super(AlarmInitial());
  AlarmPartModel? _duaAlarmPart;
  AlarmPartModel? _hadithAlarmPart;
  AlarmPartModel? _dailyAzkarAlarmPart;
  AlarmPartModel? _quranAlarmPart;
  AlarmPartModel? _fastAlarmPart;
  AlarmPartModel? _prayAlarmPart;
  AlarmPartModel getAlarmPart(ALarmType aLarmType) {
    if (aLarmType == ALarmType.dua && _duaAlarmPart != null) return _duaAlarmPart!;
    if (aLarmType == ALarmType.hadith && _duaAlarmPart != null) return _hadithAlarmPart!;
    if (aLarmType == ALarmType.dailyAzkar && _dailyAzkarAlarmPart != null) return _dailyAzkarAlarmPart!;
    if (aLarmType == ALarmType.quran && _quranAlarmPart != null) return _quranAlarmPart!;
    if (aLarmType == ALarmType.fast && _fastAlarmPart != null) return _fastAlarmPart!;
    if (aLarmType == ALarmType.pray && _prayAlarmPart != null) return _prayAlarmPart!;

    var result = getAlarmPartDataUseCase.call(
      GetAlarmDataPartParams(aLarmType: aLarmType),
    );

    return result;
  }

  void triggerAlarmActive(AlarmModel alarmModel) {
    alarmModel.isActive = !alarmModel.isActive;

    emit(AlarmUpdatedState(alarmModel.isActive));
  }
}
