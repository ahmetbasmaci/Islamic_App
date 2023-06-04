import 'dart:math';
import 'package:get/get.dart';
import 'package:zad_almumin/classes/helper_methods.dart';
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

  int getSurahsCount() => _surahs.length;

  ///set surahs in list of surahs
  void setSurahs(List surahsList) {
    List<Surah> surahs = [];
    for (var surah in surahsList) {
      surahs.add(Surah.fromjson(surah));
    }
    _surahs = surahs;
  }

  ///set pages first ayahs in list of list of ayahs(Without removing basmalah)
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

  ///get all surahs
  List<Surah> getAllSurahs() => _surahs;

  ///giving page return surah
  String getSurahNameByPage(int page) {
    String surahName = "";
    for (var surah in _surahs) {
      if (surah.ayahs.first.page <= page && surah.ayahs.last.page >= page) {
        surahName = surah.name;
        break;
      }
    }
    return surahName;
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

  ///giving surah number return surah name
  String getSurahNameByNumber(int surahNumber) => getSurahByNumber(surahNumber).name;

  ///giving surah number return surah ayahs
  List<Ayah> getSurahAyahs(int surahNumber) => getSurahByNumber(surahNumber).ayahs;

  ///giving page return ayahs in page
  List<List<Ayah>> getAyahsInPage(int page) {
    List<List<Ayah>> allAyahsInPage = [];
    for (var surah in _surahs) {
      List<Ayah> ayahs = [];
      if (surah.ayahs.first.page <= page && surah.ayahs.last.page >= page) {
        for (var ayah in surah.ayahs) {
          if (ayah.page == page) ayahs.add(ayah);
        }
        allAyahsInPage.add(ayahs);
      }
    }
    return allAyahsInPage;
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

  ///giving surah number and ayah number return ayah
  Ayah getAyah(int surahNumber, int ayahNumber) {
    List<Ayah> ayahs = getSurahByNumber(surahNumber).ayahs;
    if (ayahs.length > ayahNumber)
      return ayahs.elementAt(ayahNumber);
    else {
      return getRandomAyah();
    }
  }

  ///giving surah number and ayah number return ayah
  Ayah getRandomAyah() {
    int randomSure = Random().nextInt(114) + 1;
    int randomAyah = Random().nextInt(getAyahsCount(randomSure)) + 1;
    return getAyah(randomSure, randomAyah);
  }

  ///giving surah number and ayah number return ayah
  int getAyahsCount(int surahNumber) => getSurahByNumber(surahNumber).ayahs.length;

  ///giving surah number and ayah number return ayah
  String getAyahText(int surahNumber, int ayahNumber) => getAyah(surahNumber, ayahNumber).text;

  ///giving surah number and ayah number return ayah
  String getAyahAudioPath(int surahNumber, int ayahNumber) => getAyah(surahNumber, ayahNumber).audioPath;

  ///giving surah number and ayah number return ayah
  String getAyahAudioUrl(int surahNumber, int ayahNumber) => getAyah(surahNumber, ayahNumber).audioUrl;

  ///giving page number return juz number
  int getJuzNumberByPage(int page) {
    final juz = (page / 20).ceil();
    return min(juz, 30);
  }

  int getPageInJuz(int page) => page % 20;

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
}
