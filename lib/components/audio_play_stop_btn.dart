import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zad_almumin/classes/zikr_data.dart';
import 'package:zad_almumin/components/my_circular_progress_indecator.dart';
import 'package:zad_almumin/pages/quranPage/classes/ayah.dart';
import 'package:zad_almumin/services/audio_service.dart';

import '../constents/icons.dart';
import '../services/http_service.dart';

class AudioPlayStopBtn extends StatefulWidget {
  const AudioPlayStopBtn({Key? key, required this.zikrData, required this.onComplite, required this.autoPlay})
      : super(key: key);
  final ZikrData zikrData;
  final VoidCallback onComplite;
  final bool autoPlay;
  @override
  State<AudioPlayStopBtn> createState() => _AudioPlayStopBtnState();
}

class _AudioPlayStopBtnState extends State<AudioPlayStopBtn> with TickerProviderStateMixin {
  late AnimationController animationCtr;
  final AudioPlayer player = AudioPlayer();
  final AudioServiceCtr audioServiceCtr = Get.put(AudioServiceCtr());
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    animationCtr = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    player.onPlayerComplete.listen((event) async {
      await pauseAudio();
      widget.onComplite();
    });

    if (widget.autoPlay) startAudio();
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
      startAudio();
    else
      pauseAudio();
  }

  Future<void> startAudio() async {
    //check if the same file is playing
    if (audioServiceCtr.list.isNotEmpty) {
      //if some files are downloading
      if (isLoading) return;
      //stop the previous file
      audioServiceCtr.stopAudio();
    }
    setState(() {
      isLoading = true;
    });
     String dir = (await getApplicationDocumentsDirectory()).path;
    File? file = await HttpService.getAyah(ayah:Ayah(file: File(''), surahNumber: widget.zikrData.surahNumber, ayahNumber: widget.zikrData.ayahNumber),dir:dir, showToast: true);
    isLoading = false;
    if (mounted) setState(() {});
    if (file == null) return;
    await animationCtr.forward();
    audioServiceCtr.playAudio(MyAudioPlayer(audioPlayer: player, id: widget.zikrData.ayahNumber));
    await player.play(DeviceFileSource(file.path));
  }

  Future<void> pauseAudio() async {
    audioServiceCtr.pauseAudio();

    await animationCtr.reverse();
  }
}
