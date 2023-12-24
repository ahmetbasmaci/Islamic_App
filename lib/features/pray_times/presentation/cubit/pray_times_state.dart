part of 'pray_times_cubit.dart';

class PrayTimesState extends Equatable {
  final CurrentDayPrayDetailesModel currentDayPrayDetailesModel;
  final String timeLeftToNextPrayTime;
  final String errorMessage;
  final bool isLoading;
  PrayTimesState({
    required this.currentDayPrayDetailesModel,
    required this.timeLeftToNextPrayTime,
    required this.errorMessage,
    required this.isLoading,
  });

  PrayTimesState.initial()
      : currentDayPrayDetailesModel = CurrentDayPrayDetailesModel.empty(),
        timeLeftToNextPrayTime = '00:00:00',
        errorMessage = '',
        isLoading = false;

  PrayTimesState copyWith({
    CurrentDayPrayDetailesModel? currentDayPrayDetailesModel,
    String? timeLeftToNextPrayTime,
    String? errorMessage,
    bool? isLoading,
  }) {
    return PrayTimesState(
      currentDayPrayDetailesModel: currentDayPrayDetailesModel ?? this.currentDayPrayDetailesModel,
      timeLeftToNextPrayTime: timeLeftToNextPrayTime ?? this.timeLeftToNextPrayTime,
      errorMessage: errorMessage ?? '',
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [currentDayPrayDetailesModel, timeLeftToNextPrayTime, errorMessage, isLoading];
}
