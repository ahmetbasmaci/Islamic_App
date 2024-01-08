import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import '../../../features/alarm/data/models/alarm_model.dart';
import '../enums/enums.dart';

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetZikrCardDataParams extends Equatable {
  ZikrCategories zikrCategory;

  GetZikrCardDataParams({required this.zikrCategory});
  @override
  List<Object?> get props => [zikrCategory];
}

class GetAlarmDataPartParams extends Equatable {
  final AlarmPart aLarmType;

  const GetAlarmDataPartParams({required this.aLarmType});
  @override
  List<Object?> get props => [aLarmType];
}

class UpdateAlarmModelParams extends Equatable {
  final AlarmModel alarmModel;

  const UpdateAlarmModelParams({required this.alarmModel});
  @override
  List<Object?> get props => [alarmModel];
}

class GetPrayTimeParams extends Equatable {
  final Position position;
  final DateTime date;

  const GetPrayTimeParams({required this.position, required this.date});
  @override
  List<Object?> get props => [position, date];
}

class GetNextAyahParams extends Equatable {
  final int ayahNumber;
  final int surahNumber;

  const GetNextAyahParams({required this.ayahNumber, required this.surahNumber});
  @override
  List<Object?> get props => [ayahNumber, surahNumber];
}

class DownloadTafseerParams extends Equatable {
  final int tafseerId;

  const DownloadTafseerParams({required this.tafseerId});
  @override
  List<Object?> get props => [tafseerId];
}

class TafseerIdParams extends Equatable {
  final int tafseerId;

  const TafseerIdParams({required this.tafseerId});
  @override
  List<Object?> get props => [tafseerId];
}

class WriteDataIntoFileAsBytesSyncParams extends Equatable {
  final int tafseerId;
  final List<int> data;

  const WriteDataIntoFileAsBytesSyncParams({required this.tafseerId, required this.data});
  @override
  List<Object?> get props => [tafseerId, data];
}
