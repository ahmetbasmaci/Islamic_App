import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/resources/app_images.dart';

class AudioHelperWidgets {
  static Metas metas({
    required String title,
    required String artist,
    required String album,
  }) {
    return Metas(
      title: title,
      artist: artist, // "${'الآية'.tr}  ${ayah.ayahNumber}",
      album: album,
      image: MetasImage.asset(AppImages.appLogo), //can be MetasImage.network
    );
  }

  static NotificationSettings singleAudioNotificationSettings(VoidCallback? customStopAction) {
    return NotificationSettings(
      prevEnabled: false,
      nextEnabled: false,
      customStopAction: (player) {
        customStopAction?.call();
      },
    );
  }

  static NotificationSettings multibleAudioNotificationSettings() {
    return const NotificationSettings();
  }
}
