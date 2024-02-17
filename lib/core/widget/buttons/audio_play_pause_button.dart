import 'package:flutter/material.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';
import 'package:zad_almumin/core/widget/progress_indicator/app_circular_progress_indicator.dart';

class AudioPlayPauseButton extends StatelessWidget {
  final bool isPlaying;
  final bool isLoading;
  final Function onPressed;
  final VoidCallback? onDone;
  const AudioPlayPauseButton({
    super.key,
    required this.isPlaying,
    required this.isLoading,
    required this.onPressed,
    this.onDone,
  });
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onPressed.call();
        onDone?.call();
      },
      icon: getIcon,
    );
  }

  Widget get getIcon {
    Widget icon = AppIcons.audioPlay;

    if (isLoading) icon = const AppCircularProgressIndicator();
    if (isPlaying) icon = AppIcons.audioPause;

    return SizedBox(
      height: AppSizes.icon,
      width: AppSizes.icon,
      child: icon,
    );
  }
}
