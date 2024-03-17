import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';
import 'package:zad_almumin/core/widget/progress_indicator/app_circular_progress_indicator.dart';
import 'package:zad_almumin/features/quran/quran.dart';
import '../../../features/home/home.dart';

class AudioPlayPauseButton extends StatelessWidget {
  final bool isSingleAudio;
  final HomeQuranAudioButtonState? stateBtn;
  final Ayah? startAyah;
  final VoidCallback? onDone;

  const AudioPlayPauseButton.multible({
    super.key,
    this.startAyah,
    this.onDone,
  })  : isSingleAudio = false,
        stateBtn = null;

  AudioPlayPauseButton.single({
    super.key,
    required this.stateBtn,
    this.onDone,
  })  : isSingleAudio = true,
        startAyah = Ayah.empty();

  @override
  Widget build(BuildContext context) {
    return isSingleAudio ? _singleAudioButton(context) : _multiAudioButton(context);
  }

  Widget _singleAudioButton(BuildContext context) {
    return BlocBuilder<HomeQuranCardCubit, HomeQuranCardState>(
      builder: (context, stateCard) {
        return _button(
          isPlaying: stateBtn is HomeQuranAudioButtonPlayingState,
          isLoading: stateBtn is HomeQuranAudioButtonLoadingState,
          onPressed: () => _singleAudioButoonPressed(context),
        );
      },
    );
  }

  Widget _multiAudioButton(BuildContext context) {
    return BlocBuilder<QuranAudioButtonCubit, QuranAudioButtonState>(
      builder: (context, buttonState) {
        return BlocBuilder<QuranReaderCubit, QuranReaderState>(
          builder: (context, state) {
            return _button(
              isPlaying: buttonState is QuranAudioButtonPlayingState,
              isLoading: false,
              onPressed: () => _multibleAudioButoonPressed(context),
            );
          },
        );
      },
    );
  }

  Widget _button({
    required bool isPlaying,
    required bool isLoading,
    required Function onPressed,
  }) {
    return IconButton(
      icon: SizedBox(
        width: AppSizes.icon,
        height: AppSizes.icon,
        child: isLoading ? const AppCircularProgressIndicator() : AppIcons.animatedPlayPause(isPlaying),
      ),
      onPressed: () => onPressed.call(),
    );
  }

  void _singleAudioButoonPressed(BuildContext context) {
    var homeQuranCardCubit = context.read<HomeQuranCardCubit>();
    HomeQuranCardState cardState = homeQuranCardCubit.state;
    QuranCardModel quranCardModel =
        cardState is HomeQuranCardLoadedState ? cardState.quranCardModel : QuranCardModel.empty();

    context.read<HomeQuranAudioButtonCubit>().playPause(
          quranCardModel: quranCardModel,
          quranReader: context.read<QuranReaderCubit>().state.selectedQuranReader,
          onComplate: () => _onComplateSingleAudio(
            context: context,
            homeQuranCardCubit: homeQuranCardCubit,
            quranCardModel: quranCardModel,
          ),
        );
    if (stateBtn is! HomeQuranAudioButtonPlayingState) {
      context.read<HomeQuranAudioProgressCubit>().updatePorgress();
    }
  }

  void _multibleAudioButoonPressed(BuildContext context) {
    var quranCubit = context.read<QuranCubit>();
    var quranAudioBtn = context.read<QuranAudioButtonCubit>();

    Ayah startAyah = this.startAyah ?? quranCubit.state.resitationSettings.startAyah;
    quranCubit.updateSelectedAyah(startAyah);

    List<Ayah> ayahs = quranCubit.getSurahByNumber(quranCubit.state.selectedAyah.surahNumber).ayahs;
    ayahs = ayahs.where((element) => element.number <= quranCubit.state.resitationSettings.endAyah.number).toList();

    int startAyahIndex = ayahs.indexOf(startAyah) - 1;

    // quranAudioBtn.currentAllPartRepeatCount = 0;

    quranAudioBtn.playPause(
      ayahs: ayahs,
      startAyahIndex: startAyahIndex,
      quranReader: context.read<QuranReaderCubit>().state.selectedQuranReader,
      onComplate: (Ayah complatedAyah, bool partEnded) => _onComplateMultiAudio(
        quranCubit: quranCubit,
        quranAudioBtn: quranAudioBtn,
        complatedAyah: complatedAyah,
        partEnded: partEnded,
      ),
    );
    onDone?.call();
  }

  void _onComplateSingleAudio({
    required BuildContext context,
    required HomeQuranCardCubit homeQuranCardCubit,
    required QuranCardModel quranCardModel,
  }) {
    context.read<HomeQuranAudioButtonCubit>().pause();
    homeQuranCardCubit.setNextAyah(
      quranCardModel.surahNumber,
      quranCardModel.ayahNumber,
    );
  }

  void _onComplateMultiAudio({
    required QuranAudioButtonCubit quranAudioBtn,
    required QuranCubit quranCubit,
    required Ayah complatedAyah,
    required bool partEnded,
  }) {
    //check if part ended
    if (partEnded) {
      //check to repeat same part
      // if (quranCubit.state.resitationSettings.isUnlimitRepeatAll) {
      //   quranCubit.updateSelectedAyah(complatedAyah);
      //   return;
      // } else if (quranCubit.state.resitationSettings.repeetAllCount > quranAudioBtn.currentAllPartRepeatCount) {
      //   quranAudioBtn.currentAllPartRepeatCount++;
      //   quranCubit.updateSelectedAyah(complatedAyah);
      //   quranCubit.updateResitationSettingsDecreaseRepeatAllCount();
      //   return;
      // }

      //end part count
      quranCubit.hideSelectedAyah();
      return;
    }

    //check to repeat same ayah
    // if (quranCubit.state.resitationSettings.isUnlimitRepeatAyah) {
    //   quranCubit.updateSelectedAyah(complatedAyah);
    //   return;
    // } else if (quranCubit.state.resitationSettings.repeetAyahCount > quranAudioBtn.currentAyahRepeatCount) {
    //   quranAudioBtn.currentAyahRepeatCount++;
    //   quranCubit.updateSelectedAyah(complatedAyah);
    //   quranCubit.updateResitationSettingsDecreaseRepeatAyahCount();
    //   return;
    // }
    // quranAudioBtn.currentAyahRepeatCount = 0;

    //update next selected ayah
    var nextAyah = quranCubit.getAyah(
      complatedAyah.surahNumber,
      (complatedAyah.number + 1),
    );
    quranCubit.updateSelectedAyah(nextAyah);

    bool isPlaying = quranCubit.isAudioPlaying;
    if (!isPlaying) return;
  }
}
