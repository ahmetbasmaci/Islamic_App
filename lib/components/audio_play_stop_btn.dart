import 'dart:io';
import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zad_almumin/constents/icons.dart';
import 'package:zad_almumin/constents/sizes.dart';
import 'package:zad_almumin/pages/quran/models/quran_data.dart';
import 'package:zad_almumin/services/audio_ctr.dart';
import 'package:zad_almumin/classes/zikr_data.dart';
import 'package:zad_almumin/components/my_circular_progress_indecator.dart';
import '../constents/colors.dart';
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

class _AudioPlayStopBtnState extends State<AudioPlayStopBtn>  {

  final AudioCtr _audioCtr = Get.find<AudioCtr>();
  final QuranData _quranData = Get.find<QuranData>();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    if (widget.autoPlay) handleAudio();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      color: MyColors.zikrCard(),
      width: MySiezes.icon * 1.3,
      height: MySiezes.icon * 1.3,
      onPressed: () => onPlayTap(),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
        child: isLoading ? MyCircularProgressIndecator() : MyIcons.animated_Play_Pause(),
      ),
    );
  }

  onPlayTap() {
    if (_audioCtr.isPlaying.value)
      _audioCtr.pauseAudio();
    else
      handleAudio();
  }

  Future<void> handleAudio() async {
    setState(() {
      isLoading = true;
    });
    String dir = (await getApplicationDocumentsDirectory()).path;
    File? file = await HttpService.getAyah(
        surahNumber: widget.zikrData.surahNumber, ayahNumber: widget.zikrData.ayahNumber, dir: dir, showToast: true);
    isLoading = false;
    if (mounted) setState(() {});
    if (file == null) return;

    startAudio(file.path);
  }

  void startAudio(String filePath) {
    _audioCtr.playSingleAudio(
      path: filePath,
      title: _quranData.getSurahNameByNumber(widget.zikrData.surahNumber),
      desc: widget.zikrData.ayahNumber.toString(),
      onEnded: widget.onComplite,
    );
  }
}
