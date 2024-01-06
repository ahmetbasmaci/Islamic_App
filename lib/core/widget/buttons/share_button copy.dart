import 'package:flutter/material.dart';

import '../../utils/resources/app_icons.dart';

class AddBookMarkButton extends StatelessWidget {
  const AddBookMarkButton({
    super.key,
    required this.isMarked,
  });
  final bool isMarked;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: Colors.transparent,
      onPressed: () {
        // Share.share(content);
      },
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: isMarked ? AppIcons.bookmarkAdded : AppIcons.bookmarkAdd,
      ),
    );
  }
}
