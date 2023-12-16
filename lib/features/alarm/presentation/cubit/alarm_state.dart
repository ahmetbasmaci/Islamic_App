part of 'alarm_cubit.dart';

abstract class AlarmState extends Equatable {
  const AlarmState();

  @override
  List<Object> get props => [];
}

class AlarmInitial extends AlarmState {}

class AlarmUpdatedState extends AlarmState {
  final bool isActive;

  AlarmUpdatedState(this.isActive);

  @override
  List<Object> get props => [isActive];
}
