import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/classes/zikr_data.dart';

import 'package:zad_almumin/services/http_service.dart';

class AudioService {
  Function setState;
  late AnimationController animationCtr;
  ZikrData zikrData;
  bool isLoading = false;
  final AudioPlayer player = AudioPlayer();
  final AudioServiceCtr audioServiceCtr = Get.put(AudioServiceCtr());

  AudioService(
      {required this.animationCtr, required this.zikrData, required this.setState, required VoidCallback onComplite}) {
    player.onPlayerComplete.listen((event) async {
      await pauseAudio();
      if (!zikrData.isFavorite) onComplite();
    });
  }
  Future runAudio() async {
    //check if the same file is playing
    if (audioServiceCtr.list.isNotEmpty) {
      //if some files are downloading
      if (audioServiceCtr.list[0].isLoading) return;
      //stop the previous file
      audioServiceCtr.list[0].pauseAudio();
    }
    audioServiceCtr.playAudio(this, zikrData.numberInQuran);

    isLoading = true;
    setState();

    File file = await HttpService.getAyah(numberInQuran: zikrData.numberInQuran);

    isLoading = false;
    setState();

    animationCtr.forward();

    await player.play(DeviceFileSource(file.path));
  }

  Future<void> pauseAudio() async {
    audioServiceCtr.stopAudio();

    await animationCtr.reverse();
  }
}

class AudioServiceCtr extends GetxController {
  RxBool isAudioPlaying = false.obs;
  RxList<AudioService> list = <AudioService>[].obs;

  void playAudio(AudioService newPlayer, int newId) {
    list.add(newPlayer);
    isAudioPlaying.value = true;
  }

  void stopAudio() {
    isAudioPlaying.value = false;
    if (list.isEmpty) return;
    list[0].player.pause();
    list.removeAt(0);
  }

  void stopAudioById(int id) {
    if (list.isEmpty) return;
    if (list[0].zikrData.numberInQuran == id) stopAudio();
  }
}
