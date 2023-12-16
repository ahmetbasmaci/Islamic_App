import '../../../../core/services/json_service.dart';
import '../../../../core/utils/resources/resources.dart';
import '../../azkar.dart';

abstract class IZikrCardGetAllahNamesDataSource {
  Future<List<AllahNamesModel>> getAllahNamesModels();
}

class ZikrCardGetAllahNamesDataSource implements IZikrCardGetAllahNamesDataSource {
  List<AllahNamesModel> result = [];
  @override
  Future<List<AllahNamesModel>> getAllahNamesModels() async {
    if (result.isEmpty) await _loadAllahNamesDataList();

    return result;
  }

  Future<void> _loadAllahNamesDataList() async {
    var data = await JsonService.readJson(AppJsonPaths.allhNamesAzkarPath);
    List<dynamic> mapList = data['list'];

    for (var model in mapList) {
      result.add(AllahNamesModel.fromJson(model));
    }
  }
}
