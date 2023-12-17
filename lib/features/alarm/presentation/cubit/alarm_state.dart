part of 'alarm_cubit.dart';

abstract class AlarmState extends Equatable {
  const AlarmState();

  @override
  List<Object> get props => [];
}

class AlarmInitial extends AlarmState {}

class AlarmUpdatedState extends AlarmState {
  final AlarmModel alarmModel;
  List<dynamic> modelProps = [];
  AlarmUpdatedState(this.alarmModel)
      : modelProps = [
          alarmModel.alarmType,
          alarmModel.isActive,
          alarmModel.title,
          alarmModel is PeriodicAlarmModel ? alarmModel.time : null,
          alarmModel is RepeatedAlarmModel ? alarmModel.repeatAlarmType : null,
        ];

  @override
  List<Object> get props => [modelProps];
}
