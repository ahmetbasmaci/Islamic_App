import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/components/my_app_bar.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/constents/my_icons.dart';
import 'package:zad_almumin/constents/my_texts.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/services/json_service.dart';
import '../../services/http_service.dart';
import '../../services/theme_service.dart';
import 'controllers/quran/tafseers.ctr.dart';
import 'models/tafseer_model.dart';

class TafseersPage extends GetView<ThemeCtr> {
  TafseersPage({super.key});
  static String id = "TafseersPage";
  TafseersCtr tafseersCtr = Get.find<TafseersCtr>();
  final HttpCtr _httpCtrl = Get.find<HttpCtr>();
  @override
  Widget build(BuildContext context) {
    context.theme;
    return Scaffold(
      appBar: MyAppBar(title: 'تفاسير القرآن'.tr, showDrawerBtn: false, showSettingsBtn: false),
      body: ListView.builder(
        itemCount: tafseersCtr.tafseersManager.length,
        itemBuilder: (context, index) {
          TafseerModel tafseerModel = tafseersCtr.tafseersManager[index];
          return Obx(
            () => ListTile(
              title: MyTexts.settingsTitle(title: "${tafseerModel.name} - ${tafseerModel.bookName}", size: 16),
              subtitle: MyTexts.settingsContent(title: tafseerModel.author),
              selected: tafseersCtr.selectedTafseerId.value == tafseerModel.id,
              selectedTileColor: MyColors.primary.withOpacity(0.3),
              onTap: tafseerModel.downloadState.value == DownloadState.downloaded
                  ? () async {
                      tafseersCtr.updateSelectedTafseerId(tafseerModel.id);
                      await JsonService.loadTafseer();
                    }
                  : null,
              trailing: IconButton(
                icon: tafseerModel.downloadState.value == DownloadState.downloaded
                    ? MyIcons.downlaodDone()
                    : tafseerModel.downloadState.value == DownloadState.downloading
                        ? CircularProgressIndicator(
                            value: _httpCtrl.tafseerdownloadProgress.value / 100,
                            valueColor: AlwaysStoppedAnimation<Color>(MyColors.quranPrimary),
                          )
                        : MyIcons.downlaod(),
                onPressed: tafseerModel.downloadState.value == DownloadState.notDownloaded
                    ? () async {
                        if (_httpCtrl.isTafseerDownloading.value) {
                          Fluttertoast.showToast(msg: 'جاري تحميل تفسير أخر'.tr);
                          return;
                        }

                        tafseerModel.downloadState.value = DownloadState.downloading;
                        bool downloadedSuccesfuly = await HttpService.downloadTafsirById(tafseerModel.id);
                        if (downloadedSuccesfuly) {
                          tafseerModel.downloadState.value = DownloadState.downloaded;
                          if (tafseersCtr.selectedTafseerId.value == 0) {
                            tafseersCtr.updateSelectedTafseerId(tafseerModel.id);
                            await JsonService.loadTafseer();
                          }
                        } else
                          tafseerModel.downloadState.value = DownloadState.notDownloaded;
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
