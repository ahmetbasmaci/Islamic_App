import 'dart:convert';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import 'package:zad_almumin/core/utils/resources/app_constants.dart';
import '../utils/enums/enums.dart';
import 'package:path/path.dart' as p;

abstract class IFilesService {
  Future<bool> checkIfTafseerFileDownloaded(int tafseerId);
  Future<bool> checkIfAyahFileDownloaded(int surahNumber, int ayahNumber, QuranReader quranReader);
  Future<bool> checkIfSurahFileDownloaded(int surahNumber, QuranReader quranReader);
  String tafseerPath(int id);
  String ayahPath(int surahNumber, int ayahNumber, QuranReader quranReader);
  String surahPath(int surahNumber, QuranReader quranReader);
  String ayahFromSurahPath(int surahNumber, int ayahNumber, QuranReader quranReader);
  Future<void> writeDataIntoFileAsBytes(String filePath, List<int> data);
  Future<Map?> getFile(String filePath);
  Future unArchiveAndSave(String filePath);
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
    return '$_filesDir/quran_ayahs/${quranReader.name}/${surahNumber.formated3}_${ayahNumber.formated3}.mp3';
  }

  @override
  String surahPath(int surahNumber, QuranReader quranReader) {
    return '$_filesDir/quran_surahs/${quranReader.name}/${surahNumber.formated3}.zib';
  }

  @override
  String ayahFromSurahPath(int surahNumber, int ayahNumber, QuranReader quranReader) {
    return '$_filesDir/quran_surahs/${quranReader.name}/${surahNumber.formated3}${ayahNumber.formated3}.mp3';
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
  Future<bool> checkIfSurahFileDownloaded(int surahNumber, QuranReader quranReader) async {
    String filePath = surahPath(surahNumber, quranReader);

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

  @override
  Future unArchiveAndSave(String filePath) async {
    File zippedFile = File(filePath);
    var bytes = zippedFile.readAsBytesSync();
    var archive = ZipDecoder().decodeBytes(bytes);
    for (var file in archive) {
      var fileNameWithoutExtension = '_${p.basenameWithoutExtension(filePath)}'; // Get the file name without extension
      var directory = p.dirname(filePath); // Get the directory part of the path
      var folder = Directory(directory);
      await folder.create(recursive: true);
      // directory += '/$fileNameWithoutExtension';
      // folder = Directory(directory);
      // await folder.create(recursive: true);
      var fileName = '$directory/${file.name}'; // Construct the new file path
      if (file.isFile) {
        var outFile = File(fileName);
        outFile = await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content);
      }
    }
  }

  // @override
  // Future unArchiveAndSave(String filePath) async {
  //   File zippedFile = File(filePath);
  //   var bytes = zippedFile.readAsBytesSync();
  //   var archive = ZipDecoder().decodeBytes(bytes);
  //   for (var file in archive) {
  //     filePath = filePath.replaceAll('.zib', '');
  //     var folder = Directory(filePath);
  //     await folder.create(recursive: true);
  //     var fileName = '$filePath/${file.name}';
  //     if (file.isFile) {
  //       var outFile = File(fileName);
  //       outFile = await outFile.create(recursive: true);
  //       await outFile.writeAsBytes(file.content);
  //     }
  //   }
  // }
}
