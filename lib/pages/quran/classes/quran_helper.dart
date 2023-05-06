import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/classes/helper_methods.dart';
import 'package:zad_almumin/classes/zikr_data.dart';
import 'package:zad_almumin/constents/constents.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/pages/quran/models/ayah.dart';
import 'package:zad_almumin/pages/quran/models/surah.dart';
import 'package:zad_almumin/services/json_service.dart';
import '../../../constents/my_colors.dart';
import '../models/quran_data.dart';
import '../models/marked_page.dart';
import '../controllers/quran_page_ctr.dart';

class QuranHelper {
  QuranPageCtr quranCtr = Get.find<QuranPageCtr>();
  Timer? _debounceTimer;
  final QuranData _quranData = Get.find<QuranData>();
  // List<Surah> allSurahsNames = [
  //   Surah(name: 'الفاتحة', startAtPage: 1),
  //   Surah(name: 'البقرة', startAtPage: 2),
  //   Surah(name: 'آل عمران', startAtPage: 50),
  //   Surah(name: 'النساء', startAtPage: 77),
  //   Surah(name: 'المائدة', startAtPage: 106),
  //   Surah(name: 'الأنعام', startAtPage: 128),
  //   Surah(name: 'الأعراف', startAtPage: 151),
  //   Surah(name: 'الأنفال', startAtPage: 177),
  //   Surah(name: 'التوبة', startAtPage: 187),
  //   Surah(name: 'يونس', startAtPage: 208),
  //   Surah(name: 'هود', startAtPage: 221),
  //   Surah(name: 'يوسف', startAtPage: 235),
  //   Surah(name: 'الرعد', startAtPage: 249),
  //   Surah(name: 'ابراهيم', startAtPage: 255),
  //   Surah(name: 'الحجر', startAtPage: 262),
  //   Surah(name: 'النحل', startAtPage: 267),
  //   Surah(name: 'الإسراء', startAtPage: 282),
  //   Surah(name: 'الكهف', startAtPage: 293),
  //   Surah(name: 'مريم', startAtPage: 305),
  //   Surah(name: 'طه', startAtPage: 312),
  //   Surah(name: 'الأنبياء', startAtPage: 322),
  //   Surah(name: 'الحج', startAtPage: 332),
  //   Surah(name: 'المؤمنون', startAtPage: 342),
  //   Surah(name: 'النور', startAtPage: 350),
  //   Surah(name: 'الفرقان', startAtPage: 359),
  //   Surah(name: 'الشعراء', startAtPage: 367),
  //   Surah(name: 'النمل', startAtPage: 377),
  //   Surah(name: 'القصص', startAtPage: 385),
  //   Surah(name: 'العنكبوت', startAtPage: 396),
  //   Surah(name: 'الروم', startAtPage: 404),
  //   Surah(name: 'لقمان', startAtPage: 411),
  //   Surah(name: 'السجدة', startAtPage: 415),
  //   Surah(name: 'الأحزاب', startAtPage: 418),
  //   Surah(name: 'سبأ', startAtPage: 428),
  //   Surah(name: 'فاطر', startAtPage: 434),
  //   Surah(name: 'يس', startAtPage: 440),
  //   Surah(name: 'الصافات', startAtPage: 446),
  //   Surah(name: 'ص', startAtPage: 453),
  //   Surah(name: 'الزمر', startAtPage: 458),
  //   Surah(name: 'غافر', startAtPage: 467),
  //   Surah(name: 'فصلت', startAtPage: 477),
  //   Surah(name: 'الشورى', startAtPage: 483),
  //   Surah(name: 'الزخرف', startAtPage: 489),
  //   Surah(name: 'الدخان', startAtPage: 496),
  //   Surah(name: 'الجاثية', startAtPage: 499),
  //   Surah(name: 'الأحقاف', startAtPage: 502),
  //   Surah(name: 'محمد', startAtPage: 507),
  //   Surah(name: 'الفتح', startAtPage: 511),
  //   Surah(name: 'الحجرات', startAtPage: 515),
  //   Surah(name: 'ق', startAtPage: 518),
  //   Surah(name: 'الذاريات', startAtPage: 520),
  //   Surah(name: 'الطور', startAtPage: 523),
  //   Surah(name: 'النجم', startAtPage: 526),
  //   Surah(name: 'القمر', startAtPage: 528),
  //   Surah(name: 'الرحمن', startAtPage: 531),
  //   Surah(name: 'الواقعة', startAtPage: 534),
  //   Surah(name: 'الحديد', startAtPage: 537),
  //   Surah(name: 'المجادلة', startAtPage: 542),
  //   Surah(name: 'الحشر', startAtPage: 545),
  //   Surah(name: 'الممتحنة', startAtPage: 549),
  //   Surah(name: 'الصف', startAtPage: 551),
  //   Surah(name: 'الجمعة', startAtPage: 553),
  //   Surah(name: 'المنافقون', startAtPage: 554),
  //   Surah(name: 'التغابن', startAtPage: 556),
  //   Surah(name: 'الطلاق', startAtPage: 558),
  //   Surah(name: 'التحريم', startAtPage: 560),
  //   Surah(name: 'الملك', startAtPage: 562),
  //   Surah(name: 'القلم', startAtPage: 564),
  //   Surah(name: 'الحاقة', startAtPage: 566),
  //   Surah(name: 'المعارج', startAtPage: 568),
  //   Surah(name: 'نوح', startAtPage: 570),
  //   Surah(name: 'الجن', startAtPage: 572),
  //   Surah(name: 'المزمل', startAtPage: 574),
  //   Surah(name: 'المدثر', startAtPage: 575),
  //   Surah(name: 'القيامة', startAtPage: 577),
  //   Surah(name: 'الانسان', startAtPage: 578),
  //   Surah(name: 'المرسلات', startAtPage: 580),
  //   Surah(name: 'النبأ', startAtPage: 582),
  //   Surah(name: 'النازعات', startAtPage: 583),
  //   Surah(name: 'عبس', startAtPage: 585),
  //   Surah(name: 'التكوير', startAtPage: 586),
  //   Surah(name: 'الإنفطار', startAtPage: 587),
  //   Surah(name: 'المطففين', startAtPage: 587),
  //   Surah(name: 'الإنشقاق', startAtPage: 589),
  //   Surah(name: 'البروج', startAtPage: 590),
  //   Surah(name: 'الطارق', startAtPage: 591),
  //   Surah(name: 'الأعلى', startAtPage: 591),
  //   Surah(name: 'الغاشية', startAtPage: 592),
  //   Surah(name: 'الفجر', startAtPage: 593),
  //   Surah(name: 'البلد', startAtPage: 594),
  //   Surah(name: 'الشمس', startAtPage: 595),
  //   Surah(name: 'الليل', startAtPage: 595),
  //   Surah(name: 'الضحى', startAtPage: 596),
  //   Surah(name: 'الشرح', startAtPage: 596),
  //   Surah(name: 'التين', startAtPage: 597),
  //   Surah(name: 'العلق', startAtPage: 597),
  //   Surah(name: 'القدر', startAtPage: 598),
  //   Surah(name: 'البينة', startAtPage: 598),
  //   Surah(name: 'الزلزلة', startAtPage: 599),
  //   Surah(name: 'العاديات', startAtPage: 599),
  //   Surah(name: 'القارعة', startAtPage: 600),
  //   Surah(name: 'التكاثر', startAtPage: 600),
  //   Surah(name: 'العصر', startAtPage: 601),
  //   Surah(name: 'الهمزة', startAtPage: 601),
  //   Surah(name: 'الفيل', startAtPage: 601),
  //   Surah(name: 'قريش', startAtPage: 602),
  //   Surah(name: 'الماعون', startAtPage: 602),
  //   Surah(name: 'الكوثر', startAtPage: 602),
  //   Surah(name: 'الكافرون', startAtPage: 603),
  //   Surah(name: 'النصر', startAtPage: 603),
  //   Surah(name: 'المسد', startAtPage: 603),
  //   Surah(name: 'الإخلاص', startAtPage: 604),
  //   Surah(name: 'الفلق', startAtPage: 604),
  //   Surah(name: 'الناس', startAtPage: 604),
  // ];

  final StreamController<List<Ayah>> _streamController = StreamController<List<Ayah>>.broadcast();
  Stream<List<Ayah>> get ayahsStream => _streamController.stream;
  showMarkDialog() {
    var pageProp = MarkedPage(
      pageNumber: quranCtr.selectedSurah.pageNumber.value,
      juz: _quranData.getJuzNumberByPage(quranCtr.selectedSurah.pageNumber.value),
      surahName: _quranData.getSurahNameByPage(quranCtr.selectedSurah.pageNumber.value),
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
    // if (value)
    //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    // else {
    //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    //   FocusManager.instance.primaryFocus?.unfocus();
    // }

    quranCtr.onShown.value = value;
    quranCtr.quranPageSetState();
    Constants.focusScopeNode.unfocus();
  }

  void changeCurrentPageToWhereStartRead() async {
    List<Ayah> ayahsList = _quranData.getSurahByNumber(quranCtr.selectedSurah.surahNumber.value).ayahs;
    for (var ayah in ayahsList) {
      if (ayah.ayahNumber == quranCtr.selectedSurah.startAyahNum.value) {
        quranCtr.tabCtr.index = ayah.page - 1;
        break;
      }
    }
  }

  List<int> searchPages(String query) {
    List<int> resultList = [];

    int? num = int.tryParse(query);
    if (num == null) return resultList;

    if (num > 604 || num < 1) return resultList;
    for (var i = 1; i <= 604; i++) {
      if (i.toString().contains(num.toString())) resultList.add(i);
    }

    return resultList;
  }

  List<Surah> searchSurahs(String query) => _quranData.getMatchedSurah(query);

  void searchAyahs(String query) async {
    _streamController.add([]);
    List<Ayah> matchedAyahs = [];
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      for (var i = 0; i < _quranData.getSurahsCount(); i++) {
        Surah surah = _quranData.getSurahByNumber(i + 1);
        List<Ayah> ayahs = surah.ayahs;
        for (var ayah in ayahs) {
          if (HelperMethods.normalise(ayah.text.toString()).contains(query)) {
            matchedAyahs.add(ayah);
            _streamController.add(matchedAyahs);
          }
        }
      }
    });
  }

//-------------------------------------------------------------------------------------------------------
  Future<ZikrData> getRandomZikrDataAyah() async {
    if (_quranData.isEmpty)
      await JsonService.loadQuranData();
    else
      await Future.delayed(Duration(milliseconds: 300));

    Ayah randomAyah = _quranData.getRandomAyah();

    ZikrData zikrData = ZikrData(
      zikrType: ZikrType.quran,
      title: 'اعوذ بالله من الشيطان الرجيم',
      content: randomAyah.text,
      ayahNumber: randomAyah.ayahNumber,
      surahNumber: randomAyah.surahNumber,
    );
    return zikrData;
  }

  Future<ZikrData> getZikDataSpecificAyah(int surahNumber, int ayahNumber) async {
    if (_quranData.isEmpty)
      await JsonService.loadQuranData();
    else
      await Future.delayed(Duration(milliseconds: 300));

    Ayah ayah = _quranData.getAyah(surahNumber, ayahNumber);

    ZikrData zikrData = ZikrData(
      zikrType: ZikrType.quran,
      title: 'اعوذ بالله من الشيطان الرجيم',
      content: ayah.text,
      ayahNumber: ayah.ayahNumber,
      surahNumber: ayah.surahNumber,
    );
    return zikrData;
  }

  Future<ZikrData> getZikDataNextAyah(int surahNumber, int ayahNumber) async {
    ZikrData zikrData = await getZikDataSpecificAyah(surahNumber, ayahNumber + 1);
    return zikrData;
  }
}
