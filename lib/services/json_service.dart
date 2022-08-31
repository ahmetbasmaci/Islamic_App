import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:zad_almumin/classes/zikr_data.dart';
import 'package:zad_almumin/constents/constents.dart';
import 'package:zad_almumin/moduls/enums.dart';

class JsonService {

  static Map<String, dynamic> quranData = {};
  static Map<String, dynamic> hadithData = {};
  static Future<ZikrData> getQuranData() async {
    await Future.delayed(Duration(milliseconds: 500));

    int randomSure = Random().nextInt(114) + 1;
    quranData = await readQuranJson(randomSure);

    List<dynamic> allSureAyahs = quranData['ayahs'];
    int randomAyah = Random().nextInt(allSureAyahs.length);
    ZikrData zikrData = ZikrData(
      zikrType: ZikrType.quran,
      title: 'اعوذ بالله من الشيطان الرجيم',
      content: allSureAyahs[randomAyah]['text'],
      ayahNumber: allSureAyahs[randomAyah]['numberInSurah'],
      surahNumber: randomSure,
    );
    return zikrData;
  }

  static Future<ZikrData> getSpesificQuranData({required int ayahNumber, required int surahNumber}) async {
    if (quranData.isEmpty) quranData = await readQuranJson(surahNumber);
    List<dynamic> allSureAyahs = quranData['ayahs'];
    for (var i = 0; i < allSureAyahs.length; i++) {
      if (allSureAyahs[i]['numberInSurah'] == ayahNumber + 1) {
        return ZikrData(
          zikrType: ZikrType.quran,
          title: 'اعوذ بالله من الشيطان الرجيم',
          content: allSureAyahs[i]['text'],
          ayahNumber: allSureAyahs[i]['numberInSurah'],
          surahNumber: surahNumber,
          isRandomAyah: false,
        );
      }
    }
    return getSpesificQuranData(ayahNumber: ayahNumber, surahNumber: Random().nextInt(114) + 1);
  }

  static Future<ZikrData> getHadithData() async {
    await Future.delayed(Duration(milliseconds: 500));
    int randomBook = Random().nextInt(20) + 1;
    if (hadithData.isEmpty) hadithData = await readHadithJson(randomBook);
    List<dynamic> hadithChaptarsMap = hadithData['chaptars'];
    int randomChapter = Random().nextInt(hadithChaptarsMap.length);
    List<dynamic> hadithsMap = hadithChaptarsMap[randomChapter]['hadiths'];
    if (hadithsMap.isEmpty) {
      await getHadithData();
      return ZikrData();
    }
    int randomHadith = Random().nextInt(hadithsMap.length);
    return ZikrData(zikrType: ZikrType.hadith, title: 'حديث عن رسول الله ﷺ', content: hadithsMap[randomHadith]['text']);
  }

  static Future<Map<String, dynamic>> readQuranJson(int surahNumber) async {
    String jsonString = await DefaultAssetBundle.of(Constants.navigatorKey.currentContext!)
        .loadString('assets/database/quran/surahs/$surahNumber.json');
    Map<String, dynamic> data = json.decode(jsonString);
    return data;
  }

  static Future<Map<String, dynamic>> readHadithJson(int bookNumber) async {
    String jsonString = await DefaultAssetBundle.of(Constants.navigatorKey.currentContext!)
        .loadString('assets/database/hadith/book_$bookNumber.json');
    Map<String, dynamic> data = json.decode(jsonString);
    return data;
  }
}
