import 'dart:io';
import 'package:archive/archive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:zad_almumin/constents/app_settings.dart';
import 'package:zad_almumin/pages/quran/controllers/quran_page_ctr.dart';
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
  static Future<List<Ayah>> getSurah({required int surahNumber}) async {
    List<Ayah> ayahsList = _quranData.getSurahAyahs(surahNumber);
    String formatedSurahNumber = AppSettings.formatInt3.format(surahNumber);
    bool isDownloadedBefore =
        GetStorage().read('${_quranCtr.selectedPage.selectedQuranReader.value.name}$formatedSurahNumber') ?? false;

    String dir =
        '${(await getApplicationDocumentsDirectory()).path}/${_quranCtr.selectedPage.selectedQuranReader.value.name}';
    if (isDownloadedBefore) {
      updateAyahsAudioPath(ayahsList, dir, formatedSurahNumber);
      _httpCtrl.downloadCompated.value = true;
    } else {
      _httpCtrl.isLoading.value = true;
      _httpCtrl.isStopDownload.value = false;
      _httpCtrl.downloadCompated.value = false;

      Map allReaders = await JsonService.getAllReaders();
      String readerUrl = allReaders[_quranCtr.selectedPage.selectedQuranReader.value.name];
      String url = '$readerUrl/zips/$formatedSurahNumber.zip';
      try {
        File zippedFile = await _downloadSurah(url, dir, formatedSurahNumber);
        if (!zippedFile.existsSync()) return ayahsList;

        await unarchiveAndSave(zippedFile, dir);

        updateAyahsAudioPath(ayahsList, dir, formatedSurahNumber);

        removeUnneceseryFiles(dir, formatedSurahNumber);
      } catch (e) {
        Fluttertoast.showToast(msg: '${'مشكلة في الاتصال بالانترنت'}.tr \t $e');
      }
    }

    return ayahsList;
  }

  /// Download the ZIP file using the HTTP library
  static Future<File> _downloadSurah(String url, String filePath, String formatedSurahNumber) async {
    Fluttertoast.showToast(msg: 'جاري تحميل الآية'.tr);

    File file = await File('$filePath/$formatedSurahNumber').create(recursive: true);

    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(msg: "لا يوجد اتصال بالانترنت".tr);
      return file;
    } else {
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
            _httpCtrl.downloadCompated.value = true;
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
    }

    return file;
  }

  // Unarchive and save the file in Documents directory and save the paths in the array
  static Future unarchiveAndSave(File zippedFile, String dir) async {
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
  }

  static void removeUnneceseryFiles(String dir, String formatedSurahNumber) async {
    var zipFile = File('$dir/$formatedSurahNumber.zip');
    if (await zipFile.exists()) zipFile.delete();
    var licenseFile = File('$dir/000_license');
    if (await licenseFile.exists()) licenseFile.delete();
  }

  static void updateAyahsAudioPath(List<Ayah> ayahsList, String dir, String formatedSurahNumber) {
    for (int i = 0; i < ayahsList.length; i++) {
      ayahsList[i].audioPath = '$dir/$formatedSurahNumber${AppSettings.formatInt3.format(ayahsList[i].ayahNumber)}.mp3';
    }
  }
}

class HttpCtr extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isStopDownload = false.obs;
  RxDouble downloadProgress = (0.0).obs;
  RxBool downloadCompated = false.obs;
}
