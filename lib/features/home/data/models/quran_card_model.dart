class QuranCardModel {
  QuranCardModel({
    required this.content,
    required this.ayahNumber,
    required this.surahNumber,
    this.isFavorite = false,
  });

  final String content;
  final int ayahNumber;
  final int surahNumber;
  final bool isFavorite;
}
