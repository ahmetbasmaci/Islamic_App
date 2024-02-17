import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/toats_helper.dart';
import '../../../../../core/widget/buttons/buttons.dart';
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
    return BlocBuilder<HomeQuranCardCubit, HomeQuranCardState>(
      builder: (context, stateCard) {
        HomeQuranCardState cardState = context.read<HomeQuranCardCubit>().state;
        QuranCardModel quranCardModel =
            cardState is HomeQuranCardLoadedState ? cardState.quranCardModel : QuranCardModel.empty();
        return AudioPlayPauseButton(
          isPlaying: stateBtn is HomeQuranAudioButtonPlayingState,
          isLoading: stateBtn is HomeQuranAudioButtonLoadingState,
          onPressed: () {
            context.read<HomeQuranAudioButtonCubit>().playPause(
                  quranCardModel: quranCardModel,
                  quranReader: context.read<QuranReaderCubit>().state.selectedQuranReader,
                  onComplate: () {
                    context.read<HomeQuranCardCubit>().getNextAyah(
                          quranCardModel.surahNumber,
                          quranCardModel.ayahNumber,
                        );
                  },
                );
            if (stateBtn is! HomeQuranAudioButtonPlayingState) {
              context.read<HomeQuranAudioProgressCubit>().updatePorgress();
            }
          },
        );
      },
    );
  }
}
