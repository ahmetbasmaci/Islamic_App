import 'package:equatable/equatable.dart';
import 'package:zad_almumin/features/tafseer/tafseer.dart';

class TafseersDataModel extends Equatable {
  final int tafseerId;
  final List<SurahTafseerModel> surahs;

  const TafseersDataModel({
    required this.tafseerId,
    required this.surahs,
  });
  TafseersDataModel.init()
      : tafseerId = 0,
        surahs = [];

  factory TafseersDataModel.fromJson(dynamic json) {
    List<SurahTafseerModel> surahs = [];
    int tafseerId = 0;
    for (var surahNumber = 1; surahNumber <= 114; surahNumber++) {
      List surahTafseerMap = json['surahId_$surahNumber'];
      tafseerId = surahTafseerMap[0]["tafseer_id"];
      surahs.add(SurahTafseerModel.fromJson(surahTafseerMap, surahNumber));
    }
    return TafseersDataModel(
      tafseerId: tafseerId,
      surahs: surahs,
    );
  }
  @override
  List<Object?> get props => [tafseerId, surahs];
}
