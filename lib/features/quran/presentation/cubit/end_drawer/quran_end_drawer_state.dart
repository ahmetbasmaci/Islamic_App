part of 'quran_end_drawer_cubit.dart';

class QuranEndDrawerState extends Equatable {
  final int currentPage;
  const QuranEndDrawerState({required this.currentPage});

  const QuranEndDrawerState.init() : currentPage = 0;

  @override
  List<Object> get props => [currentPage];
}
