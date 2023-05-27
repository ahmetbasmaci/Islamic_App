import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/classes/zikr_data.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/pages/quran/models/quran_data.dart';

class JsonService {
  // static List allQuranData = [];
  static final QuranData _quranData = Get.find<QuranData>();
  static List allHadithData = [];
  static List allZikrDataList = [];
  static List allAllahNamesList = [];
  static Map allReaders = {};

  static Future loadData() async {
    await loadQuranData();
    await loadHadithData();
    await loadZikrData();
    await loadAllahNamesData();
    await loadAllReaders();
  }

  static Future loadQuranData() async {
    if (_quranData.isEmpty) {
      String jsonString = await rootBundle.loadString('assets/database/quran/allQuran.json');
      List data = json.decode(jsonString);
      _quranData.setSurahs(data);
    }

    if (_quranData.questionAyahsisEmpty) {
      String jsonString = await rootBundle.loadString('assets/database/quran/first_ayahs_from_each_page.json');
      List juzs = json.decode(jsonString);
      _quranData.setPagesFirstAyahs(juzs);
    }
  }

  static Future loadHadithData() async {
    if (allHadithData.isNotEmpty) return;
    String jsonString = await rootBundle.loadString('assets/database/hadith/allHadith.json');
    allHadithData = json.decode(jsonString);
  }

  static Future loadZikrData() async {
    if (allZikrDataList.isNotEmpty) return;
    String jsonString = await rootBundle.loadString('assets/database/azkar/allazkar.json');
    Map data = json.decode(jsonString);
    allZikrDataList = data['allAzkar'];
  }

  static Future loadAllahNamesData() async {
    if (allAllahNamesList.isNotEmpty) return;
    String jsonString = await rootBundle.loadString('assets/database/azkar/allahNames.json');
    dynamic data = jsonDecode(jsonString);
    allAllahNamesList = data['list'];
  }

  static Future loadAllReaders() async {
    if (allReaders.isNotEmpty) return;
    var allReadersString = await rootBundle.loadString('assets/database/quran/readers_url.json');
    allReaders = jsonDecode(allReadersString);
  }

  
  static Future<Map> getAllHadithData(int bookNumber) async {
    if (allHadithData.isEmpty) await loadHadithData();
    return allHadithData[bookNumber - 1];
  }

  static Future<ZikrData> getRandomHadith()async  {
    if (allHadithData.isEmpty)
      await loadHadithData();
    else
      await Future.delayed(Duration(milliseconds: 200));

    int randomBook = Random().nextInt(20) + 1;
    Map<String, dynamic> hadithBookData = allHadithData[randomBook - 1];
    List<dynamic> hadithChaptarsMap = hadithBookData['chaptars'];

    int randomChapter = Random().nextInt(hadithChaptarsMap.length);
    List hadithsMap = hadithChaptarsMap[randomChapter]['hadiths'];
    if (hadithsMap.isEmpty) return  getRandomHadith();

    int randomHadith = Random().nextInt(hadithsMap.length);
    return ZikrData(zikrType: ZikrType.hadith, title: 'حديث عن رسول الله ﷺ', content: hadithsMap[randomHadith]['text']);
  }

  static Future<List<ZikrData>> getRandomAzkar({required int zikrIndexInJson}) async {
    if (allZikrDataList.isEmpty) await loadZikrData();

    List<ZikrData> zikrDataList = [];

    List<dynamic> azkarList = allZikrDataList[zikrIndexInJson]['azkarList'];
    for (int i = 0; i < azkarList.length; i++) {
      zikrDataList.add(ZikrData(
        zikrType: ZikrType.azkar,
        title: azkarList[i]['title'] ?? "",
        content: azkarList[i]['zekr'] ?? "",
        count: (azkarList[i]['count'] == '' || azkarList[i]['count'] == null) ? 1 : int.parse(azkarList[i]['count']),
        description: azkarList[i]['description'] ?? "",
        haveList: azkarList[i]['haveList'] ?? false,
        list: azkarList[i]['list'] ?? [],
      ));
    }
    return zikrDataList;
  }

  static String getRandomZikr()  {

    int randomZikrIndex = Random().nextInt(allZikrDataList.length);

    List<dynamic> azkarList = allZikrDataList[randomZikrIndex]['azkarList'];
    int randomAzkarIndex = Random().nextInt(azkarList.length);
    String zikr = azkarList[randomAzkarIndex]['zekr'];

    return zikr;
  }

  static Future<List<ZikrData>> getAllahNames() async {
    if (allAllahNamesList.isEmpty) await loadAllahNamesData();

    List<ZikrData> allahNamesList = [];
    for (var i = 0; i < allAllahNamesList.length; i++) {
      allahNamesList.add(
        ZikrData(
          zikrType: ZikrType.allahNames,
          title: allAllahNamesList[i]['name'],
          content: allAllahNamesList[i]['content'],
        ),
      );
    }
    return allahNamesList;
  }

  static Future<Map> getAllReaders() async {
    if (allReaders.isEmpty) await loadAllReaders();

    return allReaders;
  }
}
