import 'dart:math';
import 'package:get/get.dart';
import 'package:zad_almumin/classes/helper_methods.dart';
import 'package:zad_almumin/constents/constents.dart';
import 'package:zad_almumin/pages/ayahsTest/controller/ayahs_questions_ctr.dart';
import 'package:zad_almumin/pages/quran/models/ayah.dart';
import 'package:zad_almumin/pages/quran/models/surah.dart';

class QuranData extends GetxController {
  List<Surah> _surahs = [];
  List<List<Ayah>> _pagesFirstAyahs = [];

  bool get isEmpty => _surahs.isEmpty;
  bool get isNotEmpty => _surahs.isNotEmpty;

  bool get questionAyahsisEmpty => _pagesFirstAyahs.isEmpty;
  bool get questionAyahsIsNotEmpty => _pagesFirstAyahs.isNotEmpty;

  ///set surahs in list of surahs
  void setSurahs(List surahsList) {
    List<Surah> surahs = [];
    for (var surah in surahsList) {
      surahs.add(Surah.fromjson(surah));
    }

    _surahs = surahs;
  }

  ///set pages first ayahs in list of list of ayahs
  void setPagesFirstAyahs(List pagesFirstAyahsList) {
    List<List<Ayah>> pagesFirstAyahs = [];
    for (var i = 0; i < pagesFirstAyahsList.length; i++) {
      var juz = pagesFirstAyahsList[i];
      List<Ayah> pageFirstAyahs = [];
      for (var ayahs in juz) {
        pageFirstAyahs.add(Ayah.fromJson(ayahs));
      }
      pagesFirstAyahs.add(pageFirstAyahs);
    }

    _pagesFirstAyahs = pagesFirstAyahs;
  }

  ///giving surah number and ayah number return ayah
  Surah getSurahAt(int surahNumber) => _surahs[surahNumber - 1];

  ///giving surah number and ayah number return ayah
  int getSurahsCount() => _surahs.length;

  ///giving page return surah
  Surah getSurahByPage(int page) {
    Surah surah = Surah(name: '', startAtPage: 0, ayahs: [], number: 0);
    for (var element in _surahs.reversed)
      if (element.startAtPage <= page) {
        surah = element;
        break;
      }
    return surah;
  }

  ///giving page return ayahs in page
  List<List<Ayah>> getAyahsInPage(int page) {
    List<List<Ayah>> allAyahsInPage = [];
    for (var surah in _surahs) {
      List<Ayah> ayahs = [];
      if (surah.ayahs.first.page <= page || surah.ayahs.last.page >= page) {
        for (var ayah in surah.ayahs) {
          if (ayah.page == page) ayahs.add(ayah);
        }
      }
      allAyahsInPage.add(ayahs);
    }
    return allAyahsInPage;
  }

  ///giving surah number return surah
  Surah getSurahByName(String surahName) {
    Surah surah = Surah(name: '', startAtPage: 0, ayahs: [], number: 0);
    for (var i = 0; i < _surahs.length; i++) {
      String dataSuraName = HelperMethods.normalise(_surahs[i].name);
      surahName = HelperMethods.normalise(surahName);
      if (dataSuraName.contains(surahName)) surah = _surahs[i];
    }
    return surah;
  }

  ///giving surah name return matched surahs
  List<Surah> getMatchedSurah(String surahName) {
    List<Surah> surahs = [];
    for (var i = 0; i < _surahs.length; i++) {
      String dataSuraName = HelperMethods.normalise(_surahs[i].name);
      surahName = HelperMethods.normalise(surahName);
      if (dataSuraName.contains(surahName)) surahs.add(_surahs[i]);
    }
    return surahs;
  }

  ///giving surah number return surah
  Surah getSurahByNumber(int surahNumber) {
    Surah surah = Surah(name: '', startAtPage: 0, ayahs: [], number: 0);
    if (surahNumber > 0 && surahNumber <= 114)
      surah = _surahs[surahNumber - 1];
    else
      surah = _surahs[0];
    return surah;
  }

  ///giving surah name return surah number
  int getSurahNumberByName(String surahName) => getSurahByName(surahName).number;

  ///giving page number return surah name
  String getSurahNameByPage(int page) => getSurahByPage(page).name;

  ///giving surah number return surah name
  String getSurahNameByNumber(int surahNumber) => getSurahByNumber(surahNumber).name;

  ///giving surah number return surah ayahs
  List<Ayah> getSurahAyahs(int surahNumber) => getSurahAt(surahNumber).ayahs;

  ///giving surah number and ayah number return ayah
  Ayah getAyah(int surahNumber, int ayahNumber) {
    Surah surah = getSurahAt(surahNumber);
    if (surah.ayahs.length >= ayahNumber)
      return surah.ayahs[ayahNumber - 1];
    else {
      return getRandomAyah();
    }
  }

  ///giving surah number and ayah number return ayah
  Ayah getRandomAyah() {
    int randomSure = Random().nextInt(114) + 1;
    int randomAyah = Random().nextInt(getSurahAt(randomSure).ayahs.length) + 1;
    return getAyah(randomSure, randomAyah);
  }

  ///return random first ayah in page
  Ayah getRandomPageStartAyah() {
    final AyahsQuestionsCtr ctr = Get.find<AyahsQuestionsCtr>();

    int randomJuz = ctr.juzFrom.value - 1;
    if (ctr.juzTo.value != ctr.juzFrom.value)
      randomJuz = (Random().nextInt(ctr.juzTo.value - ctr.juzFrom.value + 1) + ctr.juzFrom.value) - 1;

    int randomPage = ctr.pageFrom.value - 1;
    if (ctr.pageTo.value != ctr.pageFrom.value)
      randomPage = (Random().nextInt(ctr.pageTo.value - ctr.pageFrom.value + 1) + ctr.pageFrom.value) - 1;

    return _pagesFirstAyahs[randomJuz][randomPage];
  }

  ///giving surah number and ayah number return ayah
  int getAyahsCount(int surahNumber) => getSurahAt(surahNumber).ayahs.length;

  ///giving surah number and ayah number return ayah
  String getAyahText(int surahNumber, int ayahNumber) => getAyah(surahNumber, ayahNumber).text;

  ///giving surah number and ayah number return ayah
  String getAyahAudioPath(int surahNumber, int ayahNumber) => getAyah(surahNumber, ayahNumber).audioPath;

  ///giving surah number and ayah number return ayah
  String getAyahAudioUrl(int surahNumber, int ayahNumber) => getAyah(surahNumber, ayahNumber).audioUrl;

  //   int getJuzNumberByPage(int page) {
  //   int juz = 1;
  //   if (page <= 21)
  //     juz = 1;
  //   else if (page <= 41)
  //     juz = 2;
  //   else if (page <= 61)
  //     juz = 3;
  //   else if (page <= 81)
  //     juz = 4;
  //   else if (page <= 101)
  //     juz = 5;
  //   else if (page <= 121)
  //     juz = 6;
  //   else if (page <= 141)
  //     juz = 7;
  //   else if (page <= 161)
  //     juz = 8;
  //   else if (page <= 181)
  //     juz = 9;
  //   else if (page <= 201)
  //     juz = 10;
  //   else if (page <= 221)
  //     juz = 11;
  //   else if (page <= 241)
  //     juz = 12;
  //   else if (page <= 261)
  //     juz = 13;
  //   else if (page <= 281)
  //     juz = 14;
  //   else if (page <= 301)
  //     juz = 15;
  //   else if (page <= 321)
  //     juz = 16;
  //   else if (page <= 341)
  //     juz = 17;
  //   else if (page <= 361)
  //     juz = 18;
  //   else if (page <= 381)
  //     juz = 19;
  //   else if (page <= 401)
  //     juz = 20;
  //   else if (page <= 421)
  //     juz = 21;
  //   else if (page <= 441)
  //     juz = 22;
  //   else if (page <= 461)
  //     juz = 23;
  //   else if (page <= 481)
  //     juz = 24;
  //   else if (page <= 501)
  //     juz = 25;
  //   else if (page <= 521)
  //     juz = 26;
  //   else if (page <= 541)
  //     juz = 27;
  //   else if (page <= 561)
  //     juz = 28;
  //   else if (page <= 581)
  //     juz = 29;
  //   else
  //     juz = 30;
  //   return juz;
  // }

  ///giving page number return juz number
  int getJuzNumberByPage(int page) {
    final juz = (page / 20).ceil();
    return min(juz, 30);
  }

  int getPageInJuz(int page) {
    return page % 20;
  }
}
