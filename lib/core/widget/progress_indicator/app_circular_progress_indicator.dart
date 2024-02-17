import 'package:flutter/material.dart';
import 'package:zad_almumin/core/utils/resources/app_gifs.dart';

class AppCircularProgressIndicator extends StatelessWidget {
  const AppCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: 1,
        child: AppGifs.loading,
      ),
    );
  }
}
