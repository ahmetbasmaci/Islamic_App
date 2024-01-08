import '../packages/local_storage/local_storage.dart';
import '../utils/app_router.dart';
import '../utils/resources/app_storage_keys.dart';

class PagesHelper {
  PagesHelper._();
  static final ILocalStorage _localStorage = LocalStorage();

  /// if it's the first time to open the app it will return splash page id else it will return the last opened page id
  static String get getPagePath {
    if (_isFirstTime) return AppRoutes.splash.path;

    return _getNewOpendPageId;
  }

  /// set the last opened page id
  static void setLastOpendPageId(AppRoutes route) => _localStorage.write(AppStorageKeys.lastOpendPagePath, route.path);

  static bool get _isFirstTime {
    bool isFirstTime = _localStorage.read<bool>(AppStorageKeys.isFirstTime) ?? true;

    if (isFirstTime) {
      _localStorage.write(AppStorageKeys.isFirstTime, false);
    }
    return isFirstTime;
  }

  static String get _getNewOpendPageId =>
      _localStorage.read<String>(AppStorageKeys.lastOpendPagePath) ?? AppRoutes.home.path;
}
