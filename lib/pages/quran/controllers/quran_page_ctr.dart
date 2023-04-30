import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/pages/quran/models/ayah.dart';
import '../models/filter_chip_prop.dart';
import '../models/marked_page.dart';
import '../models/selected_surah.dart';

class QuranPageCtr extends GetxController {
  RxBool onShown = false.obs;
  RxBool showAsImages = false.obs;
  Rx<Ayah> selectedAyah = Ayah.empty().obs;
  SelectedPageInfo selectedSurah = SelectedPageInfo();
  RxList<MarkedPage> markedList = <MarkedPage>[].obs;
  RxDouble quranFontSize = (Get.width * Get.height * 0.000067).obs;
  RxList<Rx<FilterChipProp>> searchFilterList =
      [FilterChipProp(text: '', isSelected: false.obs, searchFilter: SearchFilter.ayah).obs].obs;
  VoidCallback quranPageSetState = () {};
  late TabController tabCtr;
  QuranPageCtr() {
    // _deleteQuranMarkedList();
    readFromStorage();
  }
  // _deleteQuranMarkedList() {
  //   GetStorage storage = GetStorage();

  //   storage.remove('markedList');
  //   printError(info: 'DELETED DB');
  // }

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
    selectedSurah.selectedQuranReader.value = QuranReaders.values[GetStorage().read<int>('selectedQuranReader') ?? 0];
    for (var element in markedListMap) markedList.add(MarkedPage.fromJson(element));

    //get searchFilter order
    List<dynamic> searchListMap = storage.read('searchFilterList') ?? [];
    searchFilterList.clear();
    if (searchListMap.isNotEmpty) {
      for (var element in searchListMap) searchFilterList.add(FilterChipProp.fromJson(element).obs);
    } else {
      searchFilterList.add(FilterChipProp(text: 'السور', isSelected: false.obs, searchFilter: SearchFilter.surah).obs);
      searchFilterList.add(FilterChipProp(text: 'الايات', isSelected: false.obs, searchFilter: SearchFilter.ayah).obs);
      searchFilterList.add(FilterChipProp(text: 'الصفحات', isSelected: false.obs, searchFilter: SearchFilter.page).obs);
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

  void resetAll() {
    selectedSurah.repeetAllCount.value = 1;
    selectedSurah.repeetAyahCount.value = 1;
    selectedSurah.isUnlimitRepeatAll.value = false;
    selectedSurah.isUnlimitRepeatAyah.value = false;
  }
}
