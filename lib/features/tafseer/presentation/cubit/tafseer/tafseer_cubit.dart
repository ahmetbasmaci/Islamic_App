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
  final TafseerGetTafseerDataUseCase tafseerGetTafseerDataUseCase;
  TafseerCubit({
    required this.getTafseersUseCase,
    required this.tafseerSaveSelectedIdUseCase,
    required this.tafseerGetSelectedTafseerId,
    required this.tafseerGetTafseerDataUseCase,
  }) : super(TafseerState.init()) {
    // initTafseerPage();
  }

  int get selectedTafseerId {
    if (AppConstants.context.isArabicLang)
      return state.selectedTafseerId.arabicId;
    else
      return state.selectedTafseerId.englishId;
  }

  Future<List<TafseerManagerModel>> _loadTafseers() async {
    var result = await getTafseersUseCase.call(NoParams());
    List<TafseerManagerModel> tafseers = result.fold((l) => [], (r) => r);
    return tafseers;
  }

  void selectTafseer(TafseerManagerModel tafseerModel) async {
    var selectedTafseerModel = await _updateTafseerData(tafseerModel.id);
    if (AppConstants.context.isArabicLang) {
      emit(state.copyWith(
        tafseerDataModel: selectedTafseerModel,
        selectedTafseerId: state.selectedTafseerId.copyWith(arabicId: tafseerModel.id),
      ));
    } else
      emit(
        state.copyWith(
            tafseerDataModel: selectedTafseerModel,
            selectedTafseerId: state.selectedTafseerId.copyWith(englishId: tafseerModel.id)),
      );

    tafseerSaveSelectedIdUseCase.call(TafseerIdModelParams(tafseerIdModel: state.selectedTafseerId));
  }

  void initTafseerPage() async {
    var tafseers = await _loadTafseers();
    var savedTafseerId = await _getSavedSelectedTafseerId();
    var selectedTafseerModel = await _updateTafseerData(selectedTafseerId);
    emit(state.copyWith(
      tafseerModels: tafseers,
      selectedTafseerId: savedTafseerId,
      tafseerDataModel: selectedTafseerModel,
    ));
  }

  Future<SelectedTafseerIdModel> _getSavedSelectedTafseerId() async {
    var result = await tafseerGetSelectedTafseerId.call(NoParams());
    return result.fold((l) => const SelectedTafseerIdModel.init(), (r) => r);
  }

  Future<TafseersDataModel> _updateTafseerData(int tafseerId) async {
    var result = await tafseerGetTafseerDataUseCase.call(TafseerIdParams(tafseerId: tafseerId));

    TafseersDataModel tafseerDataModel = result.fold(
      (l) => TafseersDataModel.init(),
      (r) => r,
    );
    return tafseerDataModel;
  }
}
