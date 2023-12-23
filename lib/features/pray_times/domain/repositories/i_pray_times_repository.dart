import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';

import '../../data/models/praies_in_day_model.dart';

abstract class IPrayTimesRepository {
  Future<Either<Failure, PraiesInDayModel>> getPrayTime(Position position, DateTime date);
}
