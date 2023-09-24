import 'package:zad_almumin/constents/assets_manager.dart';

class BlockData {
  BlockData({
    required this.imageSource,
    required this.title,
  });

  final String imageSource;
  final String title;

  static List<BlockData> list = [
    BlockData(imageSource: ImagesManager.morning, title: 'أذكار الصباح'),
    BlockData(imageSource: ImagesManager.night, title: 'أذكار المساء'),
    BlockData(imageSource: ImagesManager.wakeup, title: 'أذكار الاستيقاظ'),
    BlockData(imageSource: ImagesManager.sleep, title: 'أذكار النوم'),
    BlockData(imageSource: ImagesManager.suitcases, title: 'أذكار السفر'),
    BlockData(imageSource: ImagesManager.food, title: 'أذكار الطعام'),
    BlockData(imageSource: ImagesManager.mosque, title: 'أذكار المسجد'),
    BlockData(imageSource: ImagesManager.home, title: 'أذكار المنزل'),
    BlockData(imageSource: ImagesManager.toilet, title: 'أذكار الخلاء'),
    BlockData(imageSource: ImagesManager.kaba, title: 'أذكار الحج'),
  ];
}
