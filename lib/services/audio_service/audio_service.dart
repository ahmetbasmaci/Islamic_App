import 'dart:ffi';
import 'dart:io';
import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/pages/quran/controllers/quran/quran_page_ctr.dart';
import 'package:zad_almumin/pages/quran/models/ayah.dart';
import 'package:zad_almumin/services/audio_service/audio_helper_widgets.dart';
import 'package:zad_almumin/services/audio_ctr.dart';

class AudioService {
  static final _audioCtr = Get.find<AudioCtr>();

  static void playSingleAudio({required Ayah ayah, required VoidCallback onComplite}) async {
    try {
      String fullPath = _getFullPath(ayah.audioPath);

      await _audioCtr.assetsAudioPlayer.setLoopMode(LoopMode.none);
      _audioCtr.onCompliteSingle = onComplite;

      Audio audioFile = Audio.file(fullPath, metas: AudioHelperWidgets.metas(ayah));

      if (_isSinglePaused(_getFullPath(ayah.audioPath))) {
        _audioCtr.assetsAudioPlayer.playOrPause();
        return;
      }

      _resetPosition();

      File file = File(ayah.audioPath);
      bool exsist = await file.exists();
      if (exsist) {
        await stopAudio();

        _audioCtr.isMultibleAudio.value = false;
        _audioCtr.assetsAudioPlayer.open(
          audioFile,
          showNotification: true,
          notificationSettings: AudioHelperWidgets.singleAudioNotificationSettings(stopAudio),
        );
      } else {
        Fluttertoast.showToast(msg: 'حدث خطأ أثناء تشغيل الصوت'.tr);
        await stopAudio();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'حدث خطأ أثناء تشغيل الصوت'.tr);
      await stopAudio();
      print(e);
    }
  }

  static void playMultiAudio({required List<Ayah> ayahList}) async {
    if (ayahList.isEmpty) return;
    try {
      QuranPageCtr quranPageCtr = Get.find<QuranPageCtr>();
      await _audioCtr.assetsAudioPlayer.setLoopMode(LoopMode.playlist);

      // if (_audioCtr.isMultibleAudio.value && _audioCtr.assetsAudioPlayer.currentIndex > 0) {
      if (_isSinglePaused(_getFullPath(quranPageCtr.selectedAyah.value.audioPath))) {
        _audioCtr.assetsAudioPlayer.playOrPause();
        return;
      }
      _resetPosition();

      await stopAudio();

      Playlist playlist = Playlist(audios: []);
      for (int i = 1; i < ayahList.length; i++) {
        Ayah ayah = ayahList[i];
        String fullPath = _getFullPath(ayah.audioPath);
        Audio audio = Audio.file(fullPath, metas: AudioHelperWidgets.metas(ayah));
        playlist.add(audio);
      }
      _audioCtr.isMultibleAudio.value = true;
      _audioCtr.assetsAudioPlayer.open(
        playlist,
        showNotification: true,
        autoStart: false,
        notificationSettings: AudioHelperWidgets.multibleAudioNotificationSettings(),
      );

      _audioCtr.assetsAudioPlayer.playlistPlayAtIndex(quranPageCtr.selectedPage.startAyahNum.value - 1);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> pauseAudio() async {
    if (_audioCtr.isPlaying.value) await _audioCtr.assetsAudioPlayer.pause();
  }

  static Future<void> stopAudio() async {
    if (_audioCtr.assetsAudioPlayer.playlist != null) {
      _audioCtr.assetsAudioPlayer.playlist?.audios.clear();
    }
    await _audioCtr.assetsAudioPlayer.stop();
    _audioCtr.currentOfAllRepeatCount = 0;
    _audioCtr.currentAyahRepeatCount = 0;
    _audioCtr.sliderVolume.value = 0;
    _audioCtr.slider.value = 0;
    _audioCtr.position.value = Duration();
    _audioCtr.duration.value = Duration();
  }

  static void _resetPosition() {
    _audioCtr.position.value = Duration();
  }

  static String _getFullPath(String path) => "file://$path";

  static bool _isSinglePaused(String fullPath) {
    if (!_audioCtr.isMultibleAudio.value) {
      if (_audioCtr.assetsAudioPlayer.current.hasValue) {
        if (_audioCtr.assetsAudioPlayer.current.value != null) {
          if (_audioCtr.assetsAudioPlayer.current.value!.audio.audio.path == fullPath) {
            return true;
          }
        }
      }
    }
    return false;
  }
}
