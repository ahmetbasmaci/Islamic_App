import 'package:flutter/material.dart';

import '../../helpers/clipboard_helper.dart';
import '../../utils/resources/app_icons.dart';

class CopyButton extends StatefulWidget {
  const CopyButton({super.key, required this.content});
  final String content;
  @override
  State<CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<CopyButton> {
  bool isCopyed = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: Colors.transparent,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: isCopyed ? AppIcons.copyFilled : AppIcons.copy,
      ),
      onPressed: () => copyPressed(),
    );
  }

  Future<void> copyPressed() async {
    ClipboardHelper.copyText(widget.content);
    setState(() => isCopyed = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => isCopyed = false);
  }
}
