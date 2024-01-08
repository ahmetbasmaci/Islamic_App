import 'package:zad_almumin/core/packages/local_storage/local_storage.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';

abstract class ITafseerSelectedDataSource {
  Future<void> saveSelectedTafseer(int tafseerId);
}

class TafseerSelectedDataSource implements ITafseerSelectedDataSource {
  ILocalStorage localStorage;

  TafseerSelectedDataSource({required this.localStorage});
  @override
  Future<void> saveSelectedTafseer(int tafseerId) async {
    await localStorage.write(AppStorageKeys.selectedTafseerId, tafseerId);
  }
}
