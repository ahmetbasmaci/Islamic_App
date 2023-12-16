import 'package:equatable/equatable.dart';
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
  ALarmType aLarmType;

  GetAlarmDataPartParams({required this.aLarmType});
  @override
  List<Object?> get props => [aLarmType];
}
