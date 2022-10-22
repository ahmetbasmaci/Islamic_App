import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zad_almumin/audio_background_service.dart';
import 'package:zad_almumin/classes/zikr_data.dart';
import 'package:zad_almumin/components/my_circular_progress_indecator.dart';
import 'package:zad_almumin/pages/quran/classes/ayah.dart';
import 'package:zad_almumin/pages/quran/classes/quran_helper.dart';

import '../constents/icons.dart';
import '../services/http_service.dart';

class AudioPlayStopBtn extends StatefulWidget {
  AudioPlayStopBtn({Key? key, required this.zikrData, required this.onComplite, required this.autoPlay})
      : super(key: key);
  final ZikrData zikrData;
  final VoidCallback onComplite;
  final bool autoPlay;

  @override
  State<AudioPlayStopBtn> createState() => _AudioPlayStopBtnState();
}

class _AudioPlayStopBtnState extends State<AudioPlayStopBtn> with TickerProviderStateMixin {
  late AnimationController animationCtr;
  final AudioBacgroundService audioBackgroundSrv = Get.find<AudioBacgroundService>();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    animationCtr = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    // player.onPlayerComplete.listen((event) async {
    //   await pauseAudio();
    //   widget.onComplite();
    // });

    if (widget.autoPlay) handleAudio();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
      child: isLoading
          ? MyCircularProgressIndecator()
          : MyIcons.animatedIcon_Play_Pause(
              animationCtr: animationCtr,
              onTap: () => onPlayTap(),
            ),
    );
  }

  onPlayTap() {
    if (animationCtr.isDismissed)
      handleAudio();
    else
      pauseAudio();
  }

  Future<void> handleAudio() async {
    setState(() {
      isLoading = true;
    });
    String dir = (await getApplicationDocumentsDirectory()).path;
    File? file = await HttpService.getAyah(
        ayah: Ayah(file: File(''), surahNumber: widget.zikrData.surahNumber, ayahNumber: widget.zikrData.ayahNumber),
        dir: dir,
        showToast: true);
    isLoading = false;
    if (mounted) setState(() {});
    if (file == null) return;
    await animationCtr.forward();

    startAudio(file.path);
  }

  void startAudio(String filePath) {
    audioBackgroundSrv.playSingleAudio(
      path: filePath,
      title: QuranHelper().getSurahNameByNumber(widget.zikrData.surahNumber),
      desc: widget.zikrData.ayahNumber.toString(),
      onEnded: widget.onComplite,
      onStop: () => reverseAnimation(),
      onStart: () => forwardAnimation(),
    );
  }

  Future pauseAudio() async {
    audioBackgroundSrv.pauseAudio();
  }

  Future reverseAnimation() async {
    await animationCtr.reverse();
  }

  Future forwardAnimation() async {
    await animationCtr.forward();
  }
}
