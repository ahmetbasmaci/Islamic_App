import 'package:zad_almumin/moduls/enums.dart';

class ZikrData {
  ZikrData({
    this.zikrType = ZikrType.none,
    this.title = '',
    this.content = '',
    this.description = '',
    this.numberInQuran = 0,
    this.count = -1,
    this.haveList = false,
    this.list,
    this.isFavorite = false,
    this.isCopyed = false,
    this.surahNumber = 0,
    this.isRandomAyah = true,
  });

  String title;
  String content;
  bool isFavorite;
  String description;

  int numberInQuran;
  int count;
  int surahNumber;
  bool haveList;
  bool isRandomAyah;
  dynamic list = [];

  bool isCopyed;
  ZikrType zikrType;

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'isFavorite': isFavorite,
        'description': description,
        'numberInQuran': numberInQuran,
        'count': count,
        'surahNumber': surahNumber,
        'haveList': haveList,
        'isRandomAyah': isRandomAyah,
        'list': list,
        'isCopyed': isCopyed,
        'zikrType': zikrType.name
      };
  fromJson(var data) {
    title = data['title'];
    content = data['content'];
    isFavorite = data['isFavorite'];
    description = data['description'];
    numberInQuran = data['numberInQuran'];
    count = data['count'];
    surahNumber = data['surahNumber'];
    haveList = data['haveList'];
    isRandomAyah = data['isRandomAyah'];
    list = data['list'];
    isCopyed = data['isCopyed'];
    zikrType = ZikrType.values.firstWhere(
      (element) => element.name == data['zikrType'],
    );
  }
}

class ZikrData2 {
  ZikrData2({
    required this.title,
    required this.content,
    required this.isFavorite,
    required this.isCopyed,
    required this.zikrType,
  });
  String title;
  String content;
  bool isFavorite;
  bool isCopyed;
  ZikrType zikrType;
  Map<String, dynamic> toJson() =>
      {'title': title, 'content': content, 'isFavorite': isFavorite, 'isCopyed': isCopyed, 'zikrType': zikrType.name};

  fromJson(var data) {
    title = data['title'];
    content = data['content'];
    isFavorite = data['isFavorite'];
    isCopyed = data['isCopyed'];
    zikrType = ZikrType.values.firstWhere(
      (element) => element.name == data['zikrType'],
    );
  }
}

class QuranZikrData extends ZikrData2 {
  QuranZikrData({
    required super.title,
    required super.content,
    required super.isFavorite,
    required super.isCopyed,
    super.zikrType = ZikrType.quran,
    required this.numberInQuran,
    required this.surahNumber,
    required this.isRandomAyah,
  });
  int numberInQuran;
  int surahNumber;
  bool isRandomAyah;
  @override
  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'isFavorite': isFavorite,
        'numberInQuran': numberInQuran,
        'surahNumber': surahNumber,
        'isRandomAyah': isRandomAyah,
        'isCopyed': isCopyed,
        'zikrType': zikrType.name
      };

  @override
  fromJson(var data) {
    title = data['title'];
    content = data['content'];
    isFavorite = data['isFavorite'];
    numberInQuran = data['numberInQuran'];
    surahNumber = data['surahNumber'];
    isRandomAyah = data['isRandomAyah'];
    isCopyed = data['isCopyed'];
    zikrType = ZikrType.values.firstWhere(
      (element) => element.name == data['zikrType'],
    );
  }
}

class HadithZikrData extends ZikrData2 {
  HadithZikrData({
    required super.title,
    required super.content,
    required super.isFavorite,
    required super.isCopyed,
    super.zikrType = ZikrType.hadith,
  });
  @override
  Map<String, dynamic> toJson() =>
      {'title': title, 'content': content, 'isFavorite': isFavorite, 'isCopyed': isCopyed, 'zikrType': zikrType.name};
  @override
  fromJson(var data) {
    title = data['title'];
    content = data['content'];
    isFavorite = data['isFavorite'];
    isCopyed = data['isCopyed'];
    zikrType = ZikrType.values.firstWhere(
      (element) => element.name == data['zikrType'],
    );
  }
}

class AllahNamesZikrData extends ZikrData2 {
  AllahNamesZikrData({
    required super.title,
    required super.content,
    required super.isFavorite,
    required super.isCopyed,
    super.zikrType = ZikrType.allahNames,
  });

  @override
  Map<String, dynamic> toJson() =>
      {'title': title, 'content': content, 'isFavorite': isFavorite, 'isCopyed': isCopyed, 'zikrType': zikrType.name};
  @override
  fromJson(var data) {
    title = data['title'];
    content = data['content'];
    isFavorite = data['isFavorite'];
    isCopyed = data['isCopyed'];
    zikrType = ZikrType.values.firstWhere(
      (element) => element.name == data['zikrType'],
    );
  }
}

class AzkarZikrData extends ZikrData2 {
  AzkarZikrData({
    required super.title,
    required super.content,
    required super.isFavorite,
    required super.isCopyed,
    super.zikrType = ZikrType.azkar,
    required this.description,
    required this.count,
    required this.haveList,
    required this.list,
  });
  String description;
  int count;
  bool haveList;
  dynamic list = [];
  @override
  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'isFavorite': isFavorite,
        'description': description,
        'count': count,
        'haveList': haveList,
        'list': list,
        'isCopyed': isCopyed,
        'zikrType': zikrType.name
      };
  @override
  fromJson(var data) {
    title = data['title'];
    content = data['content'];
    isFavorite = data['isFavorite'];
    description = data['description'];
    count = data['count'];
    haveList = data['haveList'];
    list = data['list'];
    isCopyed = data['isCopyed'];
    zikrType = ZikrType.values.firstWhere(
      (element) => element.name == data['zikrType'],
    );
  }
}

class Test {
  void a() {
    ZikrData2 z =
        HadithZikrData(title: 'title', content: 'content', isFavorite: true, isCopyed: true, zikrType: ZikrType.hadith);
    z.fromJson('{"title":"title","content":"content","isFavorite":true,"isCopyed":true,"zikrType":"hadith"}');
  }
}
