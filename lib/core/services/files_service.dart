import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import 'package:zad_almumin/core/utils/resources/app_constants.dart';

import '../utils/enums/enums.dart';

abstract class IFilesService {
  Future<bool> checkIfTafseerFileDownloaded(int tafseerId);
  Future<bool> checkIfAyahFileDownloaded(int surahNumber, int ayahNumber, QuranReader quranReader);
  String tafseerPath(int id);
  String ayahPath(int surahNumber, int ayahNumber, QuranReader quranReader);
  Future<void> writeDataIntoFileAsBytes(String filePath, List<int> data);
  Future<Map?> getFile(String filePath);
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
  String tafseerPath(int id) {
    return '$_filesDir/tafseer_${AppConstants.context.localeCode}_$id.json';
  }

  @override
  String ayahPath(int surahNumber, int ayahNumber, QuranReader quranReader) {
    return '$_filesDir/quran/${quranReader.name}/${surahNumber.formated3}_${ayahNumber.formated3}.mp3';
  }

  @override
  Future<bool> checkIfTafseerFileDownloaded(int tafseerId) async {
    String filePath = tafseerPath(tafseerId);

    bool exist = await checkIfFileExist(filePath);

    return exist;
  }

  @override
  Future<bool> checkIfAyahFileDownloaded(int surahNumber, int ayahNumber, QuranReader quranReader) async {
    String filePath = ayahPath(surahNumber, ayahNumber, quranReader);

    bool exist = await checkIfFileExist(filePath);

    return exist;
  }

  @override
  Future<void> writeDataIntoFileAsBytes(String filePath, List<int> data) async {
    File file = await File(filePath).create(recursive: true);
    await file.writeAsBytes(data, mode: FileMode.append);
  }

  @override
  Future<Map?> getFile(String filePath) async {
    var file = File(filePath);
    if (await file.exists()) {
      var data = jsonDecode(await file.readAsString());
      return data;
    }
    return null;
  }

  Future<bool> checkIfFileExist(String filePath) {
    var file = File(filePath);
    return file.exists();
  }
}
