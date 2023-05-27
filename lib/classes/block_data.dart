class BlockData {
  BlockData({
    required this.imageSource,
    required this.title,
  });

  final String imageSource;
  final String title;

  static List<BlockData> list = [
    BlockData(imageSource: "assets/images/morning.png", title: 'أذكار الصباح'),
    BlockData(imageSource: "assets/images/night.png", title: 'أذكار المساء'),
    BlockData(imageSource: "assets/images/wakeup.png", title: 'أذكار الاستيقاظ'),
    BlockData(imageSource: "assets/images/sleep.png", title: 'أذكار النوم'),
    BlockData(imageSource: "assets/images/suitcases.png", title: 'أذكار السفر'),
    BlockData(imageSource: "assets/images/food.png", title: 'أذكار الطعام'),
    BlockData(imageSource: "assets/images/mosque.png", title: 'أذكار المسجد'),
    BlockData(imageSource: "assets/images/home.png", title: 'أذكار المنزل'),
    BlockData(imageSource: "assets/images/toilet.png", title: 'أذكار الخلاء'),
    BlockData(imageSource: "assets/images/kaba.png", title: 'أذكار الحج'),
  ];
}
