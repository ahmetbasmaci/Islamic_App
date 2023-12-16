class ZikrCardModel {
  ZikrCardModel({
    // required this.zikrCategory,
    this.title = '',
    this.content = '',
    this.description = '',
    this.count = 1,
    this.haveList = false,
    this.list,
    this.isFavorite = false,
  });
  // ZikrCategories zikrCategory;

  String title;
  String content;
  bool isFavorite;
  String description;

  int count;
  bool haveList;
  dynamic list = [];

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'isFavorite': isFavorite,
        'description': description,
        'count': count,
        'haveList': haveList,
        'list': list,
        // 'zikrCategory': zikrCategory.name
      };

  factory ZikrCardModel.fromJson(Map<String, dynamic> json) => ZikrCardModel(
        title: json['title'],
        content: json['zekr'] ?? '',
        isFavorite: json['isFavorite'] ?? false,
        description: json['description'] ?? '',
        count: int.parse(json['count'] ?? '0'),
        haveList: json['haveList'] ?? false,
        list: json['list'] ?? [],
        // zikrCategory: ZikrCategories.values.firstWhere((element) => element.name == json['zikrCategory']),
      );
}
