import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zad_almumin/pages/quran/models/quran_data.dart';
import 'package:zad_almumin/services/audio_ctr.dart';
import 'package:zad_almumin/classes/zikr_data.dart';
import 'package:zad_almumin/components/my_circular_progress_indecator.dart';
import 'package:zad_almumin/pages/quran/models/ayah.dart';
import 'package:zad_almumin/pages/quran/classes/quran_helper.dart';
import 'package:zad_almumin/services/theme_service.dart';
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

class _AudioPlayStopBtnState extends State<AudioPlayStopBtn> with TickerProviderStateMixin {
  late AnimationController animationCtr;
  final AudioCtr audioBackgroundSrv = Get.find<AudioCtr>();
  final QuranData _quranData = Get.find<QuranData>();
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
          : PlayPauseAnimatedBtn(
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
        surahNumber: widget.zikrData.surahNumber, ayahNumber: widget.zikrData.ayahNumber, dir: dir, showToast: true);
    isLoading = false;
    if (mounted) setState(() {});
    if (file == null) return;
    await animationCtr.forward();

    startAudio(file.path);
  }

  void startAudio(String filePath) {
    audioBackgroundSrv.playSingleAudio(
      path: filePath,
      title: _quranData.getSurahNameByNumber(widget.zikrData.surahNumber),
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

class PlayPauseAnimatedBtn extends GetView<ThemeCtr> {
  PlayPauseAnimatedBtn({
    super.key,
    required this.animationCtr,
    required this.onTap,
  });

  AnimationController animationCtr;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    context.theme;
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: MyColors.zikrCard(),
          boxShadow: [
            BoxShadow(
              color: MyColors.black.withOpacity(.6),
              blurRadius: 5,
              offset: Offset(0, 5),
            )
          ],
        ),
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(left: 8),
        child: AnimatedIcon(icon: AnimatedIcons.play_pause, progress: animationCtr),
      ),
    );
  }
}
