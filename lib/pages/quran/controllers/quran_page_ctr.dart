import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/moduls/enums.dart';

import '../classes/marked_page.dart';

class QuranPageCtr extends GetxController {
  RxBool onShown = false.obs;
  // RxInt ayahStartNum = 0.obs;
  // RxInt ayahEndNum = 0.obs;
  // RxInt totalAyahsCount = 0.obs;
  // RxInt pageNumber = 0.obs;
  // RxInt surahNumber = 0.obs;
  // RxInt juz = 0.obs;
  // RxString surahName = ''.obs;
  SelectedSurah selectedSurah = SelectedSurah();
  RxList<MarkedPage> markedList = <MarkedPage>[].obs;
 
  VoidCallback quranPageSetState = () {};
  late TabController tabCtr;
  QuranPageCtr() {
    // deleteDb();
    readFromDb();
  }
  deleteDb() {
    GetStorage storage = GetStorage();

    storage.remove('markedList');
    printError(info: 'DELETED DB');
  }

  void readFromDb() {
    GetStorage storage = GetStorage();
    List<dynamic> listMap = storage.read('markedList') ?? [];
    selectedSurah.selectedQuranReader.value = QuranReaders.values[GetStorage().read<int>('selectedQuranReader') ?? 0];
    for (var element in listMap) markedList.add(MarkedPage.fromJson(element));
  }

  void updateDb(MarkedPage pageProp) {
    GetStorage storage = GetStorage();
    List<Map> listMap = [];
    for (var element in markedList) listMap.add(element.toJson());

    storage.write('markedList', listMap);
  }
}

class SelectedSurah {
  // SelectedSurah({
  //   required this.juz,
  //   required this.pageNumber,
  //   required this.surahNumber,
  //   required this.surahName,
  //   required this.startAyahNum,
  //   required this.endAyahNum,
  //   required this.totalAyahsNum,
  //   required this.readerName,
  // });
  RxInt juz = 0.obs;
  RxInt pageNumber = 0.obs;
  RxInt surahNumber = 0.obs;
  RxString surahName = ''.obs;
  RxInt startAyahNum = 0.obs;
  RxInt endAyahNum = 0.obs;
  RxInt totalAyahsNum = 0.obs;
 Rx<QuranReaders> selectedQuranReader = QuranReaders.alafasi.obs;
}
