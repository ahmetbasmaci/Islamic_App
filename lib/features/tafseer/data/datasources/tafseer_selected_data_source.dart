import 'package:zad_almumin/core/packages/local_storage/local_storage.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';

import '../../tafseer.dart';

abstract class ITafseerSelectedDataSource {
  Future<void> saveSelectedTafseer(SelectedTafseerIdModel tafseerIdModel);
  Future<SelectedTafseerIdModel> get getSelectedTafseerId;
}

class TafseerSelectedDataSource implements ITafseerSelectedDataSource {
  ILocalStorage localStorage;

  TafseerSelectedDataSource({required this.localStorage});
  @override
  Future<void> saveSelectedTafseer(SelectedTafseerIdModel tafseerIdModel) async {
    await localStorage.write(AppStorageKeys.selectedTafseerId, tafseerIdModel.toJson());
  }

  @override
  Future<SelectedTafseerIdModel> get getSelectedTafseerId async {
    var result = await localStorage.read(AppStorageKeys.selectedTafseerId);
    if (result.isEmpty) return const SelectedTafseerIdModel.init();

    SelectedTafseerIdModel selectedTafseerIdModel = SelectedTafseerIdModel.fromJson(result);
    return selectedTafseerIdModel;
  }
}
