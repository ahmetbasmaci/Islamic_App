import 'package:zad_almumin/constents/app_settings.dart';

class Ayah {
  Ayah({
    required this.ayahNumber,
    required this.audioUrl,
    required this.text,
    required this.juz,
    required this.page,
    required this.haveSajda,
    required this.audioPath,
    required this.surahName,
    required this.surahNumber,
    required this.isBasmalah,
    required this.isMarked,
  });
  Ayah.empty({
    this.ayahNumber = 0,
    this.audioUrl = '',
    this.text = '',
    this.juz = 0,
    this.page = 0,
    this.haveSajda = false,
    this.audioPath = '',
    this.surahName = '',
    this.surahNumber = 0,
    this.isBasmalah = false,
    this.isMarked = false,
  });
  int ayahNumber;
  String audioUrl;
  String text;
  int juz;
  int page;
  bool haveSajda;
  String audioPath;
  String surahName;
  int surahNumber;
  bool isBasmalah = false;
  bool isMarked = false;
  String get formatedAyahNumber => AppSettings.formatInt3.format(ayahNumber);
  String get formatedSurahNumber => AppSettings.formatInt3.format(surahNumber);

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      ayahNumber: json['numberInSurah'] ?? 0,
      audioUrl: json['audio'] ?? '',
      text: json['text'].toString().contains(AppSettings.basmalahTxt) ? '\n${json['text']}\n' : json['text'],
      juz: json['juz'],
      page: json['page'],
      haveSajda: false, //json['sajda'] ?? false,
      audioPath: '',
      surahName: json['surah'] ?? '',
      surahNumber: 0,
      isBasmalah: json['text'].toString().contains(AppSettings.basmalahTxt),
      isMarked: false,
    );
  }
}
