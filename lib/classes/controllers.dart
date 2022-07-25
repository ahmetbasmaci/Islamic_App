import 'package:get/get.dart';

import '../services/notification_api.dart';
import '../pages/alarms_page.dart';
import '../services/audio_service.dart';

class Controllers {
  Controllers() {
    Get.put(AlarmsCtr());
    Get.put(AudioServiceCtr());
    NotificationService();

    // settingsCtr = Get.put(SettingsCtr());
  }
}
