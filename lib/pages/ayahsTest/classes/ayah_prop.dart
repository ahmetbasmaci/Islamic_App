
class AyahProp {
  int juz;
  int page;
  String ayah;
  String surah;

  AyahProp({required this.juz, required this.page, required this.ayah, required this.surah});

  factory AyahProp.fromJson(Map<String, dynamic> json) {
    return AyahProp(
      juz: json['juz'],
      page: json['page'],
      ayah: json['ayah'],
      surah: json['surah'],
    );
  }
}