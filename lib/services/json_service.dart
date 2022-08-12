import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:zad_almumin/classes/zikr_data.dart';
import 'package:zad_almumin/moduls/enums.dart';

import 'navigation_service.dart';

class JsonService {
  static Future<ZikrData> getQuranData() async {
    await Future.delayed(Duration(milliseconds: 500));

    int randomSure = Random().nextInt(114) + 1;
    String jsonString = await DefaultAssetBundle.of(NavigationService.navigatorKey.currentContext!)
        .loadString('assets/database/quran/surahs/$randomSure.json');
    Map<String, dynamic> data = json.decode(jsonString);
    List<dynamic> allSureAyahs = data['ayahs'];
    int randomAyah = Random().nextInt(allSureAyahs.length);
    if (randomAyah == 0) randomAyah = 1; //dont take the basmalah
    ZikrData zikrData = ZikrData(
      zikrType: ZikrType.quran,
      title: 'اعوذ بالله من الشيطان الرجيم',
      content: allSureAyahs[randomAyah]['text'],
      numberInQuran: allSureAyahs[randomAyah]['numberInQuran'],
      surahNumber: randomSure,
    );
    return zikrData;
  }

  static Future<ZikrData> getSpesificQuranData({required int numberInQuran, required int surahNumber}) async {
    String jsonString = await DefaultAssetBundle.of(NavigationService.navigatorKey.currentContext!)
        .loadString('assets/database/quran/surahs/$surahNumber.json');
    Map<String, dynamic> data = json.decode(jsonString);
    List<dynamic> allSureAyahs = data['ayahs'];
    for (var i = 0; i < allSureAyahs.length; i++) {
      // print(allSureAyahs[i]['numberInQuran']);
      if (allSureAyahs[i]['numberInQuran'] == numberInQuran + 1) {
        return ZikrData(
          zikrType: ZikrType.quran,
          title: 'اعوذ بالله من الشيطان الرجيم',
          content: allSureAyahs[i]['text'],
          numberInQuran: allSureAyahs[i]['numberInQuran'],
          surahNumber: surahNumber,
          isRandomAyah: false,
        );
      }
    }
    return getSpesificQuranData(numberInQuran: numberInQuran, surahNumber: surahNumber + 1);
  }

  static Future<ZikrData> getHadithData() async {
    await Future.delayed(Duration(milliseconds: 500));
    int randomBook = Random().nextInt(20);
    String jsonString = await DefaultAssetBundle.of(NavigationService.navigatorKey.currentContext!)
        .loadString('assets/database/hadith/book_${randomBook + 1}.json');
    Map<String, dynamic> data = json.decode(jsonString);
    List<dynamic> hadithChaptarsMap = data['chaptars'];
    int randomChapter = Random().nextInt(hadithChaptarsMap.length);
    List<dynamic> hadithsMap = hadithChaptarsMap[randomChapter]['hadiths'];
    if (hadithsMap.isEmpty) {
      await getHadithData();
      return ZikrData();
    }
    int randomHadith = Random().nextInt(hadithsMap.length);
    return ZikrData(zikrType: ZikrType.hadith, title: 'حديث عن رسول الله ﷺ', content: hadithsMap[randomHadith]['text']);
  }
}
