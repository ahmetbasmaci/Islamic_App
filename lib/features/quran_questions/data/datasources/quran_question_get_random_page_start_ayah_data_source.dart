import 'dart:math';

import '../../../../core/services/json_service.dart';
import '../../../../core/utils/resources/resources.dart';
import '../../../quran/quran.dart';

abstract class IQuranQuestionGetRandomPageStartAyahDataSource {
  Ayah getRandomPageStartAyah(int juzFrom, int juzTo, int pageFrom, int pageTo);
}

class QuranQuestionGetRandomPageStartAyahDataSource implements IQuranQuestionGetRandomPageStartAyahDataSource {
  final List<List<Ayah>> _pagesFirstAyahs = [];
  final IJsonService jsonService;

  QuranQuestionGetRandomPageStartAyahDataSource({required this.jsonService});

  Future<void> loadPagesFirstAyahs() async {
    List<dynamic> data = await jsonService.readJson(AppJsonPaths.firstAyahsFromEachPage);
    if (data.isEmpty) return;
    _parseData(data);
  }

  void _parseData(List<dynamic> data) {
    for (var i = 0; i < data.length; i++) {
      var juz = data[i];
      List<Ayah> pageFirstAyahs = [];
      for (var ayahs in juz) {
        pageFirstAyahs.add(Ayah.fromJson(ayahs));
      }
      _pagesFirstAyahs.add(pageFirstAyahs);
    }
  }

  @override
  Ayah getRandomPageStartAyah(int juzFrom, int juzTo, int pageFrom, int pageTo) {
    int randomJuz = juzFrom - 1;
    if (juzTo != juzFrom) {
      randomJuz = (Random().nextInt(juzTo - juzFrom + 1) + juzFrom) - 1;
    }

    int randomPage = pageFrom - 1;
    if (pageTo != pageFrom) {
      randomPage = (Random().nextInt(pageTo - pageFrom + 1) + pageFrom) - 1;
    }

    return _pagesFirstAyahs[randomJuz][randomPage];
  }
}
