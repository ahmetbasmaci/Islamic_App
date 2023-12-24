import 'package:geolocator/geolocator.dart';
import '../../helpers/dialogs/dialogs_helper.dart';
import 'i_location_detector.dart';

class LocationDetector implements ILocationDetector {
  Position? _currentPosition;
  @override
  Future<Position?> get currentPosition async {
    if (_currentPosition != null) return _currentPosition;

    _currentPosition = await _determinePosition();
    return _currentPosition;
  }

  Future<Position?> _determinePosition() async {
    bool serviceEnabled = await _checkServiceEnabled();
    if (!serviceEnabled) return null;

    LocationPermission permission = await _checkPermission();
    if (permission == LocationPermission.denied) return null;

    // Permissions are denied forever, handle appropriately.
    if (permission == LocationPermission.deniedForever)
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');

    return await Geolocator.getCurrentPosition();
  }

  Future<bool> _checkServiceEnabled() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      bool okHitted = await DialogsHelper.showAllowAppToUseLocationDialog();
      if (okHitted) {
        serviceEnabled = await Geolocator.openLocationSettings();
      }
    }
    return serviceEnabled;
  }

  Future<LocationPermission> _checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      bool userOk = await DialogsHelper.showAllowAppToUseLocationDialog();
      if (userOk) {
        permission = await Geolocator.requestPermission();
      }
    }
    return permission;
  }
}
