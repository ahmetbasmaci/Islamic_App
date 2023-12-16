import 'package:flutter/material.dart';
import '../../../../core/utils/resources/app_icons.dart';

class RefereshBtnRounded extends StatelessWidget {
  RefereshBtnRounded({super.key, required this.onPress});
  VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: Colors.transparent,
      onPressed: onPress,
      icon: AppIcons.refresh,
    );
  }
}
