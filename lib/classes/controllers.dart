import 'package:get/get.dart';

import '../pages/prayer_times.dart';
import '../services/notification_api.dart';
import '../pages/alarms_page.dart';
import '../services/audio_service.dart';

class Controllers {
  Controllers() {
    Get.put(AudioServiceCtr());
    NotificationService();
    Get.put(PrayerTimeCtr());
    Get.put(AlarmsCtr());
    // settingsCtr = Get.put(SettingsCtr());
  }
}
