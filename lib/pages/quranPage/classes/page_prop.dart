class PageProp {
  PageProp({required this.pageNumber, required this.juz, required this.surahName});
  int pageNumber;
  int juz;
  String surahName;
  Map<String, dynamic> toJson() => {
        'pageNumber': pageNumber,
        'juz': juz,
        'surahName': surahName,
      };

  factory PageProp.fromJson(Map<dynamic, dynamic> json) => PageProp(
        pageNumber: json['pageNumber'] as int,
        juz: json['juz'] as int,
        surahName: json['surahName'] as String,
      );
}
