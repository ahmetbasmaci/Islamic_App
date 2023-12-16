class AllahNamesModel {
  final String name;
  final String content;

  AllahNamesModel({
    required this.name,
    required this.content,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'content': content,
      };

  factory AllahNamesModel.fromJson(Map<String, dynamic> json) => AllahNamesModel(
        name: json['name'],
        content: json['content'],
      );
}
