class HadithCardModel {
  HadithCardModel({
    required this.hadithBookName,
    required this.chapterBookname,
    required this.chapterName,
    required this.hadithText,
    required this.hadithSanad,
    required this.hadithId,
    this.isFavorite = false,
  });
  final String hadithBookName;
  final String chapterBookname;
  final String chapterName;
  final String hadithText;
  final String hadithSanad;
  final int hadithId;
  final bool isFavorite;
}
