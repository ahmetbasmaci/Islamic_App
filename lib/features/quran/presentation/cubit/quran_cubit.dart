import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../quran.dart';
part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit() : super(QuranInitial());

  ScrollController scrollController = ScrollController();
  List<MarkedPage> markedList = [];
  bool showQuranImages = true;
  bool showTafseerPage = false;
  Ayah selectedAyah = Ayah.empty();
  double quranFontSize = 20;
  SelectedPageInfo selectedPage = SelectedPageInfo.empty();

  ItemScrollController _itemScrollController = ItemScrollController();
  ItemScrollController get itemScrollController {
    _itemScrollController = ItemScrollController();
    return _itemScrollController;
  }

  List<Ayah> getAyahsInCurrentPage() {
    return [];
  }

  void updateSelectedAyah(Ayah ayah) {
    selectedAyah = ayah;
  }

  int getJuzNumberByPage(int page) {
    return 1;
  }

  //
}
