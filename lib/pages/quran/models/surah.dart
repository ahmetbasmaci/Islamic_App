import 'package:zad_almumin/pages/quran/models/ayah.dart';

class Surah {
  Surah({required this.name, required this.startAtPage, required this.ayahs, required this.number});
  String name;
  int startAtPage;
  int number;
  List<Ayah> ayahs = [];

  factory Surah.fromjson(Map<String, dynamic> json) {
    List<Ayah> ayahs = [];
    for (var ayah in json['ayahs']) {
      Ayah newAyah = Ayah.fromJson(ayah);
      newAyah.surahName = json['name'];
      newAyah.surahNumber = json['number'];
      ayahs.add(newAyah);
    }
    return Surah(
      name: json['name'],
      startAtPage: ayahs[0].page,
      number: json['number'],
      ayahs: ayahs,
    );
  } 
}
