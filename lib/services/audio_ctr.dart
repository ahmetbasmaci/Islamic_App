import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/pages/quran/controllers/quran/quran_page_ctr.dart';
import 'package:zad_almumin/pages/quran/models/ayah.dart';
import 'package:zad_almumin/pages/quran/models/quran_data.dart';
import 'package:zad_almumin/services/audio_service/audio_service.dart';

class AudioCtr extends GetxController {
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  RxBool isPlaying = false.obs;
  Rx<Duration> duration = Duration().obs;
  Rx<Duration> position = Duration().obs;
  RxDouble slider = (0.0).obs;
  RxDouble sliderVolume = 0.0.obs;
  int currentAyahRepeatCount = 0;
  int currentOfAllRepeatCount = 0;
  RxBool isMultibleAudio = false.obs;
  Playing? currentAudio;
  VoidCallback onCompliteSingle = () => {};
  AudioCtr() {
    updateOnEndEvent();
  }

  void updateOnEndEvent() {
    assetsAudioPlayer.playlistAudioFinished.listen((Playing playing) {
      if (isMultibleAudio.value)
        _onComlatedMultibleAudios();
      else if (!isPlaying.value &&
          assetsAudioPlayer.playlist != null &&
          assetsAudioPlayer.playlist!.audios.isNotEmpty) {
        _onComlatedSingleAudios();
      }
    });

    assetsAudioPlayer.isPlaying.listen((event) {
      isPlaying.value = event;
    });
    assetsAudioPlayer.current.listen((event) {
      currentAudio = event;
    });
    assetsAudioPlayer.volume.listen((event) {
      sliderVolume.value = event;
    });
    assetsAudioPlayer.currentPosition.listen((event) {
      position.value = event;
      // slider.value = assetsAudioPlayer.current.value?.audio.audio.duration != Duration()
      //     ? position.value.inMilliseconds /
      //         assetsAudioPlayer.current.value!.audio.audio.duration.inMilliseconds
      //     : 0;
    });
    AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
      //custom action
      print("setupNotificationsOpenAction action");
      return true; //true : handled, does not notify others listeners
      //false : enable others listeners to handle it
    });
    AssetsAudioPlayer.addNotificationOpenAction((notification) {
      //custom action
      print("addNotificationOpenAction action");
      return false; //true : handled, does not notify others listeners
      //false : enable others listeners to handle it
    });
  }

  void _onComlatedMultibleAudios() {
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
  }

  void _onComlatedSingleAudios() {
    onCompliteSingle.call();
  }

/*
  void setAudioEvents({VoidCallback? onEnded}) {
    // AudioManager.instance.onEvents((events, args) {
    //   switch (events) {
    //     case AudioManagerEvents.start:
    //       print("audio start event");
    //       break;
    //     case AudioManagerEvents.ready:
    //       print("audio ready event");
    //       _duration = AudioManager.instance.duration;
    //       //AudioManager.instance.seekTo(_position);
    //       // if (onStart != null) onStart();
    //       break;
    //     case AudioManagerEvents.seekComplete:
    //       print("audio seekComplete event");
    //       slider.value =
    //           AudioManager.instance.duration != Duration() ? _position.inMilliseconds / _duration.inMilliseconds : 0;
    //       break;
    //     case AudioManagerEvents.buffering:
    //       print("audio buffering event");
    //       break;
    //     case AudioManagerEvents.playstatus:
    //       isPlaying.value = AudioManager.instance.isPlaying;
    //       //print("audio playstatus event **************************$isPlaying");
    //       break;
    //     case AudioManagerEvents.timeupdate:
    //       print("audio timeupdate event");
    //       if (AudioManager.instance.position != Duration()) _position = AudioManager.instance.position;
    //       slider.value =
    //           AudioManager.instance.duration != Duration() ? _position.inMilliseconds / _duration.inMilliseconds : 0;
    //       //print('slider:---------------------------- ${slider.value}');
    //       print(args);
    //       break;
    //     case AudioManagerEvents.error:
    //       print('audio error event  ${args.toString()}');
    //       break;
    //     case AudioManagerEvents.ended:
    //       print('audio ended event');
    //       _position = Duration();
    //       slider.value = 0;
    //       _duration = Duration();
    //       if (onEnded != null) onEnded.call();
    //       break;
    //     case AudioManagerEvents.volumeChange:
    //       print('audio volumeChange event');
    //       sliderVolume = AudioManager.instance.volume;
    //       break;
    //     default:
    //       break;
    //   }
    // });
  }

*/
}



/*
class AudioCtr extends GetxController {
  @override
  void dispose() {
    AudioManager.instance.release();
    super.dispose();
  }

  final QuranPageCtr _quranCtr = Get.find<QuranPageCtr>();
  RxBool isPlaying = false.obs;
  Duration _duration = Duration();
  Duration _position = Duration();
  RxDouble slider = (0.0).obs;
  double sliderVolume = 0;
  num curIndex = 0;
  final String _imgPath = ImagesManager.appLogo;
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
    if (isPlaying.value) AudioManager.instance.playOrPause();
    isPlaying.value = !isPlaying.value;
  }

  void stopAudio() {
    isPlaying.value = false;
    AudioManager.instance.stop();
    AudioManager.instance.audioList.clear();
  }

  void playMultiAudio({required List<Ayah> ayahList}) async {
    if (ayahList.isEmpty) return;
    try {
      isPlaying.value = true;

      AudioManager.instance.nextMode(playMode: PlayMode.sequence);
      if (AudioManager.instance.audioList.isNotEmpty) {
        AudioManager.instance.playOrPause();
        return;
      } else {
        _position = Duration();
      }

      AudioManager.instance.audioList.clear();
      audioList.clear();
      for (int i = 1; i < ayahList.length; i++) {
        Ayah ayah = ayahList[i];
        AudioInfo info = AudioInfo(
          "file://${ayah.audioPath}",
          title: "${'سورة '.tr}${ayah.surahName}",
          desc: "${'الآية'.tr}  ${ayah.ayahNumber}",
          coverUrl: _imgPath,
        );
        audioList.add(info);
      }

      AudioManager.instance.audioList = audioList;
      AudioManager.instance.play(index: _quranCtr.selectedPage.startAyahNum.value - 1);
      setAudioEvents(
        onEnded: () {
          currentAyahRepeatCount++;
          bool isEnded = AudioManager.instance.curIndex + 1 >= audioList.length;
          if (isEnded) {
            currentOfAllRepeatCount++;
            bool unLimitRepeet = _quranCtr.selectedPage.isUnlimitRepeatAll.value;
            bool inRepeetLimit = _quranCtr.selectedPage.repeetAllCount.value > currentOfAllRepeatCount;
            if (inRepeetLimit || unLimitRepeet)
              AudioManager.instance.play(index: 0);
            else {
              currentOfAllRepeatCount;
              _quranCtr.updateSelectedAyah(Ayah.empty()); //to hide background color
              stopAudio();
            }
          } else {
            bool unLimitRepeet = _quranCtr.selectedPage.isUnlimitRepeatAyah.value;
            bool inRepeetLimit = _quranCtr.selectedPage.repeetAyahCount.value > currentAyahRepeatCount;

            if (inRepeetLimit || unLimitRepeet) {
              AudioManager.instance.play(index: AudioManager.instance.curIndex);
            } else {
              currentAyahRepeatCount = 0;
              _quranCtr.updateSelectedAyah(
                  ayahList.elementAt(AudioManager.instance.curIndex + 2)); //to change background color
              _quranCtr.updateCurrentPageToCurrentAyah();
              //AudioManager.instance.play(index: AudioManager.instance.curIndex + 1);

              AudioManager.instance.next();
            }
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }

  void playSingleAudio({
    required String path,
    required String title,
    required String desc,
    required VoidCallback onEnded,
  }) async {
    try {
      isPlaying.value = true;

      AudioManager.instance.nextMode(playMode: PlayMode.single);

      setAudioEvents(onEnded: onEnded);

      AudioInfo info =
          AudioInfo("file://$path", title: "${'سورة'.tr} $title", desc: "${'الآية'.tr}  $desc", coverUrl: _imgPath);
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
        
          AudioManager.instance
              .start("file://$path", "${'سورة'.tr} $title", desc: "${'الآية'.tr}  $desc", cover: _imgPath);
        else {
          Fluttertoast.showToast(msg: 'حدث خطأ أثناء تشغيل الصوت'.tr);
          stopAudio();
        }
      } catch (e) {
        Fluttertoast.showToast(msg: 'حدث خطأ أثناء تشغيل الصوت'.tr);
      }
    } catch (e) {
      print(e);
    }
  }

  void setAudioEvents({VoidCallback? onEnded}) {
    AudioManager.instance.onEvents((events, args) {
      switch (events) {
        case AudioManagerEvents.start:
          print("audio start event");
          break;
        case AudioManagerEvents.ready:
          print("audio ready event");
          _duration = AudioManager.instance.duration;
          //AudioManager.instance.seekTo(_position);
          // if (onStart != null) onStart();
          break;
        case AudioManagerEvents.seekComplete:
          print("audio seekComplete event");
          slider.value =
              AudioManager.instance.duration != Duration() ? _position.inMilliseconds / _duration.inMilliseconds : 0;
          break;
        case AudioManagerEvents.buffering:
          print("audio buffering event");
          break;
        case AudioManagerEvents.playstatus:
          isPlaying.value = AudioManager.instance.isPlaying;
          //print("audio playstatus event **************************$isPlaying");
          break;
        case AudioManagerEvents.timeupdate:
          print("audio timeupdate event");
          if (AudioManager.instance.position != Duration()) _position = AudioManager.instance.position;
          slider.value =
              AudioManager.instance.duration != Duration() ? _position.inMilliseconds / _duration.inMilliseconds : 0;
          //print('slider:---------------------------- ${slider.value}');
          print(args);
          break;
        case AudioManagerEvents.error:
          print('audio error event  ${args.toString()}');
          break;
        case AudioManagerEvents.ended:
          print('audio ended event');
          _position = Duration();
          slider.value = 0;
          _duration = Duration();
          if (onEnded != null) onEnded.call();
          break;
        case AudioManagerEvents.volumeChange:
          print('audio volumeChange event');
          sliderVolume = AudioManager.instance.volume;
          break;
        default:
          break;
      }
    });
  }
}
*/