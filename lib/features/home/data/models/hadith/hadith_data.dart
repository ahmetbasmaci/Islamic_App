import '../../../home.dart';

class HadithData {
  final int bookID;
  final String bookName;
  final List<HadithBookChapeters> chapeters;

  HadithData({
    required this.bookID,
    required this.bookName,
    required this.chapeters,
  });

  HadithData.fromJson(Map<String, dynamic> json)
      : bookID = int.parse(json['bookID']),
        bookName = json['bookName'],
        chapeters = (json['chaptars'] as List<dynamic>).map((e) => HadithBookChapeters.fromJson(e)).toList();
}
