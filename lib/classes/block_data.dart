
class BlockData {
  BlockData({required this.imageSource, required this.title,});

  final String imageSource;
  final String title;

  static List<BlockData> list = [
    BlockData(imageSource: "assets/images/morning.png", title: 'اذكار الصباح'),
    BlockData(imageSource: "assets/images/night.png", title: 'اذكار المساء'),
    BlockData(imageSource: "assets/images/wakeup.png", title: 'اذكار الاستيقاظ'),
    BlockData(imageSource: "assets/images/sleep.png", title: 'اذكار النوم'),
    BlockData(imageSource: "assets/images/suitcases.png", title: 'اذكار السفر'),
    BlockData(imageSource: "assets/images/food.png", title: 'اذكار الطعام'),
    BlockData(imageSource: "assets/images/mosque.png", title: 'اذكار المسجد'),
    BlockData(imageSource: "assets/images/home.png", title: 'اذكار المنزل'),
    BlockData(imageSource: "assets/images/toilet.png", title: 'اذكار الخلاء'),
    BlockData(imageSource: "assets/images/kaba.png", title: 'اذكار الحج'),
  ];
}
