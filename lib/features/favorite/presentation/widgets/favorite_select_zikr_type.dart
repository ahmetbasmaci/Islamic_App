import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/enum_extentions.dart';
import 'package:zad_almumin/core/widget/space/space.dart';
import 'package:zad_almumin/features/favorite/presentation/cubit/favorite_cubit.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/resources/resources.dart';

class FavoriteSelectZikrType extends StatelessWidget {
  const FavoriteSelectZikrType({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _icon(),
        _selectZikrTypeDropDown(context),
      ],
    );
  }

  Row _icon() {
    return Row(
      children: [
        AppIcons.menu,
        HorizontalSpace(AppSizes.spaceBetweanWidgets),
      ],
    );
  }

  Widget _selectZikrTypeDropDown(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        return DropdownButtonHideUnderline(
          child: DropdownButton<FavoriteZikrCategory>(
            value: context.read<FavoriteCubit>().state.favoriteZikrCategory,
            items: FavoriteZikrCategory.values
                .map(
                  (e) => DropdownMenuItem(value: e, child: Text(e.translatedName)),
                )
                .toList(),
            onChanged: (newSelectedType) {
              context.read<FavoriteCubit>().changeFavoriteZikrCategory(newSelectedType!);
            },
          ),
        );
      },
    );
  }
}
