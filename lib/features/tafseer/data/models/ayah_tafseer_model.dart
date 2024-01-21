import 'package:equatable/equatable.dart';

class AyahTafseerModel extends Equatable {
  final int tafseerId;
  final String tafseerName;
  final int ayahNumber;
  final String tafseerText;
  final int surahNumber;

  const AyahTafseerModel({
    required this.tafseerId,
    required this.tafseerName,
    required this.ayahNumber,
    required this.tafseerText,
    required this.surahNumber,
  });

  factory AyahTafseerModel.fromJson(Map json, int surahNumber) {
    return AyahTafseerModel(
      tafseerId: json['tafseer_id'],
      tafseerName: json['tafseer_name'],
      ayahNumber: json['ayah_number'],
      tafseerText: json['text'],
      surahNumber: surahNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tafseer_id': tafseerId,
      'tafseer_name': tafseerName,
      'ayah_number': ayahNumber,
      'tafseer_text': tafseerText,
      'surah_number': surahNumber,
    };
  }

  @override
  List<Object?> get props => [tafseerId, tafseerName, ayahNumber, tafseerText, surahNumber];
}
