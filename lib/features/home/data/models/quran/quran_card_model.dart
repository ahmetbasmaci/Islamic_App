import 'package:zad_almumin/features/quran/quran.dart';

class QuranCardModel {
  final String content;
  final String surahName;
  final int juz;
  final int ayahNumber;
  final int surahNumber;
  final bool isFavorite;
  QuranCardModel({
    required this.content,
    required this.surahName,
    required this.juz,
    required this.ayahNumber,
    required this.surahNumber,
    this.isFavorite = false,
  });

  factory QuranCardModel.fromAyahModel(Ayah ayah) {
    return QuranCardModel(
      content: ayah.text,
      surahName: ayah.surahName,
      juz: ayah.juz,
      ayahNumber: ayah.number,
      surahNumber: ayah.surahNumber,
      isFavorite: false,
    );
  }
}
