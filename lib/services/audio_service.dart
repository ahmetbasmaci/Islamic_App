import 'dart:io';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class AudioService {
  AudioService({required this.animationCtr, required this.setState}) {
    player.onPlayerComplete.listen((event) {
      pauseAudio();
    });
  }

  VoidCallback setState;
  late AnimationController animationCtr;
  bool isLoading = false;
  final AudioPlayer player = AudioPlayer();
  int playerId = 0;
  final AudioServiceCtr audioServiceCtr = Get.put(AudioServiceCtr());
  void setAudioStreams({VoidCallback? onPlayerComplete}) {}

  Future<File?> downloadFile({required String url, required String fileName, required String fileType}) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$fileName.$fileType');
    bool exists = await file.exists();
    if (exists) return file;

    http.Response request = await http.get(Uri.parse(url)); //downlaod the file
    Uint8List bytes = request.bodyBytes; //close();
    await file.writeAsBytes(bytes);
    Fluttertoast.showToast(msg: 'تم تحميل الاية بنجاح');
    return file;
  }

//TODO
  Future runAudio(
      {required int numberInQuran, required String fileName, required String fileType}) async {
    //check if the same file is playing
    if (audioServiceCtr.list.isNotEmpty) {
      //if some files are downloading
      if (audioServiceCtr.list[0].isLoading) return;
      //stop the previous file
      audioServiceCtr.list[0].pauseAudio();
    }
    playerId = numberInQuran;
    audioServiceCtr.playAudio(this, playerId);

    isLoading = true;
    setState();

    animationCtr.forward();

    await player.play(AssetSource('sounds/allAyahs/$numberInQuran.mp3'));


    isLoading = false;
    setState();


  }

  void pauseAudio() {
    audioServiceCtr.stopAudio();
    animationCtr.reverse();
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
    list[0].player.pause();
    list.removeAt(0);
    isAudioPlaying.value = false;
  }

  void stopAudioById(int id) {
    if (list.isEmpty) return;
    if (list[0].playerId == id) stopAudio();
  }
}
