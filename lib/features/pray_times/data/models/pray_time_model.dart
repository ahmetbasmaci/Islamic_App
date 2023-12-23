import '../../../../core/utils/enums/enums.dart';
import 'time.dart';

class PrayTimeModel {
  final PrayTimeType prayTimeType;
  final Time time;
  bool isNextPray;

  PrayTimeModel({
    required this.prayTimeType,
    required this.time,
    required this.isNextPray,
  });

  PrayTimeModel.empty()
      : time = Time.empty(),
        prayTimeType = PrayTimeType.none,
        isNextPray = false;
}
