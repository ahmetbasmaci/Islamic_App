import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/src/injection_container.dart';
import '../../../../core/utils/resources/app_icons.dart';
import '../../favorite_button.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.content, required this.isFavorite});
  final bool isFavorite;
  final String content;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetItManager.instance.favoriteButtonCubit..checkIfItemIsFavorite(content),
      child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
        builder: (context, state) {
          return IconButton(
            onPressed: () => context.read<FavoriteButtonCubit>().changeFavoriteStatus(content),
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isFavorite ? AppIcons.favoriteFilled : AppIcons.favorite,
            ),
          );
        },
      ),
    );
  }
}
