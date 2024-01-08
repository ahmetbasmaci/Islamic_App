import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/utils/params/params.dart';
import '../../../../config/local/l10n.dart';
import '../../../../core/utils/resources/app_constants.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/resources/resources.dart';
import '../../azkar.dart';

part 'azkar_state.dart';

class AzkarCubit extends Cubit<AzkarState> {
  AzkarCubit({
    required this.zikrCardGetZikrUseCase,
    required this.zikrCardGetAllahNamesUseCase,
  }) : super(AzkarpageInitialState());
  final ZikrCardGetZikrUseCase zikrCardGetZikrUseCase;
  final ZikrCardGetAllahNamesUseCase zikrCardGetAllahNamesUseCase;

  final List<ZikrCategoryModel> zikrCategoryModelsAllAzkars = [
    ZikrCategoryModel(
      title: AppStrings.of(AppConstants.context).morningZikr,
      category: ZikrCategories.morning,
      imagePath: AppImages.morning,
    ),
    ZikrCategoryModel(
      title: AppStrings.of(AppConstants.context).eveningZikr,
      category: ZikrCategories.evening,
      imagePath: AppImages.evening,
    ),
    ZikrCategoryModel(
      title: AppStrings.of(AppConstants.context).sleepZikr,
      category: ZikrCategories.sleep,
      imagePath: AppImages.sleep,
    ),
    ZikrCategoryModel(
      title: AppStrings.of(AppConstants.context).wakeUpZikr,
      category: ZikrCategories.wakeUp,
      imagePath: AppImages.wakeUp,
    ),
    ZikrCategoryModel(
      title: AppStrings.of(AppConstants.context).homeZikr,
      category: ZikrCategories.home,
      imagePath: AppImages.home,
    ),
    ZikrCategoryModel(
      title: AppStrings.of(AppConstants.context).travelZikr,
      category: ZikrCategories.travel,
      imagePath: AppImages.travel,
    ),
    ZikrCategoryModel(
      title: AppStrings.of(AppConstants.context).eatingZikr,
      category: ZikrCategories.eating,
      imagePath: AppImages.eating,
    ),
    ZikrCategoryModel(
      title: AppStrings.of(AppConstants.context).mosqueZikr,
      category: ZikrCategories.mosque,
      imagePath: AppImages.mosque,
    ),
    ZikrCategoryModel(
      title: AppStrings.of(AppConstants.context).toiletZikr,
      category: ZikrCategories.toilet,
      imagePath: AppImages.toilet,
    ),
    ZikrCategoryModel(
      title: AppStrings.of(AppConstants.context).hajZikr,
      category: ZikrCategories.haj,
      imagePath: AppImages.kaba,
    ),
  ];
  final List<ZikrCategoryModel> zikrCategoryModelsAllahNames = [
    ZikrCategoryModel(
      title: AppStrings.of(AppConstants.context).allahNamesZikr,
      category: ZikrCategories.allahNames,
      imagePath: AppImages.quran,
    ),
  ];

  var scrollController = ScrollController();

  Future<void> readData(ZikrCategories zikrCategory) async {
    emit(AzkarpageLoadingState());
    if (zikrCategory == ZikrCategories.allahNames) {
      _raedAllahNames();
    } else {
      _raedAllAzkar(zikrCategory);
    }
  }

  Future<void> _raedAllahNames() async {
    var result = await zikrCardGetAllahNamesUseCase.call(NoParams());
    result.fold(
      (l) => emit(AzkarpageFieldState(l.message)),
      (allahNamesDataList) => emit(AzkarpageLoadedState(allahNamesDataList: allahNamesDataList)),
    );
  }

  Future<void> _raedAllAzkar(ZikrCategories zikrCategory) async {
    var result = await zikrCardGetZikrUseCase.call(GetZikrCardDataParams(zikrCategory: zikrCategory));
    result.fold(
      (l) => emit(AzkarpageFieldState(l.message)),
      (zikrDataList) => emit(AzkarpageLoadedState(zikrDataList: zikrDataList)),
    );
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
