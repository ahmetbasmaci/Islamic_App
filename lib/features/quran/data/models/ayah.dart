import 'package:equatable/equatable.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';

class Ayah extends Equatable {
  final int number;
  final String audioUrl;
  final String text;
  final int juz;
  final int page;
  final bool haveSajda;
  final String audioPath;
  final String surahName;
  final int surahNumber;
  final bool isBasmalah;
  bool isMarked;
  Ayah({
    required this.number,
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
  Ayah.empty()
      : number = 0,
        audioUrl = '',
        text = '',
        juz = 0,
        page = 0,
        haveSajda = false,
        audioPath = '',
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
      audioUrl: audioUrl ?? this.audioUrl,
      text: text ?? this.text,
      juz: juz ?? this.juz,
      page: page ?? this.page,
      haveSajda: haveSajda ?? this.haveSajda,
      audioPath: audioPath ?? this.audioPath,
      surahName: surahName ?? this.surahName,
      surahNumber: surahNumber ?? this.surahNumber,
      isBasmalah: isBasmalah ?? this.isBasmalah,
      isMarked: isMarked ?? this.isMarked,
    );
  }

  factory Ayah.fromJson(dynamic json) {
    return Ayah(
      number: json['numberInSurah'] ?? 0,
      audioUrl: json['audio'] ?? '',
      text: json['text'].toString().isBasmalah ? '\n${json['text']}\n' : json['text'],
      juz: json['juz'],
      page: json['page'],
      haveSajda: json['sajda'] ?? false,
      audioPath: json['audioPath'] ?? '',
      surahName: json['surahName'] ?? '',
      surahNumber: int.tryParse(json['surahNumber'].toString()) ?? 0,
      isBasmalah: json['text'].toString().isBasmalah,
      isMarked: json['markedAyah'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'numberInSurah': number,
        'audio': audioUrl,
        'text': text,
        'juz': juz,
        'page': page,
        'haveSajda': haveSajda,
        'audioPath': audioPath,
        'surahName': surahName,
        'surahNumber': surahNumber,
        'isBasmalah': isBasmalah,
        'markedAyah': isMarked,
      };

  @override
  List<Object?> get props => [text];
}
