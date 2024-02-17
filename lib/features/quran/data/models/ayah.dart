import 'package:equatable/equatable.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';

class Ayah extends Equatable {
  final int number;
  final String text;
  final int juz;
  final int page;
  final bool haveSajda;
  final String surahName;
  final int surahNumber;
  final bool isBasmalah;
  bool isMarked;
  Ayah({
    required this.number,
    required this.text,
    required this.juz,
    required this.page,
    required this.haveSajda,
    required this.surahName,
    required this.surahNumber,
    required this.isBasmalah,
    required this.isMarked,
  });
  Ayah.empty()
      : number = 0,
        text = '',
        juz = 0,
        page = 0,
        haveSajda = false,
        surahName = '',
        surahNumber = 0,
        isBasmalah = false,
        isMarked = false;

  Ayah copyWith({
    int? number,
    String? audioUrl,
    String? text,
    int? juz,
    int? page,
    bool? haveSajda,
    String? audioPath,
    String? surahName,
    int? surahNumber,
    bool? isBasmalah,
    bool? isMarked,
  }) {
    return Ayah(
      number: number ?? this.number,
      text: text ?? this.text,
      juz: juz ?? this.juz,
      page: page ?? this.page,
      haveSajda: haveSajda ?? this.haveSajda,
      surahName: surahName ?? this.surahName,
      surahNumber: surahNumber ?? this.surahNumber,
      isBasmalah: isBasmalah ?? this.isBasmalah,
      isMarked: isMarked ?? this.isMarked,
    );
  }

  factory Ayah.fromJson(dynamic json) {
    return Ayah(
      number: json['numberInSurah'] ?? 0,
      text: json['text'].toString().isBasmalah ? '\n${json['text']}\n' : json['text'],
      juz: json['juz'],
      page: json['page'],
      haveSajda: json['sajda'] ?? false,
      surahName: json['surahName'] ?? '',
      surahNumber: int.tryParse(json['surahNumber'].toString()) ?? 0,
      isBasmalah: json['text'].toString().isBasmalah,
      isMarked: json['markedAyah'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'numberInSurah': number,
        'text': text,
        'juz': juz,
        'page': page,
        'haveSajda': haveSajda,
        'surahName': surahName,
        'surahNumber': surahNumber,
        'isBasmalah': isBasmalah,
        'markedAyah': isMarked,
      };

  @override
  List<Object?> get props => [text];
}
