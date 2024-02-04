import 'package:zad_almumin/core/utils/enums/enums.dart';

class FavoriteZikrDataModel {
  final String title;
  final String content;
  final String description;
  final FavoriteZikrCategory category;

  FavoriteZikrDataModel({
    required this.title,
    required this.content,
    required this.description,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'description': description,
      'category': category.index,
    };
  }

  factory FavoriteZikrDataModel.fromJson(Map<String, dynamic> json) {
    return FavoriteZikrDataModel(
      title: json['title'],
      content: json['content'],
      description: json['description'],
      category: FavoriteZikrCategory.values[json['category']],
    );
  }
}
