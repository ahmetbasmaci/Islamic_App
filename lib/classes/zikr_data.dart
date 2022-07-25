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
  });

  String title;
  String content;
  String description;
  int numberInQuran;
  int count;
  bool haveList;
  dynamic list = [];

  bool isFavorite;
  bool isCopyed;
  ZikrType zikrType;
}
