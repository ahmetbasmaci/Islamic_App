part of 'quran_reader_cubit.dart';

class QuranReaderState extends Equatable {
  final QuranReaders selectedQuranReader;
  const QuranReaderState({required this.selectedQuranReader});
  const QuranReaderState.init() : selectedQuranReader = QuranReaders.yaserAldosary;
  @override
  List<Object> get props => [selectedQuranReader];
}
