import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zad_almumin/core/extentions/enum_extentions.dart';
import 'package:zad_almumin/features/quran/quran.dart';

import '../../../../../core/utils/enums/enums.dart';

part 'quran_reader_state.dart';

class QuranReaderCubit extends Cubit<QuranReaderState> {
  final IQuranDataRepository quranDataRepository;
  QuranReaderCubit({required this.quranDataRepository}) : super(const QuranReaderState.init()) {
    updateQuranReader(readSavedReader);
  }

  void updateQuranReader(QuranReaders quranReader) {
    saveReader(quranReader);
    emit(QuranReaderState(selectedQuranReader: quranReader));
  }

  void saveReader(QuranReaders quranReader) {
    quranDataRepository.savedSelectedReader(quranReader);
  }

  QuranReaders get readSavedReader {
    QuranReaders selectedQuranReader = QuranReaders.yaserAldosary;
    var result = quranDataRepository.getSavedSelectedReader;
    result.fold(
      (l) => null,
      (savedReader) {
        selectedQuranReader = savedReader;
      },
    );
    return selectedQuranReader;
  }

  List<QuranReaders> get sortedQuranReader {
    return QuranReaders.values.toList()
      ..sort(
        (a, b) => a.translatedName.compareTo(b.translatedName),
      );
  }
}
