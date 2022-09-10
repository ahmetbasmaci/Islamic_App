import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/moduls/enums.dart';
import '../classes/filter_chip_prop.dart';
import '../classes/marked_page.dart';
import '../classes/selected_surah.dart';

class QuranPageCtr extends GetxController {
  RxBool onShown = false.obs;
  SelectedSurah selectedSurah = SelectedSurah();
  RxList<MarkedPage> markedList = <MarkedPage>[].obs;
  RxList<Rx<FilterChipProp>> searchFilterList =
      [FilterChipProp(text: '', isSelected: false.obs, searchFilter: SearchFilter.ayah).obs].obs;
  VoidCallback quranPageSetState = () {};
  late TabController tabCtr;
  QuranPageCtr() {
    // deleteDb();
    readFromStorage();
  }

  deleteDb() {
    GetStorage storage = GetStorage();

    storage.remove('markedList');
    printError(info: 'DELETED DB');
  }

  void readFromStorage() {
    GetStorage storage = GetStorage();

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

  void updateSearchFilterList() {
    GetStorage storage = GetStorage();
    List<Map> listMap = [];
    for (var i = 0; i < searchFilterList.length; i++) {
      listMap.add(searchFilterList[i].value.toJson());
    }

    storage.write('searchFilterList', listMap);
  }
}
