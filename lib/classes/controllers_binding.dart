import 'package:get/get.dart';
import 'package:zad_almumin/components/my_end_drawer.dart';
import 'package:zad_almumin/pages/prayerTimes/controllers/prayer_time_ctr.dart';
import 'package:zad_almumin/pages/quran/models/quran_data.dart';
import 'package:zad_almumin/services/json_service.dart';
import '../constents/app_settings.dart';
import '../pages/quran/controllers/quran/tafseers.ctr.dart';
import '../pages/readers_quran_download/controllers/readers_quran_download_ctr.dart';
import '../services/audio_ctr.dart';
import '../pages/alarms/controllers/alarms_ctr.dart';
import '../pages/ayahsTest/controller/ayahs_questions_ctr.dart';
import '../pages/favorite/favorite_page_ctr.dart';
import '../pages/quran/controllers/quran/quran_page_ctr.dart';
import '../pages/settings/settings_ctr.dart';
import '../services/http_service.dart';
import '../services/notification_api.dart';
import '../services/theme_service.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() async {
    NotificationService();
    AppSettings();
    Get.put(ThemeCtr());
    Get.put(SettingsCtr());
    Get.put(PrayerTimeCtr());
    Get.put(QuranData());
    Get.put(AlarmsCtr());
    Get.put(QuranPageCtr());
    Get.put(AudioCtr());
    Get.put(HttpCtr());
    Get.put(AyahsQuestionsCtr());
    Get.put(FavoriteCtr());
    Get.put(MyEndDrawerCtr());
    Get.put(TafseersCtr());
    Get.put(ReaderQuranDownloadCtr());
    await JsonService.loadData();
  }
}
