import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/assets_manager.dart';
import 'package:zad_almumin/pages/quran/models/ayah.dart';

class AudioHelperWidgets {
  static Metas metas(Ayah ayah) {
    return Metas(
      title: ayah.surahName,
      artist: "${'الآية'.tr}  ${ayah.ayahNumber}",
      album: "القارئ ",
      image: MetasImage.asset(ImagesManager.appLogo), //can be MetasImage.network
    );
  }

  static NotificationSettings singleAudioNotificationSettings(VoidCallback customStopAction) {
    return NotificationSettings(
      prevEnabled: false,
      nextEnabled: false,
      customStopAction: (player) {
        customStopAction.call();
      },
    );
  }

  static NotificationSettings multibleAudioNotificationSettings() {
    return NotificationSettings();
  }
}
