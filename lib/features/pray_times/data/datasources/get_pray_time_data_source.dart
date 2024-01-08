import 'package:geolocator/geolocator.dart';
import 'package:zad_almumin/core/utils/enums/enums.dart';
import '../../../../core/error/exceptions/app_exceptions.dart';
import '../../../../core/packages/app_internet_connection/app_internet_connection.dart';
import '../../../../core/utils/api/api.dart';
import '../models/praies_in_day_model.dart';

abstract class IGetPrayTimeDataSource {
  Future<PraiesInDayModel> getPrayTime(Position position, DateTime date);
}

class GetPrayTimeDataSource implements IGetPrayTimeDataSource {
  final ApiConsumer apiConsumer;
  final IAppInternetConnection appInternetConnection;
  GetPrayTimeDataSource({required this.appInternetConnection, required this.apiConsumer});
  @override
  Future<PraiesInDayModel> getPrayTime(Position position, DateTime date) async {
    AppConnectivityResult connectivityResult = await appInternetConnection.checkAppConnectivity();
    if (connectivityResult == AppConnectivityResult.none) {
      throw ServerException('No Internet Connection');
    }
    String apiUrl = AdhanApi.timings(position: position, date: date);
    var json = await apiConsumer.get(apiUrl);
    PraiesInDayModel praiesInDayModel = PraiesInDayModel.fromJson(json);
    return praiesInDayModel;
  }
}
