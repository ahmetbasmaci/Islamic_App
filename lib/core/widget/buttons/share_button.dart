import 'package:flutter/material.dart';

import '../../utils/resources/app_icons.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({
    super.key,
    required this.content,
  });
  final String content;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: Colors.transparent,
      onPressed: () {
        // Share.share(content);
      },
      icon: AnimatedSwitcher(duration: const Duration(milliseconds: 300), child: AppIcons.share),
    );
  }
}
