import 'package:equatable/equatable.dart';

import '../../../../core/utils/enums/enums.dart';

class SelectedPageInfo extends Equatable {
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

  SelectedPageInfo copyWith({
    int? juz,
    int? pageNumber,
    int? surahNumber,
    String? surahName,
    int? startAyahNum,
    int? endAyahNum,
    int? totalAyahsNum,
    QuranReaders? selectedQuranReader,
    int? repeetAllCount,
    int? repeetAyahCount,
    bool? isUnlimitRepeatAll,
    bool? isUnlimitRepeatAyah,
  }) {
    return SelectedPageInfo(
      juz: juz ?? this.juz,
      pageNumber: pageNumber ?? this.pageNumber,
      surahNumber: surahNumber ?? this.surahNumber,
      surahName: surahName ?? this.surahName,
      startAyahNum: startAyahNum ?? this.startAyahNum,
      endAyahNum: endAyahNum ?? this.endAyahNum,
      totalAyahsNum: totalAyahsNum ?? this.totalAyahsNum,
      selectedQuranReader: selectedQuranReader ?? this.selectedQuranReader,
      repeetAllCount: repeetAllCount ?? this.repeetAllCount,
      repeetAyahCount: repeetAyahCount ?? this.repeetAyahCount,
      isUnlimitRepeatAll: isUnlimitRepeatAll ?? this.isUnlimitRepeatAll,
      isUnlimitRepeatAyah: isUnlimitRepeatAyah ?? this.isUnlimitRepeatAyah,
    );
  }

  @override
  List<Object?> get props => [
        juz,
        pageNumber,
        surahNumber,
        surahName,
        startAyahNum,
        endAyahNum,
        totalAyahsNum,
        selectedQuranReader,
        repeetAllCount,
        repeetAyahCount,
        isUnlimitRepeatAll,
        isUnlimitRepeatAyah,
      ];
}
