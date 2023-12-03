class SurahTafseer {
    int surahNumber;
  String surahName;
  List<AyahTafseer> ayahsTafseer;

  SurahTafseer({
    required this.surahNumber,
    required this.surahName,
    required this.ayahsTafseer,
  });

  factory SurahTafseer.fromJson(Map<String, dynamic> json) {
    return SurahTafseer(
      surahNumber: json['surah_number'],
      surahName: json['surah_name'],
      ayahsTafseer: List<AyahTafseer>.from(json['ayahs_tafseer'].map((x) => AyahTafseer.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'surah_number': surahNumber,
      'surah_name': surahName,
      'ayahs_tafseer': List<dynamic>.from(ayahsTafseer.map((x) => x.toJson())),
    };
  }
}

class AyahTafseer {
  int tafseerId;
  String tafseerName;
  int ayahNumber;
  String tafseerText;
  int surahNumber;
  String surahName;

  AyahTafseer({
    required this.tafseerId,
    required this.tafseerName,
    required this.ayahNumber,
    required this.tafseerText,
    required this.surahNumber,
    required this.surahName,
  });

  factory AyahTafseer.fromJson(Map json) {
    return AyahTafseer(
      tafseerId: json['tafseer_id'],
      tafseerName: json['tafseer_name'],
      ayahNumber: json['ayah_number'],
      tafseerText: json['text'],
      surahNumber: json['surah_number'] ?? 0,
      surahName: json['surah_name'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tafseer_id': tafseerId,
      'tafseer_name': tafseerName,
      'ayah_number': ayahNumber,
      'tafseer_text': tafseerText,
      'surah_number': surahNumber,
      'surah_name': surahName,
    };
  }
}


