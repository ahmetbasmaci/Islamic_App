import 'package:equatable/equatable.dart';
import '../../../features/alarm/data/models/alarm_model.dart';
import '../enums/enums.dart';

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetZikrCardDataParams extends Equatable {
  ZikrCategories zikrCategory;

  GetZikrCardDataParams({required this.zikrCategory});
  @override
  List<Object?> get props => [zikrCategory];
}

class GetAlarmDataPartParams extends Equatable {
  ALarmPart aLarmType;

  GetAlarmDataPartParams({required this.aLarmType});
  @override
  List<Object?> get props => [aLarmType];
}

class UpdateAlarmModelParams extends Equatable {
  AlarmModel alarmModel;

  UpdateAlarmModelParams({required this.alarmModel});
  @override
  List<Object?> get props => [alarmModel];
}
