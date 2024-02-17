import 'package:zad_almumin/features/quran/quran.dart';

class QuranCardModel {
  final String content;
  final String surahName;
  final int juz;
  final int ayahNumber;
  final int surahNumber;
  QuranCardModel({
    required this.content,
    required this.surahName,
    required this.juz,
    required this.ayahNumber,
    required this.surahNumber,
  });

  factory QuranCardModel.fromAyahModel(Ayah ayah) {
    return QuranCardModel(
      content: ayah.text,
      surahName: ayah.surahName,
      juz: ayah.juz,
      ayahNumber: ayah.number,
      surahNumber: ayah.surahNumber,
    );
  }

  QuranCardModel.empty()
      : content = '',
        surahName = '',
        juz = 0,
        ayahNumber = 0,
        surahNumber = 0;
}
