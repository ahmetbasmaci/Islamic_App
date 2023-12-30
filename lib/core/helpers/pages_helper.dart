import '../packages/local_storage/local_storage.dart';
import '../utils/app_router.dart';
import '../utils/storage_keys.dart';

class PagesHelper {
  static final ILocalStorage _localStorage = LocalStorage();

  /// if it's the first time to open the app it will return splash page id else it will return the last opened page id
  static String get getPagePath {
    if (_isFirstTime) return AppRoutes.splash.path;

    return _getNewOpendPageId;
  }

  /// set the last opened page id
  static void setLastOpendPageId(AppRoutes route) => _localStorage.write(StorageKeys.lastOpendPagePath, route.path);

  static bool get _isFirstTime {
    bool isFirstTime = _localStorage.read<bool>(StorageKeys.isFirstTime) ?? true;

    if (isFirstTime) {
      _localStorage.write(StorageKeys.isFirstTime, false);
    }
    return isFirstTime;
  }

  static String get _getNewOpendPageId =>
      _localStorage.read<String>(StorageKeys.lastOpendPagePath) ?? AppRoutes.home.path;
}
