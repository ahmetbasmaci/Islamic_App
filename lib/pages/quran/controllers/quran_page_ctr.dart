import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/classes/helper_methods.dart';
import 'package:zad_almumin/classes/zikr_data.dart';
import 'package:zad_almumin/constents/constants.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/constents/my_texts.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/pages/quran/models/ayah.dart';
import 'package:zad_almumin/pages/quran/models/quran_data.dart';
import 'package:zad_almumin/pages/quran/models/surah.dart';
import 'package:zad_almumin/services/audio_ctr.dart';
import 'package:zad_almumin/services/http_service.dart';
import 'package:zad_almumin/services/json_service.dart';
import '../models/filter_chip_prop.dart';
import '../models/marked_page.dart';
import '../models/selected_surah.dart';

class QuranPageCtr extends GetxController {
  final QuranData _quranData = Get.find<QuranData>();
  bool showInKahf = false;
  RxBool onShown = false.obs;
  RxBool showAsImages = false.obs;
  Rx<Ayah> selectedAyah = Ayah.empty().obs;
  SelectedPageInfo selectedPage = SelectedPageInfo();
  RxList<MarkedPage> markedList = <MarkedPage>[].obs;
  RxDouble quranFontSize = (Get.width * Get.height * 0.000067).obs;
  RxList<Rx<FilterChipProp>> searchFilterList =
      [FilterChipProp(text: '', isSelected: false.obs, searchFilter: SearchFilter.ayah).obs].obs;
  VoidCallback quranPageSetState = () {};
  late TabController tabCtr;
  Timer? _debounceTimer;

  QuranPageCtr() {
    // _deleteQuranMarkedList();
    readFromStorage();
  }
  // _deleteQuranMarkedList() {
  //   GetStorage storage = GetStorage();
  //   storage.remove('markedList');
  //   printError(info: 'DELETED DB');
  // }

  final StreamController<List<Ayah>> _streamController = StreamController<List<Ayah>>.broadcast();
  Stream<List<Ayah>> get ayahsStream => _streamController.stream;
  dynamic showMarkDialog() {
    var pageProp = MarkedPage(
      pageNumber: selectedPage.pageNumber.value,
      juz: _quranData.getJuzNumberByPage(selectedPage.pageNumber.value),
      surahName: _quranData.getSurahNameByPage(selectedPage.pageNumber.value),
      isMarked: false,
    );
    for (var element in markedList)
      if (element.pageNumber == pageProp.pageNumber) if (element.isMarked) {
        pageProp.isMarked = true;
        break;
      }
    String title = pageProp.isMarked ? 'ازالة علامة قراءة'.tr : 'اضافة علامة قراءة'.tr;
    String content =
        pageProp.isMarked ? 'هل تود ازالة علامة القراءة من هذه الصفحة؟'.tr : 'هل تود وضع علامة على هذه الصفحة؟'.tr;

    return Get.dialog(
      AlertDialog(
        title: MyTexts.main(title: title, fontWeight: FontWeight.bold),
        content: MyTexts.main(title: content),
        actionsAlignment: MainAxisAlignment.spaceAround,
        backgroundColor: MyColors.quranBackGround(),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (pageProp.isMarked) {
                markedList.removeWhere((element) => element.pageNumber == pageProp.pageNumber);
                Fluttertoast.showToast(msg: 'تم ازالة العلامة'.tr);
              } else {
                pageProp.isMarked = true;
                markedList.add(pageProp);
                updateMarkedPageList(pageProp);
                Fluttertoast.showToast(msg: 'تم اضافة العلامة'.tr);
              }
              Get.back();
              quranPageSetState();
            },
            child: MyTexts.main(title: 'تأكيد'.tr, color: MyColors.quranBackGroundLight),
          ),
          TextButton(
            onPressed: () => Get.back(),
            child: MyTexts.main(title: 'الغاء'.tr),
          ),
        ],
      ),
      transitionDuration: Duration(milliseconds: 500),
    );
  }

  void addRemoveAyahMark(Ayah ayah) {
    GetStorage storage = GetStorage();
    bool isMarked = storage.read('markedAyah${ayah.surahNumber}${ayah.ayahNumber}') ?? false;
    storage.write('markedAyah${ayah.surahNumber}${ayah.ayahNumber}', !isMarked);
    ayah.isMarked = !isMarked;

    if (isMarked) {
      Fluttertoast.showToast(msg: 'تم ازالة العلامة'.tr);
    } else {
      Fluttertoast.showToast(msg: 'تم اضافة العلامة'.tr);
    }
    selectedAyah.value = Ayah.empty();
  }

  List<Ayah> getMarkedAyahs() {
    List<Ayah> markedAyahsList = [];
    for (var surah in _quranData.getAllSurahs()) {
      for (var ayah in surah.ayahs) {
        if (ayah.isMarked) markedAyahsList.add(ayah);
      }
    }
    return markedAyahsList;
  }

  void changeOnShownState(bool value) {
    // if (value)
    //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    // else {
    //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    //   FocusManager.instance.primaryFocus?.unfocus();
    // }

    onShown.value = value;
    quranPageSetState();
    AppSettings.focusScopeNode.unfocus();
  }

  void updateCurrentPageToWhereStartRead() async {
    List<Ayah> ayahsList = _quranData.getSurahByNumber(selectedPage.surahNumber.value).ayahs;
    for (int i = 1; i < ayahsList.length; i++) {
      Ayah ayah = ayahsList[i];
      if (ayah.ayahNumber == selectedPage.startAyahNum.value) {
        tabCtr.index = ayah.page - 1;
        break;
      }
    }
  }

  void updateCurrentPageToCurrentAyah() async {
    tabCtr.index = selectedAyah.value.page - 1;
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
        for (int i = 0; i < surah.ayahs.length; i++) {
          Ayah ayah = surah.ayahs[i];
          if (HelperMethods.normalise(ayah.text.toString()).contains(query)) {
            matchedAyahs.add(ayah);
            _streamController.add(matchedAyahs);
          }
        }
      }
    });
  }

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

  Future<ZikrData> getSpecificAyah(int surahNumber, int ayahNumber) async {
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

  Future<ZikrData> getNextAyah(int surahNumber, int ayahNumber) async {
    ZikrData zikrData = await getSpecificAyah(surahNumber, ayahNumber + 1);
    return zikrData;
  }

  void changeShowQuranStyle() {
    showAsImages.value = !showAsImages.value;
    GetStorage storage = GetStorage();
    storage.write('showAsImages', showAsImages.value);
  }

  void readFromStorage() {
    GetStorage storage = GetStorage();

    showAsImages.value = storage.read<bool>('showAsImages') ?? showAsImages.value;
    quranFontSize.value = storage.read<double>('quranFontSize') ?? quranFontSize.value;

    //get selected reader
    List<dynamic> markedListMap = storage.read('markedList') ?? [];
    selectedPage.selectedQuranReader.value = QuranReaders.values[GetStorage().read<int>('selectedQuranReader') ?? 0];
    for (var element in markedListMap) markedList.add(MarkedPage.fromJson(element));

    //get searchFilter order
    List<dynamic> searchListMap = storage.read('searchFilterList') ?? [];
    searchFilterList.clear();
    if (searchListMap.isNotEmpty) {
      for (var element in searchListMap) searchFilterList.add(FilterChipProp.fromJson(element).obs);
    } else {
      searchFilterList
          .add(FilterChipProp(text: 'السور'.tr, isSelected: false.obs, searchFilter: SearchFilter.surah).obs);
      searchFilterList
          .add(FilterChipProp(text: 'الايات'.tr, isSelected: false.obs, searchFilter: SearchFilter.ayah).obs);
      searchFilterList
          .add(FilterChipProp(text: 'الصفحات'.tr, isSelected: false.obs, searchFilter: SearchFilter.page).obs);
    }
  }

  void updateMarkedPageList(MarkedPage pageProp) {
    GetStorage storage = GetStorage();
    List<Map> listMap = [];
    for (var element in markedList) listMap.add(element.toJson());

    storage.write('markedList', listMap);
  }

  void updateQuranFontSize(double newValue) {
    GetStorage storage = GetStorage();
    quranFontSize.value = newValue;
    storage.write('quranFontSize', quranFontSize.value);
  }

  void updateSearchFilterList() {
    GetStorage storage = GetStorage();
    List<Map> listMap = [];
    for (var i = 0; i < searchFilterList.length; i++) {
      listMap.add(searchFilterList[i].value.toJson());
    }

    storage.write('searchFilterList', listMap);
  }

  void resetSelectedSurahAll() {
    selectedPage.repeetAllCount.value = 1;
    selectedPage.repeetAyahCount.value = 1;
    selectedPage.isUnlimitRepeatAll.value = false;
    selectedPage.isUnlimitRepeatAyah.value = false;
  }

  void markedItemBtnPress(int pageNumber) {
    tabCtr.index = pageNumber - 1;
    changeOnShownState(false);
    Get.back();
  }

  void updateCurrentPageCtr() async {
    GetStorage().write('pageIndex', tabCtr.index);

    selectedPage.pageNumber.value = tabCtr.index + 1;
    selectedPage.juz.value = _quranData.getJuzNumberByPage(selectedPage.pageNumber.value);
    String newSurahName = _quranData.getSurahNameByPage(selectedPage.pageNumber.value);
    if (selectedPage.surahName.value != newSurahName) {
      selectedPage.surahName.value = newSurahName;
      selectedPage.surahNumber.value = _quranData.getSurahNumberByName(selectedPage.surahName.value);
      selectedPage.totalAyahsNum.value = _quranData.getSurahAyahs(selectedPage.surahNumber.value).length - 1;
      selectedPage.startAyahNum.value = 1;
      selectedPage.endAyahNum.value = selectedPage.totalAyahsNum.value;
    }
  }

  void setCurrentPage(TickerProvider quranTicker) {
    tabCtr = TabController(length: 604, vsync: quranTicker);
    tabCtr = tabCtr;

    //check last opend page
    tabCtr.index = GetStorage().read('pageIndex') ?? 0;

    //check if user open quran page from kahf notification
    if (showInKahf) tabCtr.index = 294;
    selectedPage.pageNumber.value = tabCtr.index + 1;
  }

  void pagePressed() {
    changeOnShownState(!onShown.value);
    if (!Get.find<AudioCtr>().isPlaying.value) {
      selectedAyah.value = Ayah.empty();
    }
  }

  void playPauseBtnPress() async {
    AudioCtr audioCtr = Get.find<AudioCtr>();
    if (audioCtr.isPlaying.value)
      audioCtr.pauseAudio();
    else {
      if (selectedAyah.value.text == '')
        selectedAyah.value = _quranData.getAyah(selectedPage.surahNumber.value, selectedPage.startAyahNum.value);
      List<Ayah> ayahsList = await HttpService.downloadSurah(surahNumber: selectedAyah.value.surahNumber);
      Get.find<AudioCtr>().playMultiAudio(ayahList: ayahsList);
    }
  }
}
