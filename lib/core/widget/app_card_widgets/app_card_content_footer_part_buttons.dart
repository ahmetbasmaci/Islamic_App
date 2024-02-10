import 'package:flutter/material.dart';
import '../buttons/copy_button.dart';
import '../../../features/favorite_button/presentation/widgets/favorite_button.dart';
import '../buttons/share_button.dart';

class AppCardContentFooterPartButtons extends StatelessWidget {
  const AppCardContentFooterPartButtons({
    super.key,
    required this.isFavorite,
    required this.content,
  });
  final String content;
  final bool isFavorite;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CopyButton(content: content),
        ShareButton(content: content),
        FavoriteButton(content: content,isFavorite: isFavorite),
      ],
    );
  }
}
