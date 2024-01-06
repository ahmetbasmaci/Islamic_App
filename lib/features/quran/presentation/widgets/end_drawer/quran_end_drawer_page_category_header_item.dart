import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import '../../../../../core/utils/resources/resources.dart';
import '../../../quran.dart';

class QuranEndDrawerPageCategoryHeaderItem extends StatelessWidget {
  final String title;
  final Icon icon;
  final int index;
  const QuranEndDrawerPageCategoryHeaderItem({
    super.key,
    required this.title,
    required this.icon,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: _backgroundColor(context),
        child: InkWell(
          child: _iconAndText(context),
          onTap: () {
            context.read<QuranEndDrawerCubit>().goToPage(index);
          },
        ),
      ),
    );
  }

  Column _iconAndText(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon.icon,
          color: _itemsColor(context),
        ),
        Text(
          title,
          style: AppStyles.content.copyWith(
            color: _itemsColor(context),
          ),
        )
      ],
    );
  }

  Color _backgroundColor(BuildContext context) {
    return context.read<QuranEndDrawerCubit>().state.currentPage == index
        ? context.themeColors.primary
        : Colors.transparent;
  }

  Color _itemsColor(BuildContext context) {
    return context.read<QuranEndDrawerCubit>().state.currentPage == index
        ? context.themeColors.background
        : context.themeColors.primary;
  }
}
