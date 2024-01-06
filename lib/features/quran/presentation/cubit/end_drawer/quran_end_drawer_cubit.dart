import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../quran.dart';

part 'quran_end_drawer_state.dart';

class QuranEndDrawerCubit extends Cubit<QuranEndDrawerState> {
  final IQuranDataRepository quranDataRepository;
  QuranEndDrawerCubit({required this.quranDataRepository}) : super(const QuranEndDrawerState.init()) {
    //pageController = PageController(initialPage: state.currentPage);
    pageController.addListener(() {
      if (pageController.page != null) {
        emit(QuranEndDrawerState(currentPage: pageController.page!.round()));
      }
    });
  }
  PageController pageController = PageController();

  void goToPage(int page) {
    pageController.jumpToPage(page);
  }
}
