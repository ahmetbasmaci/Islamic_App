import 'dart:math';
import '../../../../core/services/json_service.dart';
import '../../../../core/utils/resources/app_json_paths.dart';
import '../../home.dart';

abstract class IHomeCardGetRandomHadithDataSource {
  Future<HadithCardModel> getRandomHadith();
}

class HomeCardGetRandomHadithDataSource implements IHomeCardGetRandomHadithDataSource {
  List<HadithData> allHadithData = [];
  @override
  Future<HadithCardModel> getRandomHadith() async {
    if (allHadithData.isEmpty) await _loadHadithData();

    int randomBook = Random().nextInt(allHadithData.length) + 1;

    HadithData hadithData = allHadithData.elementAt(randomBook - 1);

    int randomChapter = Random().nextInt(hadithData.chapeters.length);

    HadithBookChapeters chapter = hadithData.chapeters.elementAt(randomChapter);

    List<Hadith> hadiths = chapter.hadiths;
    if (hadiths.isEmpty) return getRandomHadith();

    int randomHadith = Random().nextInt(hadiths.length);
    Hadith hadith = hadiths.elementAt(randomHadith);
    return HadithCardModel(
      hadithBookName: 'Albukhari book',
      chapterBookname: hadithData.bookName,
      chapterName: chapter.chapterName,
      hadithId: hadith.hadithId,
      hadithSanad: hadith.sanad,
      hadithText: hadith.text,
    );
  }

  _loadHadithData() async {
    List<dynamic> data = await JsonService.readJson(AppJsonPaths.hadithBookPath);
    if (data.isEmpty) return;
    allHadithData = data.map((e) => HadithData.fromJson(e)).toList();
  }
}
