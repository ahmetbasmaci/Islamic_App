import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../../config/local/l10n.dart';
import '../../../core/extentions/extentions.dart';

class SplahTextWidget extends StatelessWidget {
  const SplahTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: context.height * 0.1),
        child: AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText(
              AppStrings.of(context).appName,
              speed: const Duration(milliseconds: 200),
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ],
          isRepeatingAnimation: false,
          repeatForever: false,
          displayFullTextOnTap: false,
        ),
      ),
    );
  }
}
