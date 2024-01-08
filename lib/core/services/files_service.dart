import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import 'package:zad_almumin/core/utils/resources/app_constants.dart';

abstract class IFilesService {
  Future<bool> isTafseerDownloaded(int tafseerId);
  String tafseerPath(int id);
  void writeDataIntoFileAsBytesSync(String filePath, List<int> data);
}

class FilesService implements IFilesService {
  FilesService() {
    _initFileDir();
  }
  Future<void> _initFileDir() async {
    _filesDir = (await getApplicationDocumentsDirectory()).path;
  }

  static String _filesDir = "";

  @override
  String tafseerPath(int id) => '$_filesDir/tafseer_${AppConstants.context.localeCode}_$id.json';

  @override
  Future<bool> isTafseerDownloaded(int tafseerId) async {
    String filePath = tafseerPath(tafseerId);
    var file = File(filePath);
    if (await file.exists()) return true;

    return false;
  }

  @override
  void writeDataIntoFileAsBytesSync(String filePath, List<int> data) {
    File file = File(filePath);
    file.writeAsBytesSync(data, mode: FileMode.append);
  }
}
