import 'package:equatable/equatable.dart';

class SelectedPageInfo extends Equatable {
  final int juz;
  final int pageNumber;
  final int surahNumber;
  final String surahName;

  const SelectedPageInfo({
    required this.juz,
    required this.pageNumber,
    required this.surahNumber,
    required this.surahName,
  });

  const SelectedPageInfo.empty()
      : juz = 0,
        pageNumber = 0,
        surahNumber = 0,
        surahName = '';

  SelectedPageInfo copyWith({
    int? juz,
    int? pageNumber,
    int? surahNumber,
    String? surahName,
  }) {
    return SelectedPageInfo(
      juz: juz ?? this.juz,
      pageNumber: pageNumber ?? this.pageNumber,
      surahNumber: surahNumber ?? this.surahNumber,
      surahName: surahName ?? this.surahName,
    );
  }

  @override
  List<Object?> get props => [
        juz,
        pageNumber,
        surahNumber,
        surahName,
      ];
}
