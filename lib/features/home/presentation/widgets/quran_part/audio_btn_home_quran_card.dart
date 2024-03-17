import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/widget/buttons/audio_play_pause_button.dart';

import '../../../../../core/helpers/toats_helper.dart';
import '../../../../../src/injection_container.dart';
import '../../../../quran/quran.dart';
import '../../../home.dart';

class AudioBtnHomeQuranCard extends StatelessWidget {
  const AudioBtnHomeQuranCard({super.key});

  @override
  Widget build(BuildContext context) {
    return homeQuranAudioButtonCubit(
      child: (stateBtn) {
        return quranReaderCubit(
          child: homeQuranCardCubit(
            stateBtn: stateBtn,
          ),
        );
      },
    );
  }

  Widget homeQuranAudioButtonCubit({required Widget Function(HomeQuranAudioButtonState) child}) {
    return BlocProvider(
      create: (context) => GetItManager.instance.homeQuranAudioButtonCubit,
      child: BlocConsumer<HomeQuranAudioButtonCubit, HomeQuranAudioButtonState>(
        listener: (context, state) {
          if (state is HomeQuranAudioButtonFieldState) {
            ToatsHelper.showError(state.message);
          }
        },
        builder: (context, stateBtn) {
          return child(stateBtn);
        },
      ),
    );
  }

  Widget quranReaderCubit({required Widget child}) {
    return BlocBuilder<QuranReaderCubit, QuranReaderState>(
      builder: (context, stateReader) {
        return child;
      },
    );
  }

  Widget homeQuranCardCubit({required HomeQuranAudioButtonState stateBtn}) {
    return 
    //Container();
    AudioPlayPauseButton.single(
      stateBtn: stateBtn,
    );
  }
}
