import 'package:flutter/material.dart';
import 'package:zad_almumin/components/my_circular_progress_indecator.dart';
import 'package:zad_almumin/services/audio_service.dart';

import '../constents/icons.dart';

class AudioPlayStopBtn extends StatefulWidget {
  const AudioPlayStopBtn(
      {Key? key, required this.numberInQuran, required this.fileName, required this.fileType, required this.onComplite})
      : super(key: key);
  final int numberInQuran;
  final String fileName;
  final String fileType;
  final VoidCallback onComplite;
  @override
  State<AudioPlayStopBtn> createState() => _AudioPlayStopBtnState();
}

class _AudioPlayStopBtnState extends State<AudioPlayStopBtn> with TickerProviderStateMixin {
  late AudioService audioService;
  late AnimationController animationCtr;
  @override
  void initState() {
    super.initState();
    animationCtr = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    audioService = AudioService(
      animationCtr: animationCtr,
      setState: () => setState(() {}),
      onComplite: () async {
        widget.onComplite();
        onPlayTap();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
        child: audioService.isLoading
            ? MyCircularProgressIndecator()
            : MyIcons.animatedIcon_Play_Pause(
                animationCtr: animationCtr,
                onTap: onPlayTap,
              ));
  }

  onPlayTap() async {
    if (animationCtr.isDismissed) {
      await audioService.runAudio(
          numberInQuran: widget.numberInQuran, fileName: widget.fileName, fileType: widget.fileType);
    } else {
      audioService.pauseAudio();
    }
  }
}
