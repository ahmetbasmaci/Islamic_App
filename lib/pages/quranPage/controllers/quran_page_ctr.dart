import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/moduls/enums.dart';

import '../classes/page_prop.dart';

class QuranPageCtr extends GetxController {
  RxBool onShown = false.obs;
  RxList<PageProp> markedList = <PageProp>[].obs;
  // Rx<SelectedAyahs> selectedAyahs = SelectedAyahs(startNum: 5.obs).obs;
  RxInt ayahStartNum = 1.obs;
  RxInt ayahEndNum = 2.obs;
  RxInt totalAyahsCount = 10.obs;
  RxString readerName = 'ياسر سلامة'.obs;
  RxInt pageNumber = 0.obs;
  RxInt juz = 0.obs;
  RxString surahName = ''.obs;
  Rx<QuranReaders> selectedQuranReader = QuranReaders.alafasi.obs;
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
    selectedQuranReader.value = QuranReaders.values[GetStorage().read<int>('selectedQuranReader') ?? 0];
    for (var element in listMap) markedList.add(PageProp.fromJson(element));
  }

  void updateDb(PageProp pageProp) {
    GetStorage storage = GetStorage();
    List<Map> listMap = [];
    for (var element in markedList) listMap.add(element.toJson());

    storage.write('markedList', listMap);
  }
}

class SelectedAyahs {
  SelectedAyahs({required this.startNum, this.endNum = 10, this.readerName = 'ياسر سلامة'});
  RxInt startNum = 5.obs;
  int endNum;
  String readerName;
}
