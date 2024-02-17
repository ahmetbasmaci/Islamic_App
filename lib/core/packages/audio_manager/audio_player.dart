import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:rename/custom_exceptions.dart';
import 'package:zad_almumin/core/extentions/enum_extentions.dart';
import 'package:zad_almumin/core/utils/enums/enums.dart';
import 'package:zad_almumin/core/utils/resources/app_constants.dart';
import 'audio_manager.dart';

abstract class IAudioPlayer {
  Future<bool> playPauseSingleAudio(AudioFile audioFile, Function onComplate);
  Future<bool> play(AudioFile audioFile, Function onComplate);
  Future<bool> playMultiple({required List<AudioFile> audioFiles, required int startIndex});
  Future<void> pause();
  Future<void> stopAudio();
  Future<AudioStreamModel> streamPosition();
}

class AudioPlayer implements IAudioPlayer {
  AudioPlayer() {
    _setPlayerListeners();
  }
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  AudioPlayerType audioPlayerType = AudioPlayerType.none;

  Duration duration = const Duration();
  Duration position = const Duration();

  int currentAyahRepeatCount = 0;
  int currentOfAllRepeatCount = 0;

  Playing? currentAudio;

  @override
  Future<bool> playPauseSingleAudio(AudioFile audioFile, Function onComplate) async {
    if (audioPlayerType.isPlaying) {
      await pause();
      return false;
    } else {
      return await play(audioFile, onComplate);
    }
  }

  @override
  Future<bool> play(AudioFile audioFile, Function onComplate) async {
    if (audioPlayerType.isPlaying) {
      await stopAudio();
    }

    String fullPath = audioFile.path;

    File file = File(fullPath);
    bool exsist = await file.exists();
    if (!exsist) {
      throw FileNotExistException(
        filePath: audioFile.path,
        details:
            '${audioFile.path} File not found \n title: ${audioFile.metasTitle} \n artist: ${audioFile.metasArtist} \n album: ${audioFile.metasAlbum}',
        platform: AppConstants.currentPlatform,
      );
    }

    //check if player in pause mode and have to continue the same audio
    //if true continue the same audio
    //if (_isSinglePaused(fullPath)) {
    if (audioPlayerType == AudioPlayerType.singlePauesed && currentAudio?.audio.audio.path == fullPath) {
      await assetsAudioPlayer.playOrPause();
      return true;
    }

    _resetFields();

    audioPlayerType = AudioPlayerType.playingSingle;
    await assetsAudioPlayer.setLoopMode(LoopMode.none);
    assetsAudioPlayer.playlistAudioFinished.listen(
      (event) {
        audioPlayerType = AudioPlayerType.none;
        onComplate();
      },
    );
    Audio audio = Audio.file(
      fullPath,
      metas: AudioHelperWidgets.metas(
        title: audioFile.metasTitle,
        artist: audioFile.metasArtist,
        album: audioFile.metasAlbum ?? '',
      ),
    );

    await assetsAudioPlayer.open(
      audio,
      showNotification: true,
      notificationSettings: AudioHelperWidgets.singleAudioNotificationSettings(stopAudio),
    );
    return true;
  }

  @override
  Future<void> pause() async {
    if (audioPlayerType.isPlaying) {
      await assetsAudioPlayer.pause();

      if (audioPlayerType == AudioPlayerType.playingSingle) {
        audioPlayerType = AudioPlayerType.singlePauesed;
      } else if (audioPlayerType == AudioPlayerType.playingMultible) {
        audioPlayerType = AudioPlayerType.multiblePaused;
      }
    }
  }

  @override
  Future<void> stopAudio() async {
    if (audioPlayerType.isPlaying) {
      await assetsAudioPlayer.stop();

      audioPlayerType = AudioPlayerType.none;

      if (assetsAudioPlayer.playlist != null) {
        assetsAudioPlayer.playlist?.audios.clear();
      }
    }

    _resetFields();
  }

  @override
  Future<bool> playMultiple({required List<AudioFile> audioFiles, required int startIndex}) async {
    if (audioFiles.isEmpty) throw Exception("Audio files is empty");

    if (audioPlayerType.isPlaying) {
      await stopAudio();
    }

    Playlist playlist = Playlist(audios: []);
    for (int i = 1; i < audioFiles.length; i++) {
      AudioFile audioFile = audioFiles[i];
      String fullPath = audioFile.path;
      //_getFullPath(audioFile.path);

      File file = File(fullPath);
      bool exsist = await file.exists();
      if (!exsist) {
        throw FileNotExistException(
          filePath: audioFile.path,
          details:
              '${audioFile.path} File not found \n title: ${audioFile.metasTitle} \n artist: ${audioFile.metasArtist} \n album: ${audioFile.metasAlbum}',
          platform: AppConstants.currentPlatform,
        );
      }
      Audio audio = Audio.file(
        fullPath,
        metas: AudioHelperWidgets.metas(
          title: audioFile.metasTitle,
          artist: audioFile.metasArtist,
          album: audioFile.metasAlbum ?? '',
        ),
      );
      playlist.add(audio);
    }

    // check if player in pause mode and have to continue the same audio
    if (audioPlayerType == AudioPlayerType.playingMultible && currentAudio?.audio.audio.path != audioFiles[0].path) {
      await assetsAudioPlayer.playOrPause();
      return true;
    }
    _resetPosition();

    await assetsAudioPlayer.setLoopMode(LoopMode.playlist);
    audioPlayerType = AudioPlayerType.playingMultible;

    assetsAudioPlayer.open(
      playlist,
      showNotification: true,
      autoStart: false,
      notificationSettings: AudioHelperWidgets.multibleAudioNotificationSettings(),
    );

    await assetsAudioPlayer.playlistPlayAtIndex(startIndex);
    return true;
  }

  @override
  Future<AudioStreamModel> streamPosition() async {
    while (assetsAudioPlayer.isPlaying.value != true) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    return AudioStreamModel(
      duration: assetsAudioPlayer.current.value?.audio.duration ?? const Duration(),
      position: assetsAudioPlayer.currentPosition,
    );
  }

  void _setPlayerListeners() {
    // assetsAudioPlayer.isPlaying.listen((event) {
    //   audioPlayerType = event;
    // });

    //update current audio file
    assetsAudioPlayer.current.listen((event) {
      currentAudio = event;
    });

    //add audio complite event
    // assetsAudioPlayer.playlistAudioFinished.listen(
    //   (Playing playing) {
    //     if (audioPlayerType == AudioPlayerType.playingMultible) {
    //       _onComlatedMultibleAudios();
    //     } else if (audioPlayerType == AudioPlayerType.playingSingle) {
    //       _onComlatedSingleAudios();
    //     }
    //   },
    // );

    //add notification open action
    AssetsAudioPlayer.addNotificationOpenAction((notification) {
      debugPrint('addNotificationOpenAction action');
      return false;
    });

    //set notification open action
    AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
      debugPrint("setupNotificationsOpenAction action");
      return true;
    });
  }

  void _onComlatedMultibleAudios() {
    print("**********************onCompliteMultible");
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
    print("**********************onCompliteSingle");
    //onCompliteSingle.call();
  }

  void _resetFields() {
    _resetPosition();
    _resetDuration();
    currentOfAllRepeatCount = 0;
    currentAyahRepeatCount = 0;
  }

  void _resetPosition() {
    position = const Duration();
  }

  void _resetDuration() {
    duration = const Duration();
  }

  String _getFullPath(String path) => "file://$path";

  bool _isSinglePaused(String fullPath) {
    if (audioPlayerType == AudioPlayerType.playingMultible) return false;
    if (!assetsAudioPlayer.current.hasValue) return false;
    if (assetsAudioPlayer.current.value == null) return false;
    if (assetsAudioPlayer.current.value!.audio.audio.path != fullPath) return false;

    return true;

    //     if (!isMultibleAudio.value) {
    //   if (assetsAudioPlayer.current.hasValue) {
    //     if (assetsAudioPlayer.current.value != null) {
    //       if (assetsAudioPlayer.current.value!.audio.audio.path == fullPath) {
    //         return true;
    //       }
    //     }
    //   }
    // }
    // return false;
  }
}
