import 'package:flutter/material.dart';

import '../../utils/resources/app_icons.dart';

class AudioPlayPauseButton extends StatelessWidget {
  final bool isPlaying;
  final Function onPressed;
  final VoidCallback? onDone;
  const AudioPlayPauseButton({
    super.key,
    required this.isPlaying,
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
      icon: AppIcons.audioPlay,
    );
  }
}
