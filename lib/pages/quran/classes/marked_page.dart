class MarkedPage {
  MarkedPage({required this.pageNumber, required this.juz, required this.surahName, required this.isMarked});
  int pageNumber;
  int juz;
  String surahName;
  bool isMarked;
  Map<String, dynamic> toJson() => {
        'pageNumber': pageNumber,
        'juz': juz,
        'surahName': surahName,
        'isMarked': isMarked,
      };

  factory MarkedPage.fromJson(Map<dynamic, dynamic> json) => MarkedPage(
        pageNumber: json['pageNumber'] as int,
        juz: json['juz'] as int,
        surahName: json['surahName'] as String,
        isMarked: json['isMarked'] as bool,
      );
}
