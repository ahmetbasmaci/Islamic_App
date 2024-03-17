import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/params/params.dart';
import '../../../../home.dart';
part 'home_quran_card_state.dart';

class HomeQuranCardCubit extends Cubit<HomeQuranCardState> {
  final HomeCardGetRandomAyahUseCase homeCardGetRandomAyahUseCase;
  final HomeCardGetNextAyahUseCase homeCardGetNextAyahUseCase;
  HomeQuranCardCubit({required this.homeCardGetRandomAyahUseCase, required this.homeCardGetNextAyahUseCase})
      : super(HomeQuranCardInitialState());

  Future<void> getRandomAyah() async {
    emit(HomeQuranCardLoadingState());
    var result = await homeCardGetRandomAyahUseCase.call(NoParams());
    result.fold(
      (l) => emit(HomeQuranCardErrorState(message: l.message)),
      (ayah) {
        QuranCardModel quranCardModel = QuranCardModel.fromAyahModel(ayah);
        emit(HomeQuranCardLoadedState(quranCardModel: quranCardModel));
      },
    );
  }

  Future<void> setNextAyah(int surahNumber, int ayahNumber) async {
    emit(HomeQuranCardLoadingState());
    var result = await homeCardGetNextAyahUseCase.call(GetNextAyahParams(
      ayahNumber: ayahNumber + 1,
      surahNumber: surahNumber,
    ));
    result.fold(
      (l) => emit(HomeQuranCardErrorState(message: l.message)),
      (ayah) {
        QuranCardModel quranCardModel = QuranCardModel.fromAyahModel(ayah);
        emit(HomeQuranCardLoadedState(quranCardModel: quranCardModel));
      },
    );
  }
}
