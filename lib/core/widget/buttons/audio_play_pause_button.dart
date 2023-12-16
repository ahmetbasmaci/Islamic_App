import 'package:flutter/material.dart';

import '../../utils/resources/app_icons.dart';

class AudioPlayPauseButton extends StatelessWidget {
  const AudioPlayPauseButton({
    super.key,
    required this.isPlaying,
    required this.onPressed,
  });
  final bool isPlaying;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async => onPressed.call(),
      icon: AppIcons.audioPlay,
    );
  }
}
