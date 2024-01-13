import 'package:equatable/equatable.dart';

class SelectedTafseerIdModel extends Equatable {
  final int arabicId;
  final int englishId;

  const SelectedTafseerIdModel({
    required this.arabicId,
    required this.englishId,
  });
  const SelectedTafseerIdModel.init()
      : arabicId = 0,
        englishId = 0;
  factory SelectedTafseerIdModel.fromJson(Map<String, dynamic> json) {
    
    return SelectedTafseerIdModel(
      arabicId: json['arabicId'],
      englishId: json['englishId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'arabicId': arabicId,
      'englishId': englishId,
    };
  }

  SelectedTafseerIdModel copyWith({
    int? arabicId,
    int? englishId,
  }) {
    return SelectedTafseerIdModel(
      arabicId: arabicId ?? this.arabicId,
      englishId: englishId ?? this.englishId,
    );
  }

  @override
  List<Object?> get props => [arabicId, englishId];
}
