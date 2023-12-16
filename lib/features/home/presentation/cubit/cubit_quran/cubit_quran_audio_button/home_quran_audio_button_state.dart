part of 'home_quran_audio_button_cubit.dart';

abstract class HomeQuranAudioButtonState extends Equatable {
  const HomeQuranAudioButtonState();

  @override
  List<Object> get props => [];
}

class HomeQuranAudioButtonPauseState extends HomeQuranAudioButtonState {}

class HomeQuranAudioButtonPlayState extends HomeQuranAudioButtonState {}

class HomeQuranAudioButtonFieldState extends HomeQuranAudioButtonState {
  final String message;
  HomeQuranAudioButtonFieldState(this.message);
  @override
  List<Object> get props => [message];
}
