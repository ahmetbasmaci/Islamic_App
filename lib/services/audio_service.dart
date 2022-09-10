import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/pages/quran/controllers/quran_page_ctr.dart';
import '../pages/quran/classes/ayah.dart';

class AudioService {
  static final AudioServiceCtr audioServiceCtr = Get.find<AudioServiceCtr>();
  static final QuranPageCtr quranCtr = Get.find<QuranPageCtr>();
  final AudioPlayer player = AudioPlayer();
  static late Ayah nextSurah;
  static Ayah currentAyah = Ayah(file: File(''), surahNumber: 0, ayahNumber: 0);
  static bool isSurahEnd = false;
  static List<Ayah> surahList = [];
  VoidCallback? onPause;

  AudioService({this.onPause}) {
    player.onPlayerComplete.listen((event) async {
      if (isSurahEnd) {
        await stopAudio();
      } else {
        currentAyah = nextSurah;
        playAudio();
      }
    });
  }

  playAudio() async {
    if (audioServiceCtr.list.isNotEmpty) audioServiceCtr.pauseAudio();

    if (surahList.last.ayahNumber == currentAyah.ayahNumber)
      isSurahEnd = true;
    else
      nextSurah = surahList.firstWhere((element) => element.ayahNumber == (currentAyah.ayahNumber + 1));

    audioServiceCtr.playAudio(MyAudioPlayer(audioPlayer: player, id: currentAyah.ayahNumber));

    try {
      bool exsist = await currentAyah.file.exists();
      if (exsist) 
        await player.play(DeviceFileSource(currentAyah.file.path));
      else {
        Fluttertoast.showToast(msg: 'حدث خطأ أثناء تشغيل الصوت');
        stopAudio();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'حدث خطأ أثناء تشغيل الصوت');
    }
  }

  playSurahAudio(List<Ayah> list) async {
    if (list.isEmpty) return;

    bool isNewSurah = currentAyah.ayahNumber == 0;
    if (isNewSurah) {
      surahList.clear();
      isSurahEnd = false;
      //some check for selected start and end ayahs of surah
      if (quranCtr.selectedSurah.startAyahNum.value > list.length)
        quranCtr.selectedSurah.startAyahNum.value = list.length;
      if (quranCtr.selectedSurah.endAyahNum.value > list.length) quranCtr.selectedSurah.endAyahNum.value = list.length;

      for (var i = quranCtr.selectedSurah.startAyahNum.value - 1; i <= quranCtr.selectedSurah.endAyahNum.value - 1; i++)
        surahList.add(list[i]);
      currentAyah = surahList.first;
    }
    playAudio();
  }

  pauseAudio() {
    if (onPause != null) onPause!();

    audioServiceCtr.pauseAudio();
  }

  stopAudio() {
    if (onPause != null) onPause!();
    currentAyah.ayahNumber = 0;
    audioServiceCtr.stopAudio();
  }
}

class AudioServiceCtr extends GetxController {
  RxBool isAudioPlaying = false.obs;
  RxList<MyAudioPlayer> list = <MyAudioPlayer>[].obs;
  void playAudio(MyAudioPlayer newPlayer) {
    isAudioPlaying.value = true;
    list.add(newPlayer);
  }

  void stopAudio() {
    isAudioPlaying.value = false;
    if (list.isEmpty) return;
    for (var element in list) element.audioPlayer.stop();

    list.removeAt(0);
  }

  void pauseAudio() {
    isAudioPlaying.value = false;
    if (list.isEmpty) return;
    list[0].audioPlayer.pause();
    list.removeAt(0);
  }

  void stopAudioById(int id) {
    if (list.isEmpty) return;
    if (list[0].id == id) stopAudio();
  }
}

class MyAudioPlayer {
  MyAudioPlayer({required this.audioPlayer, required this.id});
  AudioPlayer audioPlayer;
  int id;
}
