import '../../../../core/services/files_service.dart';

abstract class ITafseerFileDataSource {
  Future<bool> checkTafseerIfDownloaded(int tafseerId);
  void writeDataIntoFileIntoFileAsBytesSync(int tafseerid, List<int> data);
}

class TafseerFileDataSource implements ITafseerFileDataSource {
  final IFilesService filesService;
  TafseerFileDataSource({
    required this.filesService,
  });

  @override
  Future<bool> checkTafseerIfDownloaded(int tafseerId) async {
    bool tafseerAlraedyDownloaded = await filesService.isTafseerDownloaded(tafseerId);
    return tafseerAlraedyDownloaded;
  }

  @override
  void writeDataIntoFileIntoFileAsBytesSync(int tafseerid, List<int> data) {
    filesService.writeDataIntoFileAsBytesSync(filesService.tafseerPath(tafseerid), data);
  }
}
