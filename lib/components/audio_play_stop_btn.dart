import 'dart:io';
import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zad_almumin/constents/my_icons.dart';
import 'package:zad_almumin/constents/my_sizes.dart';
import 'package:zad_almumin/pages/quran/models/quran_data.dart';
import 'package:zad_almumin/services/audio_ctr.dart';
import 'package:zad_almumin/classes/zikr_data.dart';
import 'package:zad_almumin/components/my_circular_progress_indecator.dart';
import 'package:zad_almumin/services/theme_service.dart';
import '../constents/my_colors.dart';
import '../services/http_service.dart';

class AudioPlayStopBtn extends GetView<ThemeCtr> {
  AudioPlayStopBtn({Key? key, required this.zikrData, required this.onComplite, required this.autoPlay})
      : super(key: key);
  final AudioCtr _audioCtr = Get.find<AudioCtr>();
  final QuranData _quranData = Get.find<QuranData>();
  final ZikrData zikrData;
  final VoidCallback onComplite;
  final bool autoPlay;
  @override
  Widget build(BuildContext context) {
    context.theme;
    return FutureBuilder<String>(
        future: autoPlay ? handleAudio() : Future.delayed(Duration(seconds: 0)).then((value) => ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return SizedBox(height: MySiezes.icon, width: MySiezes.icon, child: MyCircularProgressIndecator());
          else if (snapshot.hasError || snapshot.data == 'null')
            return Text(snapshot.error.toString());
          else {
            String path = snapshot.data as String;
            if (path != '') startAudio(path);
            return AnimatedButton(
              color: MyColors.zikrCard(),
              width: MySiezes.btnIcon,
              height: MySiezes.btnIcon,
              onPressed: () => onPlayTap(),
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                child: MyIcons.animated_Play_Pause(),
              ),
            );
          }
        });
  }

  onPlayTap() async {
    if (_audioCtr.isPlaying.value)
      _audioCtr.pauseAudio();
    else {
      String path = await handleAudio();
      startAudio(path);
    }
  }

  Future<String> handleAudio() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File? file = await HttpService.getAyah(
        surahNumber: zikrData.surahNumber, ayahNumber: zikrData.ayahNumber, dir: dir, showToast: true);

    if (file == null) return 'null';
    return file.path;
  }

  void startAudio(String filePath) {
    _audioCtr.playSingleAudio(
      path: filePath,
      title: _quranData.getSurahNameByNumber(zikrData.surahNumber),
      desc: zikrData.ayahNumber.toString(),
      onEnded: onComplite,
    );
  }
}
