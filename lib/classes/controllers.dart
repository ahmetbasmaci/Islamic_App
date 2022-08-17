import 'package:get/get.dart';
import '../pages/alarmsPage/controllers/alarm_page_ctr.dart';
import '../pages/prayerTimesPage/controllers/prayer_time_ctr.dart';
import '../pages/quranPage/controllers/quran_page_ctr.dart';
import '../services/http_service.dart';
import '../services/notification_api.dart';
import '../services/audio_service.dart';

class Controllers {
  Controllers() {
    Get.put(AudioServiceCtr());
    NotificationService();
    Get.put(PrayerTimeCtr());
    Get.put(AlarmsCtr());
    Get.put(QuranPageCtr());
    Get.put(HttpServiceCtr());
    // settingsCtr = Get.put(SettingsCtr());
  }
}
