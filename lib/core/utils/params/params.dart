import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
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
  final AlarmPart aLarmType;

  const GetAlarmDataPartParams({required this.aLarmType});
  @override
  List<Object?> get props => [aLarmType];
}

class UpdateAlarmModelParams extends Equatable {
  final AlarmModel alarmModel;

  const UpdateAlarmModelParams({required this.alarmModel});
  @override
  List<Object?> get props => [alarmModel];
}

class GetPrayTimeParams extends Equatable {
  final Position position;
  final DateTime date;

  const GetPrayTimeParams({required this.position, required this.date});
  @override
  List<Object?> get props => [position, date];
}
