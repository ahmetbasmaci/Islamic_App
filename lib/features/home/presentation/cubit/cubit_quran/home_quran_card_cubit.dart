import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/quran_card_model.dart';

part 'home_quran_card_state.dart';

class HomeQuranCardCubit extends Cubit<HomeQuranCardState> {
  HomeQuranCardCubit() : super(HomeQuranCardInitialState());

  Future<void> getRandomAyah() async {
    //TODO implement real code
    emit(HomeQuranCardLoadingState());
    await Future.delayed(Duration(seconds: 1));

    emit(
      HomeQuranCardLoadedState(
        quranCardModel: QuranCardModel(
          content: 'Ayha content',
          ayahNumber: 1,
          surahNumber: 1,
          isFavorite: false,
        ),
      ),
    );
  }

  Future<void> getNextAyah(int surahNumber, int ayahNumber) async {
    //TODO implement real code
    emit(HomeQuranCardLoadingState());
    await Future.delayed(Duration(seconds: 1));

    emit(
      HomeQuranCardLoadedState(
        quranCardModel: QuranCardModel(
          content: 'Ayha content',
          ayahNumber: 1,
          surahNumber: 1,
          isFavorite: false,
        ),
      ),
    );
  }  
}
