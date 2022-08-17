import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../pages/quranPage/classes/surah.dart';
import 'navigation_service.dart';

class HttpService {
  static HttpServiceCtr httpServiceCtrl = Get.find<HttpServiceCtr>();
  static Future<File?> getAyah({required int numberInQuran, required bool showToast}) async {
    return _downloadFile(
        url: 'https://cdn.islamic.network/quran/audio/128/ar.alafasy/$numberInQuran.mp3',
        numberInQuran: numberInQuran,
        showToast: showToast);
  }

  static Future<List<Surah>> getSurah({required int surahNumber}) async {
    List<Surah> list = [];
    String jsonString = await DefaultAssetBundle.of(NavigationService.navigatorKey.currentContext!)
        .loadString('assets/database/quran/surahs/$surahNumber.json');
    Map data = jsonDecode(jsonString);
    List ayahs = data['ayahs'];
    // Fluttertoast.showToast(msg: 'جار فحص وتنزيل ايات السورة');
    httpServiceCtrl.isLoading.value = true;
    httpServiceCtrl.totalAyahsDownload.value = ayahs.length;
    httpServiceCtrl.isStopDownload.value = false;
    for (var i = 0; i < ayahs.length; i++) {
      if (httpServiceCtrl.isStopDownload.value) break;
      int numberInQuran = ayahs[i]['numberInQuran'];
      httpServiceCtrl.downloadingIndex.value = i + 1;
      File? file = await getAyah(numberInQuran: numberInQuran, showToast: false);

      list.add(Surah(file: file!, numberInQuran: numberInQuran));
    }
    httpServiceCtrl.isLoading.value = false;
    return list;
  }

  static Future<File?> _downloadFile({required String url, required int numberInQuran, required bool showToast}) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/${numberInQuran.toString()}.mp3');
    bool exists = await file.exists();
    if (exists) return file;

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

  static Future downloadAllQuranAyahs() async {
    for (var i = 0; i <= 6236; i++) {
      await _downloadFile(
          url: 'https://cdn.islamic.network/quran/audio/128/ar.alafasy/$i.mp3', numberInQuran: i, showToast: false);
    }
  }
}

class HttpServiceCtr extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isStopDownload = false.obs;
  RxDouble received = 0.0.obs;
  RxInt totalAyahsDownload = 0.obs;
  RxInt downloadingIndex = 0.obs;
}
