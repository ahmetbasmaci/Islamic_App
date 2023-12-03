import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/services/theme_service.dart';

class PlayPauseAnimatedBtn extends GetView<ThemeCtr> {
  PlayPauseAnimatedBtn({
    super.key,
    required this.animationCtr,
    required this.onTap,
  });

  AnimationController animationCtr;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    context.theme;
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: MyColors.zikrCard,
          boxShadow: [
            BoxShadow(
              color: MyColors.black.withOpacity(.6),
              blurRadius: 5,
              offset: Offset(0, 5),
            )
          ],
        ),
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(left: 8),
        child: AnimatedIcon(icon: AnimatedIcons.play_pause, progress: animationCtr),
      ),
    );
  }
}
