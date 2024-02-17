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
            endWidget:AudioBtnHomeQuranCard(),
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

}
