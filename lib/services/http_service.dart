import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:zad_almumin/pages/quranPage/controllers/quran_page_ctr.dart';

import '../constents/constents.dart';
import '../pages/quranPage/classes/ayah.dart';

class HttpService {
  static HttpServiceCtr httpServiceCtrl = Get.find<HttpServiceCtr>();

  static Future<List<Ayah>> getSurah({required int surahNumber}) async {
    bool isDownloadedBefore =
        GetStorage().read('${Get.find<QuranPageCtr>().selectedQuranReader.value.name}$surahNumber') ?? false;

    String dir = (await getApplicationDocumentsDirectory()).path;

    List<Ayah> ayahsList = [];
    if (!isDownloadedBefore) {
      httpServiceCtrl.totalAyahsDownload.value = Get.find<QuranPageCtr>().totalAyahsCount.value;
      httpServiceCtrl.isLoading.value = true;
      httpServiceCtrl.isStopDownload.value = false;
    }
    for (var i = 1; i <= Get.find<QuranPageCtr>().totalAyahsCount.value; i++) {
      if (!isDownloadedBefore && httpServiceCtrl.isStopDownload.value) break;

      Ayah newAyah = Ayah(file: File(''), surahNumber: surahNumber, ayahNumber: i);
      String filePath =
          '$dir/${Get.find<QuranPageCtr>().selectedQuranReader.value.name}/${newAyah.formatedSurahNumber}${newAyah.formatedAyahNumber}.mp3';

      newAyah.file = File(filePath);
      if (!isDownloadedBefore) {
        httpServiceCtrl.downloadingIndex.value = i + 1;
        bool exists = await newAyah.file.exists();
        if (!exists)
          newAyah.file = await _downloadFile(ayah: newAyah, filePath: filePath, showToast: false) ?? newAyah.file;
      }
      ayahsList.add(newAyah);
    }
    if (!isDownloadedBefore) {
      httpServiceCtrl.isLoading.value = false;
      if (ayahsList.length == Get.find<QuranPageCtr>().totalAyahsCount.value) {
        GetStorage().write('${Get.find<QuranPageCtr>().selectedQuranReader.value.name}$surahNumber', true);
      }
    }
    return ayahsList;
  }

  static Future<File?> getAyah({required Ayah ayah, required String dir, required bool showToast}) async {
    String filePath =
        '$dir/${Get.find<QuranPageCtr>().selectedQuranReader.value.name}/${ayah.formatedSurahNumber}${ayah.formatedAyahNumber}.mp3';
    File file = File(filePath);
    bool exists = await file.exists();
    if (exists) return file;
    return await _downloadFile(ayah: ayah, filePath: filePath, showToast: showToast);
  }

  static Future<File?> _downloadFile({required Ayah ayah, required String filePath, bool showToast = false}) async {
    String jsonString = await DefaultAssetBundle.of(Constants.navigatorKey.currentContext!)
        .loadString('assets/database/quran/readers_url.json');
    Map data = jsonDecode(jsonString);
    String readerUrl = data[Get.find<QuranPageCtr>().selectedQuranReader.value.name];
    String url = '$readerUrl${ayah.formatedSurahNumber}${ayah.formatedAyahNumber}.mp3';
    File file = await File(filePath).create(recursive: true);
    // var result = await Connectivity().checkConnectivity();
    // if (result == ConnectivityResult.none) {
    //   Fluttertoast.showToast(msg: "لا يوجد اتصال بالانترنت");
    //   return null;
    // } else {
    try {
      // http.Response response = await http.get(Uri.parse(url)); //downlaod the file
      var response = await http.Client().send(http.Request('GET', Uri.parse(url)));
      int total = response.contentLength ?? 0;

      final List<int> bytes = [];
      httpServiceCtrl.received.value = 0;
      response.stream.listen((value) {
        bytes.addAll(value);
        httpServiceCtrl.received.value += 1 / (total / value.length);
      }).onDone(() async {
        await file.writeAsBytes(bytes);
        if (showToast) Fluttertoast.showToast(msg: 'تم تحميل الاية بنجاح');
      });
    } catch (e) {
      if (showToast) Fluttertoast.showToast(msg: 'مشكلة في الاتصال بالانترنت');
    }
    return file;
    // }
  }
}

class HttpServiceCtr extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isStopDownload = false.obs;
  RxDouble received = 0.0.obs;
  RxInt totalAyahsDownload = 0.obs;
  RxInt downloadingIndex = 0.obs;
}
