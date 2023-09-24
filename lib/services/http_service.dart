import 'dart:io';
import 'package:archive/archive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:zad_almumin/constents/app_settings.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/pages/quran/controllers/quran/quran_page_ctr.dart';
import 'package:zad_almumin/pages/quran/models/quran_data.dart';
import 'package:zad_almumin/services/json_service.dart';
import '../pages/quran/models/ayah.dart';

class HttpService {
  static final HttpCtr _httpCtrl = Get.find<HttpCtr>();
  static final QuranPageCtr _quranCtr = Get.find<QuranPageCtr>();
  static final QuranData _quranData = Get.find<QuranData>();

  static Future<File?> getAyah(
      {required int surahNumber, required int ayahNumber, required String dir, required bool showToast}) async {
    String filePath =
        '$dir/${_quranCtr.selectedPage.selectedQuranReader.value.name}/${AppSettings.formatInt3.format(surahNumber)}${AppSettings.formatInt3.format(ayahNumber)}.mp3';
    File file = File(filePath);
    if (file.existsSync()) return file;
    return await _downloadAyah(
      formatedSurahNumber: AppSettings.formatInt3.format(surahNumber),
      formatedAyahNumber: AppSettings.formatInt3.format(ayahNumber),
      filePath: filePath,
      showToast: showToast,
    );
  }

  static Future<File?> _downloadAyah(
      {required String formatedSurahNumber,
      required String formatedAyahNumber,
      required String filePath,
      bool showToast = false}) async {
    if (showToast) Fluttertoast.showToast(msg: 'جاري تحميل الآية'.tr);
    Map allReaders = await JsonService.getAllReaders();
    String readerUrl = allReaders[_quranCtr.selectedPage.selectedQuranReader.value.name];
    String url = '$readerUrl$formatedSurahNumber$formatedAyahNumber.mp3';
    File file = await File(filePath).create(recursive: true);

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(msg: "لا يوجد اتصال بالانترنت".tr);
      return null;
    } else {
      try {
        var response = await http.Client().get(Uri.parse(url));
        if (response.statusCode == 200) {
          await file.writeAsBytes(response.bodyBytes);
          if (showToast) Fluttertoast.showToast(msg: 'تم تحيل الآية بنجاح'.tr);
        } else {
          if (showToast) Fluttertoast.showToast(msg: 'مشكلة في الاتصال بالانترنت'.tr);
        }
      } catch (e) {
        if (showToast) Fluttertoast.showToast(msg: 'مشكلة في الاتصال بالانترنت'.tr);
      }
      return file;
    }
  }

  /// Download surah ayahs and save it in the device
  static Future<List<Ayah>> getSurah({required int surahNumber, QuranReaders? reader}) async {
    List<Ayah> ayahsList = _quranData.getSurahAyahs(surahNumber);
    String formatedSurahNumber = AppSettings.formatInt3.format(surahNumber);
    bool isDownloadedBefore =
        GetStorage().read('${_quranCtr.selectedPage.selectedQuranReader.value.name}$formatedSurahNumber') ?? false;

    String dir = '${AppSettings.filesDir}/${_quranCtr.selectedPage.selectedQuranReader.value.name}';
    if (isDownloadedBefore) {
      updateAyahsAudioPath(ayahsList, dir, formatedSurahNumber);
      _httpCtrl.downloadComplated.value = true;
    } else {
      var connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.none) {
        Fluttertoast.showToast(msg: "لا يوجد اتصال بالانترنت".tr);
        return ayahsList;
      }

      _httpCtrl.isLoading.value = true;
      _httpCtrl.isStopDownload.value = false;
      _httpCtrl.downloadComplated.value = false;

      Map allReaders = await JsonService.getAllReaders();
      reader ??= _quranCtr.selectedPage.selectedQuranReader.value;
      String readerUrl = allReaders[reader.name];
      String url = '$readerUrl/zips/$formatedSurahNumber.zip';
      try {
        File zippedFile = await _downloadSurah(url, dir, formatedSurahNumber);
        if (!zippedFile.existsSync()) return ayahsList;

        await unArchiveAndSave(zippedFile, dir);

        updateAyahsAudioPath(ayahsList, dir, formatedSurahNumber);
        _quranData.getSurahByNumber(surahNumber).downloadState.value = DownloadState.downloaded;
        dir = '$dir/$formatedSurahNumber.zip';
        removeZipFile(dir);
      } catch (e) {
        Fluttertoast.showToast(msg: '${'مشكلة في الاتصال بالانترنت'}.tr \t $e');
      } finally {
        _httpCtrl.isLoading.value = false;
        _httpCtrl.isStopDownload.value = true;
        _httpCtrl.downloadProgress.value = 0;
      }
    }

    return ayahsList;
  }

  /// Download the ZIP file using the HTTP library
  static Future<File> _downloadSurah(String url, String filePath, String formatedSurahNumber) async {
    if (_httpCtrl.isDownloading.value) {
      Fluttertoast.showToast(msg: 'جاري تحميل سورة أخرى'.tr);
      return File('$filePath/$formatedSurahNumber');
    }
    _httpCtrl.isDownloading.value = true;
    File file = await File('$filePath/$formatedSurahNumber').create(recursive: true);

    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(msg: "لا يوجد اتصال بالانترنت".tr);
      return file;
    } else {
      Fluttertoast.showToast(msg: 'بدء تحميل السورة'.tr);
      try {
        _httpCtrl.downloadProgress.value = 0;
        var response = await http.Client().send(http.Request('GET', Uri.parse(url)));
        int contentLength = response.contentLength ?? 0;
        if (response.statusCode == 200) {
          var receivedBytes = 0;

          await response.stream.forEach(
            (data) {
              if (_httpCtrl.isStopDownload.value) return;

              receivedBytes += data.length;
              final progress = (receivedBytes / contentLength * 100).toStringAsFixed(1);
              _httpCtrl.downloadProgress.value = double.parse(progress);
              file.writeAsBytesSync(data, mode: FileMode.append);
            },
          );

          //download complete
          if (_httpCtrl.downloadProgress.value == 100) {
            GetStorage().write('${_quranCtr.selectedPage.selectedQuranReader.value.name}$formatedSurahNumber', true);
            _httpCtrl.downloadComplated.value = true;

            Fluttertoast.showToast(msg: 'تم تحميل الآية بنجاح'.tr);
          } else {
            Fluttertoast.showToast(msg: 'لم يتم تحميل الآية بنجاح'.tr);
          }
          _httpCtrl.isLoading.value = false;
          _httpCtrl.isStopDownload.value = true;
          _httpCtrl.downloadProgress.value = 0;
        }
      } catch (e) {
        Fluttertoast.showToast(msg: '${'مشكلة في الاتصال بالانترنت'}.tr \t $e');
      }
      _httpCtrl.isDownloading.value = false;
    }

    return file;
  }

  // Unarchive and save the file in Documents directory and save the paths in the array
  static Future unArchiveAndSave(File zippedFile, String dir) async {
    try {
      var bytes = zippedFile.readAsBytesSync();
      var archive = ZipDecoder().decodeBytes(bytes);
      for (var file in archive) {
        var fileName = '$dir/${file.name}';
        if (file.isFile) {
          var outFile = File(fileName);
          outFile = await outFile.create(recursive: true);
          await outFile.writeAsBytes(file.content);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static void removeZipFile(String dir) async {
    try {
      var zipFile = File(dir);
      if (await zipFile.exists()) zipFile.delete();
      var licenseFile = File('$dir/000_license');
      if (await licenseFile.exists()) licenseFile.delete();
    } catch (e) {
      print(e);
    }
  }

  static void updateAyahsAudioPath(List<Ayah> ayahsList, String dir, String formatedSurahNumber) {
    for (int i = 0; i < ayahsList.length; i++) {
      ayahsList[i].audioPath = '$dir/$formatedSurahNumber${AppSettings.formatInt3.format(ayahsList[i].ayahNumber)}.mp3';
    }
  }

  static Future<bool> downloadTafsirById(int tafseerId) async {
    _httpCtrl.isTafseerDownloading.value = true;

    bool downloadedSuccesfuly = false;
    String fileDir = '${AppSettings.filesDir}/tafseer_${AppSettings.selectedLangCode}_$tafseerId.json';
    File zippedFile = File(fileDir);
    try {
      ListResult filesList = await FirebaseStorage.instance.ref('tafseers').listAll();

      Reference? ref = filesList.items.firstWhereOrNull((element) => element.name.contains(tafseerId.toString()));

      if (ref != null) {
        String url = await ref.getDownloadURL();
        // var response = await http.get(Uri.parse(url));
        var response = await http.Client().send(http.Request('GET', Uri.parse(url)));
        int contentLength = response.contentLength ?? 0;
        if (response.statusCode == 200) {
          // await zippedFile.writeAsBytes(response.bodyBytes);

          var receivedBytes = 0;

          _httpCtrl.downloadProgress.value = 0;

          await response.stream.forEach(
            (data) {
              receivedBytes += data.length;
              final progress = (receivedBytes / contentLength * 100).toStringAsFixed(1);
              _httpCtrl.tafseerdownloadProgress.value = double.parse(progress);
              zippedFile.writeAsBytesSync(data, mode: FileMode.append);
            },
          );
          //download complete
          if (_httpCtrl.tafseerdownloadProgress.value == 100) {
            downloadedSuccesfuly = true;
            Fluttertoast.showToast(msg: 'تم تحميل التفسير بنجاح'.tr);
          } else {
            Fluttertoast.showToast(msg: 'لم يتم تحميل التفسير بنجاح'.tr);
          }
          _httpCtrl.downloadProgress.value = 0;
          _httpCtrl.isTafseerDownloading.value = false;
        } else {
          Fluttertoast.showToast(msg: 'لم يتم تحميل التفسير بنجاح'.tr);
        }
      } else {
        Fluttertoast.showToast(msg: 'لم يتم تحميل التفسير بنجاح'.tr);
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: 'لم يتم تحميل التفسير بنجاح'.tr);
    }
    return downloadedSuccesfuly;
  }
}

class HttpCtr extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isStopDownload = false.obs;
  RxDouble downloadProgress = (0.0).obs;
  RxDouble tafseerdownloadProgress = (0.0).obs;
  RxBool downloadComplated = false.obs;
  RxBool isDownloading = false.obs;
  RxBool isTafseerDownloading = false.obs;
}
