import 'package:get/get.dart';

import '../../../moduls/enums.dart';

class SelectedSurah {
  RxInt juz = 0.obs;
  RxInt pageNumber = 0.obs;
  RxInt surahNumber = 0.obs;
  RxString surahName = ''.obs;
  RxInt startAyahNum = 0.obs;
  RxInt endAyahNum = 0.obs;
  RxInt totalAyahsNum = 0.obs;
  Rx<QuranReaders> selectedQuranReader = QuranReaders.alafasi.obs;
}