import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';
import 'package:zad_almumin/core/widget/buttons/audio_play_pause_button.dart';
import '../../../../../core/helpers/dialogs_helper.dart';
import '../../../quran.dart';

class QuranFooterButtonsPart extends StatelessWidget {
  const QuranFooterButtonsPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _settingButton(context),
        _playPauseButton(context),
        _stopButton(),
        _swichQuranTafseerButton(context),
      ],
    );
  }

  Widget _swichQuranTafseerButton(BuildContext context) {
    return _button(
      toolTipMessage: 'التنقل بين القران والتفسير',
      icon: AppIcons.animatedQuranTafseerView(context.read<QuranCubit>().state.showTafseerPage),
      onPressed: () => context.read<QuranCubit>().changeShowTafseerPage(),
    );
  }

  Widget _stopButton() {
    return BlocBuilder<QuranAudioButtonCubit, QuranAudioButtonState>(
      builder: (context, buttonState) {
        return _button(
          icon: AppIcons.animatedStop(buttonState is QuranAudioButtonStopedState),
          onPressed: () {
            context.read<QuranAudioButtonCubit>().stop();
          },
        );
      },
    );
  }

  Widget _playPauseButton(BuildContext context) {
    return const AudioPlayPauseButton.multible();
  }

  Widget _settingButton(BuildContext context) {
    return _button(
      icon: AppIcons.settings,
      onPressed: () async => showResitationSettingsDialog(context),
    );
  }

  Widget _button({required Widget icon, required Function() onPressed, String? toolTipMessage}) {
    return Tooltip(
      message: toolTipMessage ?? '',
      child: IconButton(
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }

  void showResitationSettingsDialog(BuildContext context) {
    DialogsHelper.showCostumDialog(
      context: context,
      title: Text('اعدادات القراءة', style: AppStyles.contentBold),
      child: const QuranFooterResitationSettingsBody(),
    );
  }
}
