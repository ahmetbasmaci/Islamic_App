
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../classes/page_prop.dart';

class QuranPageCtr extends GetxController {
  RxBool onShown = false.obs;
  RxList<PageProp> markedList = <PageProp>[].obs;
  QuranPageCtr() {
    readFromDb();
  }
  void readFromDb() {
    GetStorage storage = GetStorage();
    List<dynamic> listMap = storage.read('markedList') ?? [];
    for (var element in listMap) markedList.add(PageProp.fromJson(element));
  }

  void updateDb(PageProp pageProp) {
    GetStorage storage = GetStorage();
    List<Map> listMap = [];
    for (var element in markedList) listMap.add(element.toJson());

    storage.write('markedList', listMap);
  }
}
