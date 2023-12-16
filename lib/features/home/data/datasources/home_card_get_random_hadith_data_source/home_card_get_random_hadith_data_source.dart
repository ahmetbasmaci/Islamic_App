import 'dart:math';
import '../../../../../core/services/json_service.dart';
import '../../../../../core/utils/resources/app_json_paths.dart';
import '../../models/hadith_card_model.dart';

abstract class IHomeCardGetRandomHadithDataSource {
  Future<HadithCardModel> getRandomHadith();
}

class HomeCardGetRandomHadithDataSource implements IHomeCardGetRandomHadithDataSource {
  List<dynamic> allHadithData = [];
  @override
  Future<HadithCardModel> getRandomHadith() async {
    if (allHadithData.isEmpty) await _loadHadithData();

    int randomBook = Random().nextInt(allHadithData.length) + 1;
    Map<String, dynamic> hadithBookData = allHadithData[randomBook - 1];
    List<dynamic> hadithChaptarsMap = hadithBookData['chaptars'];

    int randomChapter = Random().nextInt(hadithChaptarsMap.length);
    List hadithsMap = hadithChaptarsMap[randomChapter]['hadiths'];
    if (hadithsMap.isEmpty) return getRandomHadith();

    int randomHadith = Random().nextInt(hadithsMap.length);

    return HadithCardModel(
      hadithBookName: "Annon book",
      categoryBookname: hadithBookData['bookName'].toString(),
      chapterName: hadithChaptarsMap[randomChapter]['chapterName'].toString(),
      hadithId: int.parse(hadithsMap[randomHadith]['hadithId']),
      hadithSanad: hadithsMap[randomHadith]['sanad'].toString(),
      hadithText: hadithsMap[randomHadith]['text'].toString(),
    );
  }

  _loadHadithData() async {
    allHadithData = await JsonService.readJson(AppJsonPaths.hadithBookPath);
  }
}
