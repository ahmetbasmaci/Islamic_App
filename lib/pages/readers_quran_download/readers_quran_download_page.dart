import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/pages/quran/models/quran_data.dart';
import 'package:zad_almumin/services/theme_service.dart';
import '../../components/my_app_bar.dart';
import '../../constents/app_settings.dart';
import '../../constents/my_icons.dart';
import '../../constents/my_texts.dart';
import '../../services/http_service.dart';
import '../quran/models/surah.dart';
import 'controllers/readers_quran_download_ctr.dart';

class ReaderQuranDownloadPage extends GetView<ThemeCtr> {
  ReaderQuranDownloadPage({super.key, required this.reader});
  QuranReaders reader;
  ReaderQuranDownloadCtr tafseersCtr = Get.find<ReaderQuranDownloadCtr>();
  final QuranData _quranData = Get.find<QuranData>();
  final HttpCtr _httpCtrl = Get.find<HttpCtr>();
  GetStorage getStorage = GetStorage();
  @override
  Widget build(BuildContext context) {
    List<Surah> allSurahs = _quranData.getAllSurahs();
    context.theme;
    return Scaffold(
      appBar: MyAppBar(title: reader.arabicName.tr, showDrawerBtn: false, showSettingsBtn: false, centerTitle: true),
      body: ListView.builder(
        itemCount: allSurahs.length,
        itemBuilder: (context, index) {
          Surah surah = allSurahs.elementAt(index);

          bool isDownloadedBefore =
              getStorage.read('${reader.name}${AppSettings.formatInt3.format(surah.number)}') ?? false;

          surah.downloadState.value = isDownloadedBefore ? DownloadState.downloaded : DownloadState.notDownloaded;
          return Obx(
            () {
              return ListTile(
                title: MyTexts.settingsTitle(title: AppSettings.removeTashkil(surah.name).tr, size: 16),
                subtitle: MyTexts.settingsContent(title: '${'عدد الصفحات'.tr}: ${surah.ayahs.length}'),
                trailing: IconButton(
                  icon: surah.downloadState.value == DownloadState.downloaded
                      ? MyIcons.downlaodDone()
                      : surah.downloadState.value == DownloadState.downloading
                          ? CircularProgressIndicator(
                              value: _httpCtrl.downloadProgress.value / 100,
                              valueColor: AlwaysStoppedAnimation<Color>(MyColors.quranPrimary()),
                            )
                          : MyIcons.downlaod(),
                  onPressed: surah.downloadState.value == DownloadState.notDownloaded
                      ? () async {
                          if (_httpCtrl.isDownloading.value) {
                            Fluttertoast.showToast(msg: 'جاري تحميل سورة أخرى'.tr);
                            return;
                          }
                          surah.downloadState.value = DownloadState.downloading;

                          await HttpService.getSurah(surahNumber: surah.number, reader: reader);
                          isDownloadedBefore =
                              getStorage.read('${reader.name}${AppSettings.formatInt3.format(surah.number)}') ?? false;

                          surah.downloadState.value =
                              isDownloadedBefore ? DownloadState.downloaded : DownloadState.notDownloaded;
                        }
                      : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
