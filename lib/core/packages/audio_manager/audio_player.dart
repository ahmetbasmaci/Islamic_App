import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/utils/enums/enums.dart';
import '../../../features/quran/quran.dart';
import 'audio_manager.dart';

abstract class IAudioPlayer {
  Future<bool> playPauseSingleAudio(AudioFile audioFile, Function onComplate);
  Future<bool> playPauseMultibleAudio(
      List<AudioFile> audioFiles, int startAyahIndex, Function(Ayah complatedAyah, bool partEnded) onComplate);
  Future<void> pause();
  Future<void> stopAudio();
  Future<AudioStreamModel> streamPosition();
  bool get isPlaying;
}

class AudioPlayer implements IAudioPlayer {
  AudioPlayer() {
    _setPlayerListeners();
  }
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  AudioPlayerType audioPlayerType = AudioPlayerType.none;

  Duration duration = const Duration();
  Duration position = const Duration();


  @override
  bool get isPlaying => audioPlayerType.isPlaying || assetsAudioPlayer.isPlaying.value;

  bool get isPaused =>
      audioPlayerType == AudioPlayerType.singlePauesed || audioPlayerType == AudioPlayerType.multiblePaused;

  @override
  Future<bool> playPauseSingleAudio(AudioFile audioFile, Function onComplate) async {
    if (audioPlayerType == AudioPlayerType.playingSingle) {
      await pause();
      return false;
    } else {
      return await _playSingle(audioFile, onComplate);
    }
  }

  Future<bool> _playSingle(AudioFile audioFile, Function onComplate) async {
    if (isPlaying) {
      await stopAudio();
    }

    String fullPath = audioFile.path;
    //check if player in pause mode and have to continue the same audio
    //if true continue the same audio
    bool continuePeusedAudio = cotinueIfSinglePaused(fullPath);
    if (continuePeusedAudio) return true;
    if (isPaused) {
      await stopAudio();
    }
    _resetFields();

    audioPlayerType = AudioPlayerType.playingSingle;
    await assetsAudioPlayer.setLoopMode(LoopMode.none);

    _onComlatedSingleAudios(onComplate);

    Audio audio = Audio.file(
      fullPath,
      metas: AudioHelperWidgets.metas(
        title: audioFile.metasTitle,
        artist: audioFile.metasArtist,
        album: audioFile.metasAlbum,
        extra: audioFile.extra,
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
  Future<bool> playPauseMultibleAudio(
    List<AudioFile> audioFiles,
    int startAyahInde,
    Function(Ayah complatedAyah, bool partEnded) onComplate,
  ) async {
    if (audioPlayerType == AudioPlayerType.playingMultible) {
      await pause();
      return false;
    } else {
      return await _playMultiple(audioFiles, startAyahInde, onComplate);
    }
  }

  Future<bool> _playMultiple(
    List<AudioFile> audioFiles,
    int startIndex,
    Function(Ayah complatedAyah, bool partEnded) onComplate,
  ) async {
    if (audioFiles.isEmpty) throw Exception("Audio files is empty");

    if (isPlaying) {
      await stopAudio();
    }

    bool continueAudio = cotinueIfMultiblePaused(audioFiles);
    if (continueAudio) return true;
    if (isPaused) {
      await stopAudio();
    }
    _resetFields();

    await assetsAudioPlayer.setLoopMode(LoopMode.playlist);
    audioPlayerType = AudioPlayerType.playingMultible;

    _setOnComlatedMultibleAudios(onComplate);

    Playlist playlist = getPlaylist(audioFiles);
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
  Future<void> pause() async {
    if (isPlaying) {
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
    if (isPlaying) {
      await assetsAudioPlayer.stop();

      audioPlayerType = AudioPlayerType.none;

      if (assetsAudioPlayer.playlist != null) {
        assetsAudioPlayer.playlist?.audios.clear();
      }
    }

    _resetFields();
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

  void _onComlatedSingleAudios(Function onComplate) {
    assetsAudioPlayer.playlistAudioFinished.listen(
      (event) {
        audioPlayerType = AudioPlayerType.none;
        onComplate();
      },
    );
  }

  void _setOnComlatedMultibleAudios(Function(Ayah complatedAyah, bool partEnded) onComplate) {
    assetsAudioPlayer.playlistAudioFinished.listen((event) {
      Ayah complatedAyah = Ayah.fromJson(event.audio.audio.metas.extra);
      bool partEnded = complatedAyah.number == (int.tryParse(event.playlist.audios.last.metas.album ?? '0') ?? 0);
      if (partEnded) {
        audioPlayerType = AudioPlayerType.none;
      }
      onComplate(complatedAyah, partEnded);
    });

    // print(assetsAudioPlayer.current.value);
    // _onComlatedMultibleAudios();
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

  bool cotinueIfSinglePaused(String fullPath) {
    if (audioPlayerType == AudioPlayerType.singlePauesed) {
      if (assetsAudioPlayer.current.value?.audio.audio.path == fullPath) {
        assetsAudioPlayer.playOrPause();
        return true;
      }
    }
    return false;
  }

  bool cotinueIfMultiblePaused(List<AudioFile> audioFiles) {
    // check if player in pause mode and have to continue the same audio
    // if (audioPlayerType == AudioPlayerType.multiblePaused) {
    //   if (playlist.audios.any((element) => element.path == assetsAudioPlayer.current.valueOrNull?.audio.audio.path)) {
    //     await assetsAudioPlayer.playOrPause();
    //     return true;
    //   }
    // }

    if (audioPlayerType == AudioPlayerType.multiblePaused) {
      if (assetsAudioPlayer.playlist != null) {
        if (assetsAudioPlayer.playlist!.audios.length == audioFiles.length) {
          if (audioFiles.any((element) => element.path == assetsAudioPlayer.current.valueOrNull?.audio.audio.path)) {
            assetsAudioPlayer.playOrPause();
            return true;
          }
        }
      }
    }
    return false;
  }

  void _setPlayerListeners() {
    // assetsAudioPlayer.isPlaying.listen((event) {
    //   audioPlayerType = event;
    // });

    //update current audio file
    // assetsAudioPlayer.current.listen((event) {
    //   _currentAudio = event;
    // });

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

  void _resetFields() {
    _updateAudioPlayerObject();
    _resetPosition();
    _resetDuration();
  }

  void _resetPosition() {
    position = const Duration();
  }

  void _resetDuration() {
    duration = const Duration();
  }

  void _updateAudioPlayerObject() {
    assetsAudioPlayer = AssetsAudioPlayer();
   
  }

  Playlist getPlaylist(List<AudioFile> audioFiles) {
    Playlist playlist = Playlist(audios: []);
    for (int i = 1; i < audioFiles.length; i++) {
      AudioFile audioFile = audioFiles[i];
      Audio audio = Audio.file(
        audioFile.path,
        metas: AudioHelperWidgets.metas(
          title: audioFile.metasTitle,
          artist: audioFile.metasArtist,
          album: audioFile.metasAlbum,
          extra: audioFile.extra,
        ),
      );
      playlist.add(audio);
    }
    return playlist;
  }
}
