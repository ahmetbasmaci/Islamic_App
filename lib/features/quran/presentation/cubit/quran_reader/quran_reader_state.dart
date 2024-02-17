part of 'quran_reader_cubit.dart';

class QuranReaderState extends Equatable {
  final QuranReader selectedQuranReader;
  const QuranReaderState({required this.selectedQuranReader});
  const QuranReaderState.init() : selectedQuranReader = QuranReader.yaserAldosary;
  @override
  List<Object> get props => [selectedQuranReader];
}
