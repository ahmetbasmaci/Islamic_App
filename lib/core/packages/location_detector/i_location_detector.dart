import 'package:geolocator/geolocator.dart';

abstract class ILocationDetector {
  Future<Position?> get currentPosition;
}
