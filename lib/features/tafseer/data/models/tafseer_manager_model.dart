import 'package:equatable/equatable.dart';

import '../../../../core/utils/enums/enums.dart';

class TafseerManagerModel extends Equatable{
  final int id;
  final String name;
  final String language;
  final String author;
  final String bookName;
  DownloadState downloadState;
  TafseerManagerModel({
    required this.id,
    required this.name,
    required this.language,
    required this.author,
    required this.bookName,
    required this.downloadState,
  });

  factory TafseerManagerModel.fromJson(Map<String, dynamic> json) {
    return TafseerManagerModel(
      id: json['id'],
      name: json['name'],
      language: json['language'],
      author: json['author'],
      bookName: json['book_name'],
      downloadState: DownloadState.values.firstWhere((element) => element.name == json['downloadState'].toString()),
    );
  }

  @override
  List<Object?> get props => [id, name, language, author, bookName, downloadState];
}
