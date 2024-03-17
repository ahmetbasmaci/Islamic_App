part of 'quran_audio_btn_cubit.dart';

abstract class QuranAudioButtonState extends Equatable {
  const QuranAudioButtonState();

  @override
  List<Object> get props => [];
}

class QuranAudioButtonPausingState extends QuranAudioButtonState {}
class QuranAudioButtonStopedState extends QuranAudioButtonState {}

class QuranAudioButtonPlayingState extends QuranAudioButtonState {}

class QuranAudioButtonFieldState extends QuranAudioButtonState {
  final String message;
  const QuranAudioButtonFieldState(this.message);
  @override
  List<Object> get props => [];
}

class QuranAudioButtonLoadingState extends QuranAudioButtonState {}
