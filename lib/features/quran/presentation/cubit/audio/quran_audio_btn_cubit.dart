import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/enums/enums.dart';
import '../../../../../../core/utils/params/params.dart';
import '../../../quran.dart';
part 'quran_audio_btn_state.dart';

class QuranAudioButtonCubit extends Cubit<QuranAudioButtonState> {
  final QuranPlayPauseAudioUseCase playPauseAudioUseCase;
  final QuranStopAudioUseCase stopAudioUseCase;
  QuranAudioButtonCubit({required this.playPauseAudioUseCase, required this.stopAudioUseCase})
      : super(QuranAudioButtonStopedState());


  int currentAyahRepeatCount = 0;
  int currentAllPartRepeatCount = 0;


  Future<void> playPause({
    required List<Ayah> ayahs,
    required int startAyahIndex,
    required QuranReader quranReader,
    required void Function(Ayah complatedAyah, bool partEnded) onComplate,
  }) async {
    var operationSuccesState =
        state is QuranAudioButtonPlayingState ? QuranAudioButtonPausingState() : QuranAudioButtonPlayingState();

    emit(QuranAudioButtonLoadingState());

    var result = await playPauseAudioUseCase.call(
      PlayMultibleAudioParams(
          ayahs: ayahs,
          startAyahIndex: startAyahIndex,
          quranReader: quranReader,
          onComplated: (Ayah complatedAyah, bool partEnded) {
            _onComplated(
              onCmplated: () => onComplate(complatedAyah, partEnded),
              partEnded: partEnded,
            );
          }),
    );

    result.fold(
      (l) {
        // emit(QuranAudioButtonPausingState());
        emit(QuranAudioButtonFieldState(l.message));
      },
      (r) => emit(operationSuccesState),
    );
  }

  Future<void> stop() async {
    emit(QuranAudioButtonLoadingState());
    var result = await stopAudioUseCase.call(NoParams());
    result.fold(
      (l) {
        emit(QuranAudioButtonFieldState(l.message));
      },
      (r) => emit(QuranAudioButtonStopedState()),
    );
  }

  void _onComplated({required Function onCmplated, required bool partEnded}) async {
    onCmplated.call();
    if (partEnded) {
      stop();
    }
  }
}
