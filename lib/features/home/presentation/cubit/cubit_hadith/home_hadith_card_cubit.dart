import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/usecase/params/params.dart';
import '../../../data/models/hadith_card_model.dart';
import '../../../domain/usecases/home_card_get_random_hadith_use_case.dart';

part 'home_hadith_card_state.dart';

class HomeHadithCardCubit extends Cubit<HomeHadithCardState> {
  HomeHadithCardCubit({required this.homeCardGetRandomHadithUseCase}) : super(HomeHadithCardInitial());
  final HomeCardGetRandomHadithUseCase homeCardGetRandomHadithUseCase;
  Future<void> getRandomHadith() async {
    emit(HomeHadithCardLoadingState());

    var result = await homeCardGetRandomHadithUseCase.call(NoParams());
    result.fold(
      (l) {
        emit(HomeHadithCardInitial());
        emit(HomeHadithCardFieldState(l.message));
      },
      (hadithCardModel) => emit(
        HomeHadithCardLoadedState(hadithCardModel: hadithCardModel),
      ),
    );
  }
}
