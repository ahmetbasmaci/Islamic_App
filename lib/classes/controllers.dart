import 'package:get/get.dart';
import '../pages/alarms/controllers/alarms_ctr.dart';
import '../pages/ayahsTest/controller/first_ayahs_in_pages_ctr.dart';
import '../pages/favorite/favorite_page_ctr.dart';
import '../pages/prayerTimes/controllers/prayer_time_ctr.dart';
import '../pages/quran/controllers/quran_page_ctr.dart';
import '../pages/settings_page.dart';
import '../services/http_service.dart';
import '../services/json_service.dart';
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
    Get.put(FirstAyahsInPagesCtr());
    Get.put(FavoriteCtr());
    Get.put(SettingsCtr());
    // JsonService();
  }
}
