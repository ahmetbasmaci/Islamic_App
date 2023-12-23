import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import 'package:zad_almumin/features/pray_times/data/datasources/get_pray_time_data_source.dart';

import 'package:zad_almumin/features/pray_times/data/models/praies_in_day_model.dart';

import '../../domain/repositories/i_pray_times_repository.dart';

class PrayTimesRepository implements IPrayTimesRepository {
  IGetPrayTimeDataSource getPrayTimeDataSource;

  PrayTimesRepository({required this.getPrayTimeDataSource});

  @override
  Future<Either<Failure, PraiesInDayModel>> getPrayTime(Position position, DateTime date) async {
    try {
      var result = await getPrayTimeDataSource.getPrayTime(position, date);
      return Right(result);
    } catch (e) {
      print(e);
      return Left(ServerFailure(e.toString()));
    }
  }
}
