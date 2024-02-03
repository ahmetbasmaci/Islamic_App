part of 'app_developer_cubit.dart';

abstract class AppDeveloperState extends Equatable {
  const AppDeveloperState();

  @override
  List<Object> get props => [];
}

class AppDeveloperInitialState extends AppDeveloperState {}

class AppDeveloperErrorMessage extends AppDeveloperState {
  final String message;
  final DateTime time;
  AppDeveloperErrorMessage(this.message) : time = DateTime.now();

  @override
  List<Object> get props => [message, time];
}

class AppDeveloperLoadingState extends AppDeveloperState {}

class AppDeveloperSuccesState extends AppDeveloperState {}
