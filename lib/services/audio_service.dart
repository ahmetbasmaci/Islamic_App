import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/classes/zikr_data.dart';
import 'package:zad_almumin/pages/quranPage/controllers/quran_page_ctr.dart';

import 'package:zad_almumin/services/http_service.dart';

import '../pages/quranPage/classes/surah.dart';

// class AudioService {
//   Function setState;
//   late AnimationController animationCtr;
//   ZikrData zikrData;
//   bool isLoading = false;
//   final AudioPlayer player = AudioPlayer();
//   final AudioServiceCtr audioServiceCtr = Get.put(AudioServiceCtr());

//   AudioService(
//       {required this.animationCtr, required this.zikrData, required this.setState, required VoidCallback onComplite}) {
//     player.onPlayerComplete.listen((event) async {
//       await pauseAudio();
//       if (!zikrData.isFavorite) onComplite();
//     });
//   }
//   Future runAudio() async {
//     //check if the same file is playing
//     if (audioServiceCtr.list.isNotEmpty) {
//       //if some files are downloading
//       if (audioServiceCtr.list[0].isLoading) return;
//       //stop the previous file
//       audioServiceCtr.list[0].pauseAudio();
//     }
//     audioServiceCtr.playAudio(this, zikrData.numberInQuran);

//     isLoading = true;
//     setState();

//     File? file = await HttpService.getAyah(numberInQuran: zikrData.numberInQuran);

//     isLoading = false;
//     setState();

//     animationCtr.forward();

//     await player.play(DeviceFileSource(file!.path));
//   }

//   Future<void> pauseAudio() async {
//     audioServiceCtr.stopAudio();

//     await animationCtr.reverse();
//   }

//   Future runAllSurahAudio({required List<File?> filesList}) async {
//     //check if the same file is playing
//     if (audioServiceCtr.list.isNotEmpty) {
//       //if some files are downloading
//       if (audioServiceCtr.list[0].isLoading) return;
//       //stop the previous file
//       audioServiceCtr.list[0].pauseAudio();
//     }
//     audioServiceCtr.playAudio(this, zikrData.numberInQuran);

//     isLoading = true;
//     setState();

//     File? file = await HttpService.getAyah(numberInQuran: zikrData.numberInQuran);

//     isLoading = false;
//     setState();

//     animationCtr.forward();

//     await player.play(DeviceFileSource(file!.path));
//   }
// // Future runAudioDromDevice(){
// // String path='assets/database/quran/'
// // }
//   // Future<void> pauseAudio() async {
//   //   audioServiceCtr.stopAudio();

//   //   await animationCtr.reverse();
//   // }
// }

class AudioService {
  static final AudioServiceCtr audioServiceCtr = Get.find<AudioServiceCtr>();
  static final QuranPageCtr quranPageCtr = Get.find<QuranPageCtr>();
  final AudioPlayer player = AudioPlayer();
  static late Surah nextSurah;
  static Surah currentSurah = Surah(file: File(''), numberInQuran: 0);
  static bool isSurahEnd = false;
  static List<Surah> surahList = [];
  VoidCallback? onPause;

  AudioService({this.onPause}) {
    player.onPlayerComplete.listen((event) async {
      if (isSurahEnd) {
        await stopAudio();
      } else {
        currentSurah = nextSurah;
        playAudio();
      }
    });
  }

  playAudio() async {
    if (audioServiceCtr.list.isNotEmpty) {
      audioServiceCtr.pauseAudio();
    }
    if (surahList.last.numberInQuran == currentSurah.numberInQuran)
      isSurahEnd = true;
    else
      nextSurah = surahList.firstWhere((element) => element.numberInQuran == currentSurah.numberInQuran + 1);

    audioServiceCtr.playAudio(MyAudioPlayer(audioPlayer: player, id: currentSurah.numberInQuran));

    try {
      bool exsist = await currentSurah.file.exists();
      if (exsist)
        await player.play(DeviceFileSource(currentSurah.file.path));
      else{
        Fluttertoast.showToast(msg: 'حدث خطأ أثناء تشغيل الصوت');
      stopAudio();}
    } catch (e) {
      Fluttertoast.showToast(msg: 'حدث خطأ أثناء تشغيل الصوت');
    }
  }

  playSurahAudio(List<Surah> list) async {
    if (list.isEmpty) return;

    bool isNewSurah = currentSurah.numberInQuran == 0;
    if (isNewSurah) {
      surahList.clear();
      isSurahEnd = false;
      if (quranPageCtr.startNum.value > list.length) quranPageCtr.startNum.value = list.length;
      if (quranPageCtr.endNum.value > list.length) quranPageCtr.endNum.value = list.length;
      for (var i = quranPageCtr.startNum.value - 1; i <= quranPageCtr.endNum.value - 1; i++) surahList.add(list[i]);
      currentSurah = surahList.first;
    }
    playAudio();
  }

  pauseAudio() {
    if (onPause != null) onPause!();

    audioServiceCtr.pauseAudio();
  }

  stopAudio() {
    if (onPause != null) onPause!();
    currentSurah.numberInQuran = 0;
    audioServiceCtr.stopAudio();
  }
}

class AudioServiceCtr extends GetxController {
  RxBool isAudioPlaying = false.obs;
  RxList<MyAudioPlayer> list = <MyAudioPlayer>[].obs;
  // RxInt currentPlayingAyahNumber = 0.obs;
  void playAudio(MyAudioPlayer newPlayer) {
    isAudioPlaying.value = true;
    list.add(newPlayer);
  }

  void stopAudio() {
    isAudioPlaying.value = false;
    if (list.isEmpty) return;
    list.forEach((element) {
      element.audioPlayer.stop();
    });
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
