import '../../../../../core/extentions/extentions.dart';

class HomeCardAyahModel {
  HomeCardAyahModel({
    required this.surahName,
    required this.surahNumber,
    required this.ayahNumber,
    required this.text,
    required this.page,
  });
  HomeCardAyahModel.empty({
    this.surahName = '',
    this.surahNumber = 0,
    this.ayahNumber = 0,
    this.text = '',
    this.page = 0,
  });
  String surahName;
  int surahNumber;
  int ayahNumber;
  int page;
  String text;

  factory HomeCardAyahModel.fromJson(Map<String, dynamic> json) {
    return HomeCardAyahModel(
      ayahNumber: json['numberInSurah'] ?? 0,
      text: json['text'].toString().isBasmalah ? '\n${json['text']}\n' : json['text'],
      page: json['page'],
      surahName: json['surah'] ?? '',
      surahNumber: 0,
    );
  }
}
