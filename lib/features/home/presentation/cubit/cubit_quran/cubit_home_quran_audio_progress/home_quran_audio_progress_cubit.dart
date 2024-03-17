import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/utils/params/params.dart';
import '../../../../home.dart';

part 'home_quran_audio_progress_state.dart';

class HomeQuranAudioProgressCubit extends Cubit<HomeQuranAudioProgressState> {
  final HomeCardAudioPorgressUseCase homeCardAudioPorgressUseCase;

  HomeQuranAudioProgressCubit({required this.homeCardAudioPorgressUseCase})
      : super(const HomeQuranAudioProgressState(duration: Duration.zero, position: Duration.zero));

  Future<void> updatePorgress() async {
    var result = await homeCardAudioPorgressUseCase.call(NoParams());
    result.fold(
      (l) => emit(HomeQuranAudioProgressErrorState(l.message)),
      (audioStreamModel) {
        audioStreamModel.position.listen(
          (event) {
            //TODO
            print('-----------------------------------------------${event.inMilliseconds}');
            emit(HomeQuranAudioProgressState(duration: audioStreamModel.duration, position: event));
          },
        );
      },
    );
  }
}
