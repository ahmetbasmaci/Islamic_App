import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/pages/quran/models/quran_data.dart';
import 'package:zad_almumin/services/theme_service.dart';
import '../../components/my_app_bar.dart';
import '../../components/my_circular_progress_indicator.dart';
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
              GetStorage().read('${reader.name}${AppSettings.formatInt3.format(surah.number)}') ?? false;

          surah.downloadState.value = isDownloadedBefore ? DownloadState.downloaded : DownloadState.notDownloaded;

          return Obx(
            () => ListTile(
              title: MyTexts.settingsTitle(title: AppSettings.removeTashkil(surah.name).tr, size: 16),
              subtitle: MyTexts.settingsContent(title: '${'عدد الصفحات'.tr}: ${surah.ayahs.length}'),
              // selectedTileColor: MyColors.primary().withOpacity(0.3),
              // onTap: tafseerModel.downloadState.value == TafseerDownloadState.downloaded
              //     ? () async {
              //         tafseersCtr.updateSelectedTafseerId(index + 1);
              //         await JsonService.loadTafseer();
              //       }
              //     : null,
              trailing: IconButton(
                icon: surah.downloadState.value == DownloadState.downloaded
                    ? MyIcons.downlaodDone()
                    : surah.downloadState.value == DownloadState.downloading
                        ? MyCircularProgressIndicator()
                        : MyIcons.downlaod(),
                onPressed: surah.downloadState.value == DownloadState.notDownloaded
                    ? () async {
                        surah.downloadState.value = DownloadState.downloading;

                        bool isDownloadedSucces =
                            (await HttpService.getSurah(surahNumber: surah.number, reader: reader)).first.audioUrl !=
                                '';
                        if (isDownloadedSucces) {
                          surah.downloadState.value = DownloadState.downloaded;
                        } else {
                          surah.downloadState.value = DownloadState.notDownloaded;
                        }
                      }
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}
