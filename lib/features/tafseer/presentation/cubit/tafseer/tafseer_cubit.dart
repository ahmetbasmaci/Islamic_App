import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';

import '../../../../../core/utils/resources/app_constants.dart';
import '../../../../../core/utils/params/params.dart';
import '../../../tafseer.dart';

part 'tafseer_state.dart';

class TafseerCubit extends Cubit<TafseerState> {
  final TafseerGetManagerUseCase getTafseersUseCase;
  final TafseerSaveSelectedIdUseCase tafseerSaveSelectedIdUseCase;
  TafseerCubit({
    required this.getTafseersUseCase,
    required this.tafseerSaveSelectedIdUseCase,
  }) : super(TafseerState.init()) {
    _loadTafseers();
  }

  int get selectedTafseerId {
    if (AppConstants.context.isArabicLang)
      return state.selectedTafseerIdAr;
    else
      return state.selectedTafseerIdEn;
  }

  void _loadTafseers() async {
    var result = await getTafseersUseCase.call(NoParams());

    result.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (tafseers) => emit(state.copyWith(tafseerModels: tafseers)),
    );
  }

  void selectTafseer(TafseerManagerModel tafseerModel) {
    if (AppConstants.context.isArabicLang)
      emit(state.copyWith(selectedTafseerIdAr: tafseerModel.id));
    else
      emit(state.copyWith(selectedTafseerIdEn: tafseerModel.id));

    tafseerSaveSelectedIdUseCase.call(TafseerIdParams(tafseerId: tafseerModel.id));
  }
}
