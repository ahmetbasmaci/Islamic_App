// ignore_for_file: avoid_print

import 'dart:io';

import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/pages/quran/classes/ayah.dart';
import 'package:zad_almumin/pages/quran/classes/quran_helper.dart';

import 'pages/quran/controllers/quran_page_ctr.dart';

class AudioBacgroundService extends GetxController {
  @override
  void dispose() {
    AudioManager.instance.release();
    super.dispose();
  }

  static final QuranPageCtr quranCtr = Get.find<QuranPageCtr>();
  bool isPlaying = false;
  Duration _duration = Duration();
  Duration _position = Duration();
  double _slider = 0;
  double _sliderVolume = 0;
  String _error = "";
  num curIndex = 0;
  final String _imgPath = "assets/images/app_logo.png";
  List<AudioInfo> audioList = [];
  int currentAyahRepeatCount = 0;
  int currentOfAllRepeatCount = 0;

  void playNewAudioFile(String audioPath) async {
    AudioInfo info = AudioInfo("file://$audioPath", title: "my file", desc: "my local file", coverUrl: _imgPath);
    AudioManager.instance.audioList.clear();
    audioList.clear();
    audioList.add(info);
    AudioManager.instance.audioList = audioList;
    AudioManager.instance.play();
  }

  void pauseAudio() {
    if (isPlaying) AudioManager.instance.playOrPause();
  }

  void stopAudio() {
    AudioManager.instance.stop();
    AudioManager.instance.audioList.clear();
    _position = Duration();
  }

  void playMultiAudio({
    required List<Ayah> ayahList,
    required VoidCallback onStop,
    required VoidCallback onStart,
  }) {
    if (AudioManager.instance.audioList.isNotEmpty) {
      AudioManager.instance.playOrPause();
      return;
    } else {
      _position = Duration();
    }
    setAudioEvents(
      onEnded: () {
        currentAyahRepeatCount++;
        bool isEnded = AudioManager.instance.curIndex + 1 >= quranCtr.selectedSurah.endAyahNum.value;
        if (isEnded) {
          currentOfAllRepeatCount++;
          bool unLimitRepeet = quranCtr.selectedSurah.isUnlimitRepeatAll.value;
          bool inRepeetLimit = quranCtr.selectedSurah.repeetAllCount.value > currentOfAllRepeatCount;
          if (inRepeetLimit || unLimitRepeet)
            AudioManager.instance.play(index: 0);
          else {
            currentOfAllRepeatCount;
            stopAudio();
          }
        } else {
          bool unLimitRepeet = quranCtr.selectedSurah.isUnlimitRepeatAyah.value;
          bool inRepeetLimit = quranCtr.selectedSurah.repeetAyahCount.value > currentAyahRepeatCount;

          if (inRepeetLimit || unLimitRepeet) {
            AudioManager.instance.play(index: AudioManager.instance.curIndex);
          } else {
            currentAyahRepeatCount = 0;
            AudioManager.instance.play(index: AudioManager.instance.curIndex + 1);
            //AudioManager.instance.next();
          }
        }
      },
      onStop: onStop,
      onStart: onStart,
    );

    AudioManager.instance.audioList.clear();
    audioList.clear();
    for (var item in ayahList) {
      AudioInfo info = AudioInfo(
        "file://${item.file.path}",
        title: "سورة ${QuranHelper().getSurahNameByNumber(item.surahNumber)}",
        desc: "الاية  ${item.ayahNumber}",
        coverUrl: _imgPath,
      );
      audioList.add(info);
    }

    AudioManager.instance.audioList = audioList;
    AudioManager.instance.play(index: quranCtr.selectedSurah.startAyahNum.value - 1);
  }

  void playSingleAudio({
    required String path,
    required String title,
    required String desc,
    required VoidCallback onEnded,
    required VoidCallback onStop,
    required VoidCallback onStart,
  }) async {
    AudioManager.instance.nextMode(playMode: PlayMode.single);

    setAudioEvents(onEnded: onEnded, onStop: onStop, onStart: onStart);

    AudioInfo info = AudioInfo("file://$path", title: "سورة $title", desc: "الاية  $desc", coverUrl: _imgPath);
    if (AudioManager.instance.info != null) {
      if (AudioManager.instance.info!.url == info.url) {
        AudioManager.instance.playOrPause();
        return;
      }
    }
    _position = Duration();
    try {
      File file = File(path);
      bool exsist = await file.exists();
      if (exsist)
        AudioManager.instance.start("file://$path", "سورة $title", desc: "الاية  $desc", cover: _imgPath);
      else {
        Fluttertoast.showToast(msg: 'حدث خطأ أثناء تشغيل الصوت');
        stopAudio();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'حدث خطأ أثناء تشغيل الصوت');
    }
  }

  void setAudioEvents({VoidCallback? onEnded, VoidCallback? onStop, VoidCallback? onStart}) {
    AudioManager.instance.onEvents((events, args) {
      switch (events) {
        case AudioManagerEvents.start:
          print("audio start event");
          _duration = AudioManager.instance.duration;
          break;
        case AudioManagerEvents.ready:
          print("audio ready event");
          AudioManager.instance.seekTo(_position);
          if (onStart != null) onStart();
          break;
        case AudioManagerEvents.seekComplete:
          print("audio seekComplete event");
          _slider = _position.inMilliseconds / _duration.inMilliseconds;
          break;
        case AudioManagerEvents.buffering:
          print("audio buffering event");
          break;
        case AudioManagerEvents.playstatus:
          isPlaying = AudioManager.instance.isPlaying;
          print("audio playstatus event **************************$isPlaying");
          if (isPlaying) {
            if (onStart != null) onStart();
          } else {
            if (onStop != null) onStop();
          }
          break;
        case AudioManagerEvents.timeupdate:
          print("audio timeupdate event");
          if (AudioManager.instance.position != Duration()) _position = AudioManager.instance.position;
          _slider = _position.inMilliseconds / _duration.inMilliseconds;
          print('position:---------------------------- $_position');
          break;
        case AudioManagerEvents.error:
          print('audio error event  ${args.toString()}');
          _error = args;
          break;
        case AudioManagerEvents.ended:
          print('audio ended event');
          _position = Duration();
          if (onEnded != null) onEnded.call();
          break;
        case AudioManagerEvents.volumeChange:
          print('audio volumeChange event');
          _sliderVolume = AudioManager.instance.volume;
          break;
        default:
          break;
      }
    });
  }
}
