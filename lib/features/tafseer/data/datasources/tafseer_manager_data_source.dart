import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/services/files_service.dart';
import 'package:zad_almumin/core/utils/resources/app_constants.dart';
import 'package:zad_almumin/features/tafseer/tafseer.dart';
import '../../../../core/services/json_service.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/resources/resources.dart';

abstract class ITafseerManagertaSource {
  Future<List<TafseerManagerModel>> get getTafsers;
}

class TafseerManagerDataSource implements ITafseerManagertaSource {
  final IJsonService jsonService;
  final IFilesService filesService;
  TafseerManagerDataSource({
    required this.jsonService,
    required this.filesService,
  });

  List<TafseerManagerModel> allTafseerData = [];
  @override
  Future<List<TafseerManagerModel>> get getTafsers async {
    if (allTafseerData.isEmpty) await _loadTafseerData();
    await _updateTafseersDownloadState();
    //return tafseers by selected language
    return allTafseerData.where((element) => element.language == AppConstants.context.localeCode).toList();
  }

  Future<void> _loadTafseerData() async {
    List<dynamic> data = await jsonService.readJson(AppJsonPaths.tafseersPath);
    if (data.isEmpty) return;
    allTafseerData = data.map((e) => TafseerManagerModel.fromJson(e)).toList();
  }

  Future<void> _updateTafseersDownloadState() async {
    //check if tafseer is downloaded
    for (var element in allTafseerData) {
      bool downloaded = await filesService.checkFileIfDownloaded(element.id);
      if (downloaded) {
        element.downloadState = DownloadState.downloaded;
      }
    }
  }
}
