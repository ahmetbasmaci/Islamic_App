import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../core/helpers/toats_helper.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/widget/app_scaffold.dart';
import '../../../../core/widget/progress_indicator/app_circular_progress_indicator.dart';
import '../../azkar.dart';

class AzkarPage extends StatelessWidget {
  const AzkarPage({super.key, required this.zikrCategoryModel});

  final ZikrCategoryModel zikrCategoryModel;

  @override
  Widget build(BuildContext context) {
    context.read<AzkarCubit>().readData(zikrCategoryModel.category);
    return AppScaffold(
      title: zikrCategoryModel.title,
      showDrawerBtn: false,
      body: _body(),
    );
  }

  BlocConsumer<AzkarCubit, AzkarState> _body() {
    return BlocConsumer<AzkarCubit, AzkarState>(
      listener: (context, state) {
        if (state is AzkarpageFieldState) {
          ToatsHelper.show(state.message);
        }
      },
      builder: ((context, state) {
        if (state is AzkarpageLoadingState) return const AppCircularProgressIndicator();

        var zikrDataList = state is AzkarpageLoadedState ? state.zikrDataList : [];
        var allahNamesDataList = state is AzkarpageLoadedState ? state.allahNamesDataList : [];
        var currentListLength =
            zikrCategoryModel.category == ZikrCategories.allahNames ? allahNamesDataList.length : zikrDataList.length;
        return _itemList(context, currentListLength, zikrDataList, allahNamesDataList);
      }),
    );
  }

  AnimationLimiter _itemList(
      BuildContext context, int currentListLength, List<dynamic> zikrDataList, List<dynamic> allahNamesDataList) {
    return AnimationLimiter(
      child: ListView.builder(
        controller: context.read<AzkarCubit>().scrollController,
        shrinkWrap: true,
        itemCount: currentListLength,
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (context, index) {
          return AppCardContentZikr(
            zikrModel: zikrCategoryModel.category != ZikrCategories.allahNames ? zikrDataList[index] : null,
            allahNamesModel: zikrCategoryModel.category == ZikrCategories.allahNames ? allahNamesDataList[index] : null,
            currentIndex: index,
            zikrCategoty: zikrCategoryModel.category,
          );
        },
      ),
    );
  }
}
