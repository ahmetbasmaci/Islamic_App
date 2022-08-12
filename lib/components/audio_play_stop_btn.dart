import 'package:flutter/material.dart';
import 'package:zad_almumin/classes/zikr_data.dart';
import 'package:zad_almumin/components/my_circular_progress_indecator.dart';
import 'package:zad_almumin/services/audio_service.dart';

import '../constents/icons.dart';

class AudioPlayStopBtn extends StatefulWidget {
  const AudioPlayStopBtn({Key? key, required this.zikrData, required this.onComplite}) : super(key: key);
  final ZikrData zikrData;
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
      zikrData: widget.zikrData,
      setState: () => setState(() {}),
      onComplite: () => widget.onComplite.call(),
    );
  }

  @override
  Widget build(BuildContext context) {
    updateAudioServerObject();
    return AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
        child: audioService.isLoading
            ? MyCircularProgressIndecator()
            : MyIcons.animatedIcon_Play_Pause(
                animationCtr: animationCtr,
                onTap: widget.zikrData.numberInQuran == 0 ? () {} : onPlayTap,
                isForwerd: !widget.zikrData.isRandomAyah,
              ));
  }

  updateAudioServerObject() {
    if (widget.zikrData.numberInQuran == 0) {
      audioService = AudioService(
        animationCtr: animationCtr,
        zikrData: widget.zikrData,
        setState: () => setState(() {}),
        onComplite: () {
          widget.onComplite();
        },
      );
    } else {
      audioService.zikrData = widget.zikrData;
      if (audioService.isLoading == false && animationCtr.isDismissed && widget.zikrData.isRandomAyah == false)
        onPlayTap();
    }
  }

  onPlayTap() async {
    if (animationCtr.isDismissed)
      await audioService.runAudio();
    else
      audioService.pauseAudio();
  }
}
