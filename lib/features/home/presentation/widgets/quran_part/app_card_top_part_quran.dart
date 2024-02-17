import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';
import 'package:zad_almumin/core/widget/progress_indicator/app_linear_progress_indicator.dart';
import 'package:zad_almumin/features/home/home.dart';
import 'package:zad_almumin/features/quran/quran.dart';
import '../../../../../core/extentions/extentions.dart';
import '../../../../../core/helpers/toats_helper.dart';
import '../../../../../core/widget/buttons/audio_play_pause_button.dart';
import '../../../../../core/widget/app_card_widgets/app_card_top_part.dart';
import '../../../../../src/injection_container.dart';

class AppCardTopPartQuran extends StatelessWidget {
  const AppCardTopPartQuran({
    super.key,
    required this.title,
    required this.onReferesh,
  });
  final String title;
  final Function onReferesh;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetItManager.instance.homeQuranAudioProgressCubit,
      child: BlocConsumer<HomeQuranAudioProgressCubit, HomeQuranAudioProgressState>(
        listener: (context, state) {
          if (state is HomeQuranAudioProgressErrorState) {
            ToatsHelper.showError(state.message);
          }
        },
        builder: (context, state) {
          return AppCardTopPart(
            startWidget: _refereshBtn(context),
            centerWidget: _titleAndProgress(context),
            endWidget: _audioBtn(context),
          );
        },
      ),
    );
  }

  Widget _refereshBtn(BuildContext context) {
    return RefereshBtnRounded(
      onPress: () async => onReferesh.call(),
    );
  }

  Widget _titleAndProgress(BuildContext context) {
    HomeQuranAudioProgressState progressState = context.read<HomeQuranAudioProgressCubit>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppStyles.title2,
        ),
        SizedBox(
          width: context.width * .8,
          child: AppLinearProgressIndicator(
            value: progressState.duration.inMilliseconds != 0
                ? progressState.position.inMilliseconds / progressState.duration.inMilliseconds
                : 0,
          ),
        ),
      ],
    );
  }

  Widget _audioBtn(BuildContext context) {
    return BlocProvider(
      create: (context) => GetItManager.instance.homeQuranAudioButtonCubit,
      child: BlocConsumer<HomeQuranAudioButtonCubit, HomeQuranAudioButtonState>(
        listener: (context, state) {
          if (state is HomeQuranAudioButtonFieldState) {
            ToatsHelper.showError(state.message);
          }
        },
        builder: (context, stateBtn) {
          return BlocBuilder<QuranReaderCubit, QuranReaderState>(
            builder: (context, stateReader) {
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
            },
          );
        },
      ),
    );
  }
}
