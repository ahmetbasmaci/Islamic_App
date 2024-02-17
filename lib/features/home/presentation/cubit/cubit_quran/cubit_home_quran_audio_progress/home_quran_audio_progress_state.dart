part of 'home_quran_audio_progress_cubit.dart';

class HomeQuranAudioProgressState extends Equatable {
  final Duration position;
  final Duration duration;
  const HomeQuranAudioProgressState({
    required this.position,
    required this.duration,
  });

  HomeQuranAudioProgressState copyWith({
    Duration? position,
  }) {
    return HomeQuranAudioProgressState(
      position: position ?? this.position,
      duration: duration,
    );
  }

  @override
  List<Object> get props => [position, duration];
}

class HomeQuranAudioProgressErrorState extends HomeQuranAudioProgressState {
  final String message;
  const HomeQuranAudioProgressErrorState(this.message) : super(position: Duration.zero, duration: Duration.zero);
  @override
  List<Object> get props => [message];
}
