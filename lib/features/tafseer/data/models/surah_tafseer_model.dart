import 'package:equatable/equatable.dart';

import '../../tafseer.dart';

class SurahTafseerModel extends Equatable {
  int surahNumber;
  List<AyahTafseerModel> ayahsTafseer;

  SurahTafseerModel({
    required this.surahNumber,
    required this.ayahsTafseer,
  });

  factory SurahTafseerModel.fromJson(dynamic json, int surahNumber) {
    return SurahTafseerModel(
      surahNumber: surahNumber,
      ayahsTafseer: (json as List<dynamic>).map((e) => AyahTafseerModel.fromJson(e, surahNumber)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'surah_number': surahNumber,
      'ayahs_tafseer': List<dynamic>.from(ayahsTafseer.map((x) => x.toJson())),
    };
  }

  @override
  List<Object?> get props => [surahNumber, ayahsTafseer];
}
