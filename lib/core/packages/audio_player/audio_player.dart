import 'dart:io';
import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';
import '../../error/exceptions/app_exceptions.dart';
import 'audio_helper_widgets.dart';

class AudioPlayer {
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  bool isPlaying = false;
  Duration duration = const Duration();
  Duration position = const Duration();
  double slider = (0.0);
  double sliderVolume = 0.0;
  int currentAyahRepeatCount = 0;
  int currentOfAllRepeatCount = 0;
  bool isMultibleAudio = false;
  Playing? currentAudio;

  Future<void> playPauseSingleAudio({
    required String audioPath,
    required String metasTitle,
    required String metasArtist,
    String? metasAlbum,
    VoidCallback? onComplite,
  }) async {
    if (isPlaying) {
      await pauseAudio();
      return;
    }
    await assetsAudioPlayer.setLoopMode(LoopMode.none);

    String fullPath = _getFullPath(audioPath);
    Audio audioFile = Audio.file(
      fullPath,
      metas: AudioHelperWidgets.metas(
        title: metasTitle,
        artist: metasArtist,
        album: metasAlbum ?? '',
      ),
    );

    //check if player in pause mode and have to continue the same audio
    if (_isSinglePaused(fullPath)) {
      assetsAudioPlayer.playOrPause();
      return;
    }

    _resetPosition();

    File file = File(audioPath);
    bool exsist = await file.exists();
    if (exsist) {
      await stopAudio();

      isMultibleAudio = false;
      assetsAudioPlayer.open(
        audioFile,
        showNotification: true,
        notificationSettings: AudioHelperWidgets.singleAudioNotificationSettings(stopAudio),
      );
    } else {
      await stopAudio();
      throw AudioException("File not found");
    }
  }

  /*

  void playMultiAudio({required List<Ayah> ayahList}) async {
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
      debugPrint(e.tostring());
    }
  }

*/
  Future<void> pauseAudio() async {
    if (isPlaying) await assetsAudioPlayer.pause();
  }

  Future<void> stopAudio() async {
    if (assetsAudioPlayer.playlist != null) {
      assetsAudioPlayer.playlist?.audios.clear();
    }
    await assetsAudioPlayer.stop();
    currentOfAllRepeatCount = 0;
    currentAyahRepeatCount = 0;
    sliderVolume = 0;
    slider = 0;
    position = const Duration();
    duration = const Duration();
  }

  void updateOnEndEvent() {
    assetsAudioPlayer.playlistAudioFinished.listen((Playing playing) {
      if (isMultibleAudio)
        _onComlatedMultibleAudios();
      else if (!isPlaying && assetsAudioPlayer.playlist != null && assetsAudioPlayer.playlist!.audios.isNotEmpty) {
        _onComlatedSingleAudios();
      }
    });

    assetsAudioPlayer.isPlaying.listen((event) {
      isPlaying = event;
    });
    assetsAudioPlayer.current.listen((event) {
      currentAudio = event;
    });
    assetsAudioPlayer.volume.listen((event) {
      sliderVolume = event;
    });
    assetsAudioPlayer.currentPosition.listen((event) {
      position = event;
      // slider.value = assetsAudioPlayer.current.value?.audio.audio.duration != Duration()
      //     ? position.value.inMilliseconds /
      //         assetsAudioPlayer.current.value!.audio.audio.duration.inMilliseconds
      //     : 0;
    });
    AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
      //custom action
      debugPrint("setupNotificationsOpenAction action");
      return true; //true : handled, does not notify others listeners
      //false : enable others listeners to handle it
    });
    AssetsAudioPlayer.addNotificationOpenAction((notification) {
      //custom action
      debugPrint('addNotificationOpenAction action');
      return false; //true : handled, does not notify others listeners
      //false : enable others listeners to handle it
    });
  }

  void _onComlatedMultibleAudios() {
    /*
    QuranPageCtr quranPageCtr = Get.find<QuranPageCtr>();

    if (quranPageCtr.selectedAyah.value.ayahNumber == 0) return;

    bool partIsEnd = quranPageCtr.selectedPage.endAyahNum.value <= quranPageCtr.selectedAyah.value.ayahNumber + 1;
    if (assetsAudioPlayer.current.value == null || partIsEnd) {
      if (assetsAudioPlayer.playlist!.audios.isNotEmpty) {
        currentOfAllRepeatCount++;
        bool unLimitRepeet = quranPageCtr.selectedPage.isUnlimitRepeatAll.value;
        bool inRepeetLimit = quranPageCtr.selectedPage.repeetAllCount.value > currentOfAllRepeatCount;
        if (inRepeetLimit || unLimitRepeet) {
          assetsAudioPlayer.playlistPlayAtIndex(quranPageCtr.selectedPage.startAyahNum.value);

          Ayah ayah = Get.find<QuranData>().getAyah(
              assetsAudioPlayer.playlist!.audios[quranPageCtr.selectedPage.startAyahNum.value - 1].surahNumber,
              assetsAudioPlayer.playlist!.audios[quranPageCtr.selectedPage.startAyahNum.value - 1].ayahNumber);

          quranPageCtr.updateSelectedAyah(ayah); //to change background color
        } else {
          AudioService.stopAudio();
          currentOfAllRepeatCount = 0;
          quranPageCtr.updateSelectedAyah(Ayah.empty()); //to hide background color
        }
      }
      return;
    }
    currentAyahRepeatCount++;

    bool unLimitRepeet = quranPageCtr.selectedPage.isUnlimitRepeatAyah.value;
    bool inRepeetLimit = quranPageCtr.selectedPage.repeetAyahCount.value > currentAyahRepeatCount;

    if (inRepeetLimit || unLimitRepeet) {
      assetsAudioPlayer.playlistPlayAtIndex(assetsAudioPlayer.currentIndex);
    } else {
      currentAyahRepeatCount = 0;

      Ayah ayah = Get.find<QuranData>()
          .getAyah(quranPageCtr.selectedAyah.value.surahNumber, quranPageCtr.selectedAyah.value.ayahNumber + 1);

      quranPageCtr.updateSelectedAyah(ayah); //to change background color
    }
    */
  }

  void _onComlatedSingleAudios() {
    //onCompliteSingle.call();
  }

  void _resetPosition() {
    position = const Duration();
  }

  String _getFullPath(String path) => "file://$path";

  bool _isSinglePaused(String fullPath) {
    if (!isMultibleAudio) {
      if (assetsAudioPlayer.current.hasValue) {
        if (assetsAudioPlayer.current.value != null) {
          if (assetsAudioPlayer.current.value!.audio.audio.path == fullPath) {
            return true;
          }
        }
      }
    }
    return false;
  }
}
