import 'package:flutter/material.dart';
import '../../../core/extentions/extentions.dart';

import '../../../core/utils/resources/app_images.dart';

class SplahImageWidget extends StatelessWidget {
  const SplahImageWidget({super.key, required this.opacity, required this.value, required this.scaleAnimation});
  final double opacity;
  final bool value;
  final Animation<double> scaleAnimation;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        curve: Curves.fastLinearToSlowEaseIn,
        duration: const Duration(seconds: 1),
        opacity: opacity,
        child: Container(
          decoration: BoxDecoration(
            color: context.themeColors.background,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: context.themeColors.primary.withOpacity(.5),
                blurRadius: 10,
                spreadRadius: 10,
              ),
            ],
          ),
          padding: const EdgeInsets.all(50),
          child: AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: const Duration(seconds: 1),
            height: value ? context.height * 0.05 : context.height * 0.15,
            width: value ? context.height * 0.05 : context.height * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(AppImages.appLogo),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(color: context.theme.primaryColor.withOpacity(0), shape: BoxShape.circle),
                child: AnimatedBuilder(
                  animation: scaleAnimation,
                  builder: (c, child) => Transform.scale(
                    scale: scaleAnimation.value,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.theme.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
