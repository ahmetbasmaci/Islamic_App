import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/extentions/extentions.dart';
import '../../../../../core/helpers/toats_helper.dart';
import '../../../../../core/utils/resources/app_styles.dart';
import '../../../../../core/widget/buttons/audio_play_pause_button.dart';

import '../../../../../core/widget/app_card_widgets/app_card_top_part.dart';
import '../../../../../src/injection_container.dart';
import '../../cubit/cubit_quran/cubit_quran_audio_button/home_quran_audio_button_cubit.dart';
import '../referesh_btn_rounded.dart';

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
    return AppCardTopPart(
      startWidget: _refereshBtn(context),
      centerWidget: _titleAndProgress(context),
      endWidget: _audioBtn(context),
    );
  }

  Widget _refereshBtn(BuildContext context) {
    return RefereshBtnRounded(
      onPress: () async => onReferesh.call(),
    );
  }

  Widget _titleAndProgress(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppStyles.title2,
        ),
        SizedBox(
          width: context.width * .8,
          child: LinearProgressIndicator(
            value: .5, // audioCtr.slider.value,
            valueColor: AlwaysStoppedAnimation<Color>(context.themeColors.primary),
            backgroundColor: context.themeColors.background,
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
        builder: (context, state) {
          return AudioPlayPauseButton(
            isPlaying: state is HomeQuranAudioButtonPlayState,
            onPressed: () => context.read<HomeQuranAudioButtonCubit>().playPause(),
          );
        },
      ),
    );
  }
}
