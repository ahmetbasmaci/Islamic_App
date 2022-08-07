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
}
