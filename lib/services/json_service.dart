import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/classes/zikr_data.dart';
import 'package:zad_almumin/moduls/enums.dart';

import '../pages/ayahsTest/classes/ayah_prop.dart';
import '../pages/ayahsTest/controller/ayahs_questions_ctr.dart';

class JsonService {
  static List allQuranData = [];
  static List allHadithData = [];
  JsonService() {
    loadHadithData();
    loadQuranData();
  }
  static loadQuranData() async {
    if (allQuranData.isNotEmpty) return;
    String jsonString =
        await DefaultAssetBundle.of(Get.key.currentContext!).loadString('assets/database/quran/allQuran.json');
    allQuranData = json.decode(jsonString);
  }

  static loadHadithData() async {
    if (allHadithData.isNotEmpty) return;
    String jsonString =
        await DefaultAssetBundle.of(Get.key.currentContext!).loadString('assets/database/hadith/allHadith.json');
    allHadithData = json.decode(jsonString);
  }

  static Future<ZikrData> getRandomQuranAyah() async {
    if (allQuranData.isEmpty)
      await loadQuranData();
    else
      await Future.delayed(Duration(milliseconds: 300));

    int randomSure = Random().nextInt(114) + 1;

    Map<String, dynamic> surahData = allQuranData[randomSure - 1];

    List<dynamic> allSureAyahs = surahData['ayahs'];
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

  static Future<ZikrData> getSpesificQuranAyah({required int ayahNumber, required int surahNumber}) async {
    Map<String, dynamic> surahData = allQuranData[surahNumber - 1];

    List<dynamic> allSureAyahs = surahData['ayahs'];
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
    return await getRandomQuranAyah();
  }

  static Future<AyahProp> getAyahForQuestion(BuildContext context) async {
    final AyahsQuestionsCtr ctr = Get.find<AyahsQuestionsCtr>();

    String jsonString =
        await DefaultAssetBundle.of(context).loadString('assets/database/quran/first_ayahs_from_each_page.json');

    List juzs = json.decode(jsonString);

    int randomJuz = ctr.juzFrom.value - 1;
    if (ctr.juzTo.value != ctr.juzFrom.value)
      randomJuz = Random().nextInt(ctr.juzTo.value - ctr.juzFrom.value) + ctr.juzFrom.value;

    int randomPage = ctr.pageFrom.value - 1;
    if (ctr.pageTo.value != ctr.pageFrom.value)
      randomPage = Random().nextInt(ctr.pageTo.value - ctr.pageFrom.value) + ctr.pageFrom.value;

    AyahProp selectedAyah = AyahProp.fromJson(juzs[randomJuz][randomPage]);
    return selectedAyah;
  }

  static Future<Map> getAllQuranData(int surahNUmber) async {
    if (allQuranData.isEmpty) await loadQuranData();
    return allQuranData[surahNUmber - 1];
  }

  static Future<Map> getAllHadithData(int bookNumber) async {
    if (allHadithData.isEmpty) await loadHadithData();
    return allHadithData[bookNumber - 1];
  }

  static Future<ZikrData> getHadithData() async {
    if (allHadithData.isEmpty)
      await loadHadithData();
    else
      await Future.delayed(Duration(milliseconds: 300));

    int randomBook = Random().nextInt(20) + 1;
    Map<String, dynamic> hadithBookData = allHadithData[randomBook - 1];
    List<dynamic> hadithChaptarsMap = hadithBookData['chaptars'];

    int randomChapter = Random().nextInt(hadithChaptarsMap.length);
    List hadithsMap = hadithChaptarsMap[randomChapter]['hadiths'];
    if (hadithsMap.isEmpty) return await getHadithData();

    int randomHadith = Random().nextInt(hadithsMap.length);
    return ZikrData(zikrType: ZikrType.hadith, title: 'حديث عن رسول الله ﷺ', content: hadithsMap[randomHadith]['text']);
  }
}
