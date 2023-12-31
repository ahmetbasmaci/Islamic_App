import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';

import '../../../../../core/utils/resources/resources.dart';
import '../../../quran.dart';

class QuranSeachDragTargetChipWidget extends StatelessWidget {
  final int index;
  const QuranSeachDragTargetChipWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranSearchCubit, QuranSearchState>(
      builder: (context, state) {
        FilterChipModel filterChipModel = context.read<QuranSearchCubit>().state.searchFilterList[index];

        return DragTarget<FilterChipModel>(
          builder: (context, candidateData, rejectedData) => dragChild(context, filterChipModel),
          onWillAccept: (newFilterChip) => true,
          onAccept: (newFilterChip) =>
              context.read<QuranSearchCubit>().updateSearchFilterList(index, filterChipModel, newFilterChip),
        );
      },
    );
  }

  Widget dragChild(BuildContext context, FilterChipModel filterChipModel) {
    Widget filterChip = _getFilterchip(filterChipModel, context);
    Widget childWhenDragging = _getFilterChipWhenDragging();
    return Draggable<FilterChipModel>(
      data: filterChipModel,
      childWhenDragging: childWhenDragging,
      feedback: Material(
        color: Colors.transparent,
        child: filterChip,
      ),
      child: filterChip,
    );
  }

  FilterChip _getFilterChipWhenDragging() {
    return const FilterChip(
      label: Text('           '),
      selected: false,
      onSelected: null,
    );
  }

  FilterChip _getFilterchip(FilterChipModel filterChipModel, BuildContext context) {
    return FilterChip(
      label: Text(
        filterChipModel.text,
        style: AppStyles.content.copyWith(
          color: filterChipModel.isSelected ? Colors.white : context.themeColors.onBackground,
        ),
      ),
      selected: filterChipModel.isSelected,
      selectedColor: context.themeColors.primary,
      checkmarkColor: context.themeColors.onBackground,
      onSelected: (value) => context.read<QuranSearchCubit>().updateSearchFilterChip(filterChipModel, value),
    );
  }
}
