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

  List<Ayah> get getMarkedAyahs {
    List<Ayah> markedAyahs = [];
    var result = quranDataRepository.getSavedMarkedAyahs;

    result.fold(
      (l) => null,
      (markedPagesResult) => markedAyahs = markedPagesResult,
    );

    markedAyahs.sort((a, b) => a.page.compareTo(b.page));

    return markedAyahs;
  }

  List<MarkedPage> get getMarkedPages {
    List<MarkedPage> markedPages = [];
    var result = quranDataRepository.getSavedMarkedPages;

    result.fold(
      (l) => null,
      (markedPagesResult) => markedPages = markedPagesResult,
    );

    markedPages.sort((a, b) => a.pageNumber.compareTo(b.pageNumber));

    return markedPages;
  }

  void markedItemBtnPress(int page) {
    //TODO
    // _quranCtr.goToPage(page);
    // Get.back();
  }

  void goToPage(int page) {
    pageController.jumpToPage(page);
  }
}
