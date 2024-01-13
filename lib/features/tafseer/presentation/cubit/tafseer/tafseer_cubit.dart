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
  final TafseerGetSelectedTafseerId tafseerGetSelectedTafseerId;
  TafseerCubit({
    required this.getTafseersUseCase,
    required this.tafseerSaveSelectedIdUseCase,
    required this.tafseerGetSelectedTafseerId,
  }) : super(TafseerState.init()) {
    _loadTafseers();
    getSelectedTafseerId();
  }

  int get selectedTafseerId {
    if (AppConstants.context.isArabicLang)
      return state.selectedTafseerId.arabicId;
    else
      return state.selectedTafseerId.englishId;
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
      emit(state.copyWith(selectedTafseerId: state.selectedTafseerId.copyWith(arabicId: tafseerModel.id)));
    else
      emit(state.copyWith(selectedTafseerId: state.selectedTafseerId.copyWith(englishId: tafseerModel.id)));

    tafseerSaveSelectedIdUseCase.call(TafseerIdModelParams(tafseerIdModel: state.selectedTafseerId));
  }

  void getSelectedTafseerId() async {
    var result = await tafseerGetSelectedTafseerId.call(NoParams());
    result.fold(
      (l) => emit(state.copyWith(message: l.message)),
      (savedSelectedTafseerId) {
        emit(state.copyWith(selectedTafseerId: savedSelectedTafseerId));
      },
    );
  }
}
