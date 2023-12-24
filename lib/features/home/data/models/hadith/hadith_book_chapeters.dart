import '../../../home.dart';

class HadithBookChapeters {
  final int chapterID;
  final String chapterName;
  List<Hadith> hadiths;

  HadithBookChapeters({
    required this.chapterID,
    required this.chapterName,
    required this.hadiths,
  });

  HadithBookChapeters.fromJson(dynamic json)
      : chapterID = json['chapterID'],
        chapterName = json['chapterName'],
        hadiths = json['hadiths'] != null
            ? (json['hadiths'] as List<dynamic>).map((e) => Hadith.fromJson(e)).toList()
            : [Hadith.empty()];
  // hadiths = json['hadiths'] != null ? json['hadiths'].map((e) => Hadith.fromJson(e)).toList() : [Hadith.empty()];
}
