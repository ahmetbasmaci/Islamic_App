import 'package:flutter/material.dart';

import '../../utils/resources/app_icons.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.isFavorite});
  final bool isFavorite;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: isFavorite ? AppIcons.favoriteFilled : AppIcons.favorite,
      ),
    );
  }
}
