import 'package:get/get.dart';
import 'package:zad_almumin/moduls/enums.dart';

class TafseerModel {
  int id;
  String name;
  String language;
  String author;
  String bookName;
  Rx<DownloadState> downloadState;
  TafseerModel({
    required this.id,
    required this.name,
    required this.language,
    required this.author,
    required this.bookName,
    required this.downloadState,
  });

  factory TafseerModel.fromJson(Map<String, dynamic> json) {
    return TafseerModel(
      id: json['id'],
      name: json['name'],
      language: json['language'],
      author: json['author'],
      bookName: json['book_name'],
      downloadState: DownloadState.values.firstWhere((element) => element.name == json['downloadState'].toString()).obs,
    );
  }
}
