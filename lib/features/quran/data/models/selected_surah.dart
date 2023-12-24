import '../../../../core/utils/enums/enums.dart';

class SelectedPageInfo {
  final int juz;
  final int pageNumber;
  final int surahNumber;
  final String surahName;
  final int startAyahNum;
  final int endAyahNum;
  final int totalAyahsNum;
  final QuranReaders selectedQuranReader;
  final int repeetAllCount;
  final int repeetAyahCount;
  final bool isUnlimitRepeatAll;
  final bool isUnlimitRepeatAyah;

  SelectedPageInfo({
    required this.juz,
    required this.pageNumber,
    required this.surahNumber,
    required this.surahName,
    required this.startAyahNum,
    required this.endAyahNum,
    required this.totalAyahsNum,
    required this.selectedQuranReader,
    required this.repeetAllCount,
    required this.repeetAyahCount,
    required this.isUnlimitRepeatAll,
    required this.isUnlimitRepeatAyah,
  });

  SelectedPageInfo.empty()
      : juz = 0,
        pageNumber = 0,
        surahNumber = 0,
        surahName = '',
        startAyahNum = 0,
        endAyahNum = 0,
        totalAyahsNum = 0,
        selectedQuranReader = QuranReaders.yaserAldosary,
        repeetAllCount = 1,
        repeetAyahCount = 1,
        isUnlimitRepeatAll = false,
        isUnlimitRepeatAyah = false;
}
