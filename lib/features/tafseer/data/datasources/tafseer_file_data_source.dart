import 'package:zad_almumin/features/tafseer/tafseer.dart';

import '../../../../core/services/files_service.dart';

abstract class ITafseerFileDataSource {
  Future<bool> checkTafseerIfDownloaded(int tafseerId);
  void writeDataIntoFileIntoFileAsBytesSync(int tafseerid, List<int> data);
  Future<TafseersDataModel> getTafseersData(int tafseerId);
}

class TafseerFileDataSource implements ITafseerFileDataSource {
  TafseersDataModel tafseersData = TafseersDataModel.init();
  final IFilesService filesService;

  TafseerFileDataSource({
    required this.filesService,
  });

  @override
  Future<bool> checkTafseerIfDownloaded(int tafseerId) async {
    bool tafseerAlraedyDownloaded = await filesService.checkIfTafseerFileDownloaded(tafseerId);
    return tafseerAlraedyDownloaded;
  }

  @override
  void writeDataIntoFileIntoFileAsBytesSync(int tafseerid, List<int> data) {
    filesService.writeDataIntoFileAsBytes(filesService.tafseerPath(tafseerid), data);
  }

  @override
  Future<TafseersDataModel> getTafseersData(int tafseerId) async {
    if (tafseersData.tafseerId == tafseerId) {
      return tafseersData;
    }

    //no loaded data
    var tafseerMap = await filesService.getFile(filesService.tafseerPath(tafseerId));
    if (tafseerMap == null) throw Exception("File not found");

    tafseersData = TafseersDataModel.fromJson(tafseerMap);

    return tafseersData;
  }
}
