import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:zad_almumin/constents/constents.dart';
import 'package:zad_almumin/pages/quran/controllers/quran_page_ctr.dart';
import 'package:zad_almumin/pages/quran/models/quran_data.dart';
import 'package:zad_almumin/services/json_service.dart';
import '../pages/quran/models/ayah.dart';

class HttpService {
  static final HttpCtr _httpServiceCtrl = Get.find<HttpCtr>();
  static final QuranPageCtr _quranCtr = Get.find<QuranPageCtr>();

  static final QuranData _quranData = Get.find<QuranData>();
  static Future<List<Ayah>> getSurah({required int surahNumber}) async {
    bool isDownloadedBefore =
        GetStorage().read('${_quranCtr.selectedSurah.selectedQuranReader.value.name}$surahNumber') ?? false;

    String dir = (await getApplicationDocumentsDirectory()).path;

    List<Ayah> ayahsList = [];
    if (!isDownloadedBefore) {
      _httpServiceCtrl.totalAyahsDownload.value = _quranCtr.selectedSurah.totalAyahsNum.value;
      _httpServiceCtrl.isLoading.value = true;
      _httpServiceCtrl.isStopDownload.value = false;
    }
    for (var i = 1; i <= _quranCtr.selectedSurah.totalAyahsNum.value; i++) {
      if (!isDownloadedBefore && _httpServiceCtrl.isStopDownload.value) break;

      String formatedAyahNumber = Constants.formatInt3.format(i);
      String formatedSurahNumber = Constants.formatInt3.format(surahNumber);
      String filePath =
          '$dir/${_quranCtr.selectedSurah.selectedQuranReader.value.name}/$formatedSurahNumber$formatedAyahNumber.mp3';
      File file = File(filePath);

      if (!isDownloadedBefore) {
        _httpServiceCtrl.downloadingIndex.value = i + 1;
        bool exists = await file.exists();
        if (!exists)
          file = await _downloadFile(
                formatedSurahNumber: formatedSurahNumber,
                formatedAyahNumber: formatedAyahNumber,
                filePath: filePath,
                showToast: false,
              ) ??
              file;
      }
      Ayah newAyah = Ayah(
        ayahNumber: i,
        audioUrl: '',
        text: '',
        juz: 0,
        page: 0,
        haveSajda: false,
        audioPath: filePath,
        surahName: '',
        surahNumber: surahNumber,
      );
      ayahsList.add(newAyah);
    }
    if (!isDownloadedBefore) {
      _httpServiceCtrl.isLoading.value = false;
      if (ayahsList.length == _quranCtr.selectedSurah.totalAyahsNum.value) {
        GetStorage().write('${_quranCtr.selectedSurah.selectedQuranReader.value.name}$surahNumber', true);
      }
    }
    return ayahsList;
  }

  static Future<File?> getAyah(
      {required int surahNumber, required int ayahNumber, required String dir, required bool showToast}) async {
    String filePath =
        '$dir/${_quranCtr.selectedSurah.selectedQuranReader.value.name}/${Constants.formatInt3.format(surahNumber)}${Constants.formatInt3.format(ayahNumber)}.mp3';
    File file = File(filePath);
    bool exists = await file.exists();
    if (exists) return file;
    return await _downloadFile(
        formatedSurahNumber: Constants.formatInt3.format(surahNumber),
        formatedAyahNumber: Constants.formatInt3.format(ayahNumber),
        filePath: filePath,
        showToast: showToast);
  }

  static Future<File?> _downloadFile(
      {required String formatedSurahNumber,
      required String formatedAyahNumber,
      required String filePath,
      bool showToast = false}) async {
    Map allReaders = await JsonService.getAllReaders();
    String readerUrl = allReaders[_quranCtr.selectedSurah.selectedQuranReader.value.name];
    String url = '$readerUrl$formatedSurahNumber$formatedAyahNumber.mp3';
    File file = await File(filePath).create(recursive: true);

    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      Fluttertoast.showToast(msg: "لا يوجد اتصال بالانترنت");
      return null;
    } else {
      // try {
      //   var response = await http.Client().send(http.Request('GET', Uri.parse(url)));
      //   int total = response.contentLength ?? 0;

      //   final List<int> bytes = [];
      //   _httpServiceCtrl.received.value = 0;
      //   response.stream.listen((value) {
      //     bytes.addAll(value);
      //     _httpServiceCtrl.received.value += 1 / (total / value.length);
      //   }).onDone(() async {
      //     await file.writeAsBytes(bytes);
      //     if (showToast) Fluttertoast.showToast(msg: 'تم تحميل الاية بنجاح');
      //   });
      // } catch (e) {
      //   if (showToast) Fluttertoast.showToast(msg: 'مشكلة في الاتصال بالانترنت');
      // }
      try {
        var response = await http.Client().get(Uri.parse(url));
        if (response.statusCode == 200) {
          await file.writeAsBytes(response.bodyBytes);
          if (showToast) Fluttertoast.showToast(msg: 'تم تحيل الاية بنجاح');
        } else {
          if (showToast) Fluttertoast.showToast(msg: 'مشكلة في الاتصال بالانترنت');
        }
      } catch (e) {
        if (showToast) Fluttertoast.showToast(msg: 'مشكلة في الاتصال بالانترنت');
      }
      return file;
    }
  }
}

class HttpCtr extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isStopDownload = false.obs;
  RxDouble received = 0.0.obs;
  RxInt totalAyahsDownload = 0.obs;
  RxInt downloadingIndex = 0.obs;
}
