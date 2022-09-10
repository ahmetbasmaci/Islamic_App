import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/constents.dart';
import 'package:zad_almumin/pages/quran/classes/searched_ayah.dart';
import 'package:zad_almumin/pages/quran/classes/surah.dart';
import 'package:zad_almumin/services/json_service.dart';
import '../../../constents/colors.dart';
import '../classes/marked_page.dart';
import '../controllers/quran_page_ctr.dart';

class QuranHelper {
  QuranPageCtr quranCtr = Get.find<QuranPageCtr>();
  List<Surah> allSurahsNames = [
    Surah(name: 'الفاتحة', numberOfPage: 1),
    Surah(name: 'البقرة', numberOfPage: 2),
    Surah(name: 'آل عمران', numberOfPage: 50),
    Surah(name: 'النساء', numberOfPage: 77),
    Surah(name: 'المائدة', numberOfPage: 106),
    Surah(name: 'الأنعام', numberOfPage: 128),
    Surah(name: 'الأعراف', numberOfPage: 151),
    Surah(name: 'الأنفال', numberOfPage: 177),
    Surah(name: 'التوبة', numberOfPage: 187),
    Surah(name: 'يونس', numberOfPage: 208),
    Surah(name: 'هود', numberOfPage: 221),
    Surah(name: 'يوسف', numberOfPage: 235),
    Surah(name: 'الرعد', numberOfPage: 249),
    Surah(name: 'ابراهيم', numberOfPage: 255),
    Surah(name: 'الحجر', numberOfPage: 262),
    Surah(name: 'النحل', numberOfPage: 267),
    Surah(name: 'الإسراء', numberOfPage: 282),
    Surah(name: 'الكهف', numberOfPage: 293),
    Surah(name: 'مريم', numberOfPage: 305),
    Surah(name: 'طه', numberOfPage: 312),
    Surah(name: 'الأنبياء', numberOfPage: 322),
    Surah(name: 'الحج', numberOfPage: 332),
    Surah(name: 'المؤمنون', numberOfPage: 342),
    Surah(name: 'النور', numberOfPage: 350),
    Surah(name: 'الفرقان', numberOfPage: 359),
    Surah(name: 'الشعراء', numberOfPage: 367),
    Surah(name: 'النمل', numberOfPage: 377),
    Surah(name: 'القصص', numberOfPage: 385),
    Surah(name: 'العنكبوت', numberOfPage: 396),
    Surah(name: 'الروم', numberOfPage: 404),
    Surah(name: 'لقمان', numberOfPage: 411),
    Surah(name: 'السجدة', numberOfPage: 415),
    Surah(name: 'الأحزاب', numberOfPage: 418),
    Surah(name: 'سبأ', numberOfPage: 428),
    Surah(name: 'فاطر', numberOfPage: 434),
    Surah(name: 'يس', numberOfPage: 440),
    Surah(name: 'الصافات', numberOfPage: 446),
    Surah(name: 'ص', numberOfPage: 453),
    Surah(name: 'الزمر', numberOfPage: 458),
    Surah(name: 'غافر', numberOfPage: 467),
    Surah(name: 'فصلت', numberOfPage: 477),
    Surah(name: 'الشورى', numberOfPage: 483),
    Surah(name: 'الزخرف', numberOfPage: 489),
    Surah(name: 'الدخان', numberOfPage: 496),
    Surah(name: 'الجاثية', numberOfPage: 499),
    Surah(name: 'الأحقاف', numberOfPage: 502),
    Surah(name: 'محمد', numberOfPage: 507),
    Surah(name: 'الفتح', numberOfPage: 511),
    Surah(name: 'الحجرات', numberOfPage: 515),
    Surah(name: 'ق', numberOfPage: 518),
    Surah(name: 'الذاريات', numberOfPage: 520),
    Surah(name: 'الطور', numberOfPage: 523),
    Surah(name: 'النجم', numberOfPage: 526),
    Surah(name: 'القمر', numberOfPage: 528),
    Surah(name: 'الرحمن', numberOfPage: 531),
    Surah(name: 'الواقعة', numberOfPage: 534),
    Surah(name: 'الحديد', numberOfPage: 537),
    Surah(name: 'المجادلة', numberOfPage: 542),
    Surah(name: 'الحشر', numberOfPage: 545),
    Surah(name: 'الممتحنة', numberOfPage: 549),
    Surah(name: 'الصف', numberOfPage: 551),
    Surah(name: 'الجمعة', numberOfPage: 553),
    Surah(name: 'المنافقون', numberOfPage: 554),
    Surah(name: 'التغابن', numberOfPage: 556),
    Surah(name: 'الطلاق', numberOfPage: 558),
    Surah(name: 'التحريم', numberOfPage: 560),
    Surah(name: 'الملك', numberOfPage: 562),
    Surah(name: 'القلم', numberOfPage: 564),
    Surah(name: 'الحاقة', numberOfPage: 566),
    Surah(name: 'المعارج', numberOfPage: 568),
    Surah(name: 'نوح', numberOfPage: 570),
    Surah(name: 'الجن', numberOfPage: 572),
    Surah(name: 'المزمل', numberOfPage: 574),
    Surah(name: 'المدثر', numberOfPage: 575),
    Surah(name: 'القيامة', numberOfPage: 577),
    Surah(name: 'الانسان', numberOfPage: 578),
    Surah(name: 'المرسلات', numberOfPage: 580),
    Surah(name: 'النبأ', numberOfPage: 582),
    Surah(name: 'النازعات', numberOfPage: 583),
    Surah(name: 'عبس', numberOfPage: 585),
    Surah(name: 'التكوير', numberOfPage: 586),
    Surah(name: 'الإنفطار', numberOfPage: 587),
    Surah(name: 'المطففين', numberOfPage: 587),
    Surah(name: 'الإنشقاق', numberOfPage: 589),
    Surah(name: 'البروج', numberOfPage: 590),
    Surah(name: 'الطارق', numberOfPage: 591),
    Surah(name: 'الأعلى', numberOfPage: 591),
    Surah(name: 'الغاشية', numberOfPage: 592),
    Surah(name: 'الفجر', numberOfPage: 593),
    Surah(name: 'البلد', numberOfPage: 594),
    Surah(name: 'الشمس', numberOfPage: 595),
    Surah(name: 'الليل', numberOfPage: 595),
    Surah(name: 'الضحى', numberOfPage: 596),
    Surah(name: 'الشرح', numberOfPage: 596),
    Surah(name: 'التين', numberOfPage: 597),
    Surah(name: 'العلق', numberOfPage: 597),
    Surah(name: 'القدر', numberOfPage: 598),
    Surah(name: 'البينة', numberOfPage: 598),
    Surah(name: 'الزلزلة', numberOfPage: 599),
    Surah(name: 'العاديات', numberOfPage: 599),
    Surah(name: 'القارعة', numberOfPage: 600),
    Surah(name: 'التكاثر', numberOfPage: 600),
    Surah(name: 'العصر', numberOfPage: 601),
    Surah(name: 'الهمزة', numberOfPage: 601),
    Surah(name: 'الفيل', numberOfPage: 601),
    Surah(name: 'قريش', numberOfPage: 602),
    Surah(name: 'الماعون', numberOfPage: 602),
    Surah(name: 'الكوثر', numberOfPage: 602),
    Surah(name: 'الكافرون', numberOfPage: 603),
    Surah(name: 'النصر', numberOfPage: 603),
    Surah(name: 'المسد', numberOfPage: 603),
    Surah(name: 'الإخلاص', numberOfPage: 604),
    Surah(name: 'الفلق', numberOfPage: 604),
    Surah(name: 'الناس', numberOfPage: 604),
  ];

  showMarkDialog() {
    var pageProp = MarkedPage(
      pageNumber: quranCtr.selectedSurah.pageNumber.value,
      juz: QuranHelper().getJuzNumberByPage(quranCtr.selectedSurah.pageNumber.value),
      surahName: QuranHelper().getSurahNameByPage(quranCtr.selectedSurah.pageNumber.value),
      isMarked: false,
    );
    for (var element in quranCtr.markedList)
      if (element.pageNumber == pageProp.pageNumber) if (element.isMarked) {
        pageProp.isMarked = true;
        break;
      }
    String title = pageProp.isMarked ? 'ازالة علامة قراءة' : 'اضافة علامة قراءة';
    String content =
        pageProp.isMarked ? 'هل تود ازالة علامة القراءة على هذه الصفحة؟' : 'هل تود وضع علامة على هذه الصفحة؟';

    return Get.dialog(
      AlertDialog(
        title: Text(title, style: TextStyle(color: MyColors.quranText())),
        content: Text(content, style: TextStyle(color: MyColors.quranText())),
        actionsAlignment: MainAxisAlignment.spaceAround,
        backgroundColor: MyColors.quranBackGround(),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('الغاء'),
          ),
          TextButton(
            onPressed: () {
              if (pageProp.isMarked) {
                quranCtr.markedList.removeWhere((element) => element.pageNumber == pageProp.pageNumber);
                Fluttertoast.showToast(msg: 'تم ازالة العلامة');
              } else {
                pageProp.isMarked = true;
                quranCtr.markedList.add(pageProp);
                quranCtr.updateMarkedPageList(pageProp);
                Fluttertoast.showToast(msg: 'تم اضافة العلامة');
              }
              Get.back();
              quranCtr.quranPageSetState();
            },
            child: Text('تأكيد'),
          ),
        ],
      ),
      transitionDuration: Duration(milliseconds: 500),
    );
  }

  void changeOnShownState(bool value) {
    if (value)
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      FocusManager.instance.primaryFocus?.unfocus();
    }

    quranCtr.onShown.value = value;
    quranCtr.quranPageSetState();
  }

  changeCurrentPageToWhereStartRead() async {
    Map data = await JsonService.getAllQuranData(quranCtr.selectedSurah.surahNumber.value);
    List ayahsList = data['ayahs'];
    for (var i = 0; i < ayahsList.length; i++) {
      if (ayahsList[i]['numberInSurah'] == quranCtr.selectedSurah.startAyahNum.value) {
        quranCtr.tabCtr.index = ayahsList[i]['page'] - 1;
        break;
      }
    }
  }

  int getSurahNumberByName(String surahName) {
    int number = 1;
    for (var i = 0; i < allSurahsNames.length; i++) {
      if (allSurahsNames[i].name.contains(surahName)) number = i + 1;
    }
    return number;
  }

  List<Surah> getMatchedSurahs(String query) =>
      allSurahsNames.where((element) => element.name.contains(query)).toList();

  List<int> getMatchedPages(String query) {
    List<int> resultList = [];

    int? num = int.tryParse(query);
    if (num == null) return resultList;

    if (num > 604 || num < 1) return resultList;
    for (var i = 1; i <= 604; i++) {
      if (i.toString().contains(num.toString())) resultList.add(i);
    }

    return resultList;
  }

  int getJuzNumberByPage(int page) {
    int juz = 1;
    if (page <= 21)
      juz = 1;
    else if (page <= 41)
      juz = 2;
    else if (page <= 61)
      juz = 3;
    else if (page <= 81)
      juz = 4;
    else if (page <= 101)
      juz = 5;
    else if (page <= 121)
      juz = 6;
    else if (page <= 141)
      juz = 7;
    else if (page <= 161)
      juz = 8;
    else if (page <= 181)
      juz = 9;
    else if (page <= 201)
      juz = 10;
    else if (page <= 221)
      juz = 11;
    else if (page <= 241)
      juz = 12;
    else if (page <= 261)
      juz = 13;
    else if (page <= 281)
      juz = 14;
    else if (page <= 301)
      juz = 15;
    else if (page <= 321)
      juz = 16;
    else if (page <= 341)
      juz = 17;
    else if (page <= 361)
      juz = 18;
    else if (page <= 381)
      juz = 19;
    else if (page <= 401)
      juz = 20;
    else if (page <= 421)
      juz = 21;
    else if (page <= 441)
      juz = 22;
    else if (page <= 461)
      juz = 23;
    else if (page <= 481)
      juz = 24;
    else if (page <= 501)
      juz = 25;
    else if (page <= 521)
      juz = 26;
    else if (page <= 541)
      juz = 27;
    else if (page <= 561)
      juz = 28;
    else if (page <= 581)
      juz = 29;
    else
      juz = 30;
    return juz;
  }

  String getSurahNameByPage(int page) {
    String surahName = '';
    for (var element in allSurahsNames.reversed)
      if (element.numberOfPage <= page) {
        surahName = element.name;
        break;
      }
    return surahName;
  }

  List<SearchedAyah> getMatchedAyahs(String query) {
    List<SearchedAyah> matchedAyahs = [];
    bool isFull = false;
    for (var i = 0; i < JsonService.allQuranData.length; i++) {
      if (isFull) break;
      Map surahMap = JsonService.allQuranData[i];
      List ayahs = surahMap['ayahs'];
      for (var ayah in ayahs) {
        if (normalise(ayah.toString()).contains(query))
          matchedAyahs.add(SearchedAyah(
            ayahNumber: ayah['numberInSurah'],
            ayahText: ayah['text'],
            page: ayah['page'],
            surahName: getSurahNameByPage(ayah['page']),
          ));
        if (matchedAyahs.length == 20) {
          isFull = true;
          break;
        }
      }
    }

    return matchedAyahs;
  }

  String normalise(String input) {
    return input
        .replaceAll('ٱ', 'ا') //change alef
        .replaceAll('\u0610', '') //ARABIC SIGN SALLALLAHOU ALAYHE WA SALLAM
        .replaceAll('\u0611', '') //ARABIC SIGN ALAYHE ASSALLAM
        .replaceAll('\u0612', '') //ARABIC SIGN RAHMATULLAH ALAYHE
        .replaceAll('\u0613', '') //ARABIC SIGN RADI ALLAHOU ANHU
        .replaceAll('\u0614', '') //ARABIC SIGN TAKHALLUS

        //Remove koranic anotation
        .replaceAll('\u0615', '') //ARABIC SMALL HIGH TAH
        .replaceAll('\u0616', '') //ARABIC SMALL HIGH LIGATURE ALEF WITH LAM WITH YEH
        .replaceAll('\u0617', '') //ARABIC SMALL HIGH ZAIN
        .replaceAll('\u0618', '') //ARABIC SMALL FATHA
        .replaceAll('\u0619', '') //ARABIC SMALL DAMMA
        .replaceAll('\u061A', '') //ARABIC SMALL KASRA
        .replaceAll('\u06D6', '') //ARABIC SMALL HIGH LIGATURE SAD WITH LAM WITH ALEF MAKSURA
        .replaceAll('\u06D7', '') //ARABIC SMALL HIGH LIGATURE QAF WITH LAM WITH ALEF MAKSURA
        .replaceAll('\u06D8', '') //ARABIC SMALL HIGH MEEM INITIAL FORM
        .replaceAll('\u06D9', '') //ARABIC SMALL HIGH LAM ALEF
        .replaceAll('\u06DA', '') //ARABIC SMALL HIGH JEEM
        .replaceAll('\u06DB', '') //ARABIC SMALL HIGH THREE DOTS
        .replaceAll('\u06DC', '') //ARABIC SMALL HIGH SEEN
        .replaceAll('\u06DD', '') //ARABIC END OF AYAH
        .replaceAll('\u06DE', '') //ARABIC START OF RUB EL HIZB
        .replaceAll('\u06DF', '') //ARABIC SMALL HIGH ROUNDED ZERO
        .replaceAll('\u06E0', '') //ARABIC SMALL HIGH UPRIGHT RECTANGULAR ZERO
        .replaceAll('\u06E1', '') //ARABIC SMALL HIGH DOTLESS HEAD OF KHAH
        .replaceAll('\u06E2', '') //ARABIC SMALL HIGH MEEM ISOLATED FORM
        .replaceAll('\u06E3', '') //ARABIC SMALL LOW SEEN
        .replaceAll('\u06E4', '') //ARABIC SMALL HIGH MADDA
        .replaceAll('\u06E5', '') //ARABIC SMALL WAW
        .replaceAll('\u06E6', '') //ARABIC SMALL YEH
        .replaceAll('\u06E7', '') //ARABIC SMALL HIGH YEH
        .replaceAll('\u06E8', '') //ARABIC SMALL HIGH NOON
        .replaceAll('\u06E9', '') //ARABIC PLACE OF SAJDAH
        .replaceAll('\u06EA', '') //ARABIC EMPTY CENTRE LOW STOP
        .replaceAll('\u06EB', '') //ARABIC EMPTY CENTRE HIGH STOP
        .replaceAll('\u06EC', '') //ARABIC ROUNDED HIGH STOP WITH FILLED CENTRE
        .replaceAll('\u06ED', '') //ARABIC SMALL LOW MEEM

        //Remove tatweel
        .replaceAll('\u0640', '')

        //Remove tashkeel
        .replaceAll('\u064B', '') //ARABIC FATHATAN
        .replaceAll('\u064C', '') //ARABIC DAMMATAN
        .replaceAll('\u064D', '') //ARABIC KASRATAN
        .replaceAll('\u064E', '') //ARABIC FATHA
        .replaceAll('\u064F', '') //ARABIC DAMMA
        .replaceAll('\u0650', '') //ARABIC KASRA
        .replaceAll('\u0651', '') //ARABIC SHADDA
        .replaceAll('\u0652', '') //ARABIC SUKUN
        .replaceAll('\u0653', '') //ARABIC MADDAH ABOVE
        .replaceAll('\u0654', '') //ARABIC HAMZA ABOVE
        .replaceAll('\u0655', '') //ARABIC HAMZA BELOW
        .replaceAll('\u0656', '') //ARABIC SUBSCRIPT ALEF
        .replaceAll('\u0657', '') //ARABIC INVERTED DAMMA
        .replaceAll('\u0658', '') //ARABIC MARK NOON GHUNNA
        .replaceAll('\u0659', '') //ARABIC ZWARAKAY
        .replaceAll('\u065A', '') //ARABIC VOWEL SIGN SMALL V ABOVE
        .replaceAll('\u065B', '') //ARABIC VOWEL SIGN INVERTED SMALL V ABOVE
        .replaceAll('\u065C', '') //ARABIC VOWEL SIGN DOT BELOW
        .replaceAll('\u065D', '') //ARABIC REVERSED DAMMA
        .replaceAll('\u065E', '') //ARABIC FATHA WITH TWO DOTS
        .replaceAll('\u065F', '') //ARABIC WAVY HAMZA BELOW
        .replaceAll('\u0670', '') //ARABIC LETTER SUPERSCRIPT ALEF

        //Replace Waw Hamza Above by Waw
        .replaceAll('\u0624', '\u0648')

        //Replace Ta Marbuta by Ha
        // .replaceAll('\u0629', '\u0647')

        //Replace Ya
        // and Ya Hamza Above by Alif Maksura
        .replaceAll('\u064A', '\u0649')
        .replaceAll('\u0626', '\u0649')

        // Replace Alifs with Hamza Above/Below
        // and with Madda Above by Alif
        .replaceAll('\u0622', '\u0627')
        .replaceAll('\u0623', '\u0627')
        .replaceAll('\u0625', '\u0627');
  }
}
