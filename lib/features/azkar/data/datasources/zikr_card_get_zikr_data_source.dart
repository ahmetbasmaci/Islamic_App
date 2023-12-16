import '../../../../core/services/json_service.dart';
import '../../../../core/utils/resources/app_json_paths.dart';


import '../../../../core/utils/enums/enums.dart';
import '../../azkar.dart';

abstract class IZikrCardGetZikrDataSource {
  Future<List<ZikrCardModel>> getAllZikrModels(ZikrCategories zikrCategory);
}

class ZikrCardGetZikrDataSource implements IZikrCardGetZikrDataSource {
  List<dynamic> allAzkars = [];
  @override
  Future<List<ZikrCardModel>> getAllZikrModels(ZikrCategories zikrCategory) async {
    if (allAzkars.isEmpty) await _loadAllAzkars();
    List<ZikrCardModel> result = await _loadZikrDataList(zikrCategory);

    return result;
  }

  Future<void> _loadAllAzkars() async {
    var data = await JsonService.readJson(AppJsonPaths.allAzkarPath);
    allAzkars = data['allAzkar'];
  }

  Future<List<ZikrCardModel>> _loadZikrDataList(ZikrCategories zikrCategory) async {
    List<ZikrCardModel> result = [];

    for (var element in allAzkars) {
      if (element['zikrCategory'] == zikrCategory.name) {
        var azkarList = element['azkarList'];
        for (var model in azkarList) {
          result.add(ZikrCardModel.fromJson(model));
        }
        break;
      }
    }
    return result;
  }
}
