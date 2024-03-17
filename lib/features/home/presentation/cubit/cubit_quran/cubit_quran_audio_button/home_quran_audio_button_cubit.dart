import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/utils/enums/enums.dart';
import '../../../../../../core/utils/params/params.dart';
import '../../../../home.dart';
part 'home_quran_audio_button_state.dart';

class HomeQuranAudioButtonCubit extends Cubit<HomeQuranAudioButtonState> {
  final HomeCardPlayPauseSingleAudioUseCase playPauseSingleAudioUseCase;
  HomeQuranAudioButtonCubit({
    required this.playPauseSingleAudioUseCase,
  }) : super(HomeQuranAudioButtonPausingState());

  void playPause({
    required QuranCardModel quranCardModel,
    required QuranReader quranReader,
    required Function onComplate,
  }) async {
    var operationSuccesState = state is HomeQuranAudioButtonPlayingState
        ? HomeQuranAudioButtonPausingState()
        : HomeQuranAudioButtonPlayingState();

    emit(HomeQuranAudioButtonLoadingState());

    var result = await playPauseSingleAudioUseCase.call(
      PlayAudioParams(
        ayahs: quranCardModel,
        quranReader: quranReader,
        onComplated: () => _onAudioComplated(onComplate),
      ),
    );

    result.fold(
      (l) {
        // emit(HomeQuranAudioButtonPausingState());
        emit(HomeQuranAudioButtonFieldState(l.message));
      },
      (r) => emit(operationSuccesState),
    );
  }

  void pause(){
    emit(HomeQuranAudioButtonPausingState());
  }
  void _onAudioComplated(Function onComplate) {
    // emit(HomeQuranAudioButtonPausingState());
    onComplate();
  }
}
