import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/utils/params/params.dart';
import '../../../../domain/usecases/home_card_play_pause_single_audio_use_case.dart';
part 'home_quran_audio_button_state.dart';

class HomeQuranAudioButtonCubit extends Cubit<HomeQuranAudioButtonState> {
  HomeQuranAudioButtonCubit({required this.playPauseSingleAudioUseCase}) : super(HomeQuranAudioButtonPauseState());
  final HomeCardPlayPauseSingleAudioUseCase playPauseSingleAudioUseCase;
  void playPause() async {
    if (state is HomeQuranAudioButtonPlayState) {
      var result = await playPauseSingleAudioUseCase.call(NoParams());

      result.fold(
        (l) {
          emit(HomeQuranAudioButtonPauseState());
          emit(HomeQuranAudioButtonFieldState(l.message));
        },
        (r) => emit(HomeQuranAudioButtonPauseState()),
      );
    } else {
      var result = await playPauseSingleAudioUseCase.call(NoParams());

      result.fold(
        (l) {
          emit(HomeQuranAudioButtonPauseState());
          emit(HomeQuranAudioButtonFieldState(l.message));
        },
        (r) => emit(HomeQuranAudioButtonPlayState()),
      );
    }
  }
}
