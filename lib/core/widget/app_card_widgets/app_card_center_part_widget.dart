import 'package:flutter/material.dart';
import '../progress_indicator/app_linear_progress_indicator.dart';

class AppCardCenterPartWidget extends StatelessWidget {
  const AppCardCenterPartWidget({
    super.key,
    required this.content,
    this.description = '',
    this.isLoading = false,
  });

  final String content;
  final String description;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? AppLinearProgressIndicator()
          : Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: content),
                  TextSpan(
                    text: '\n\n$description',
                    style: TextStyle(fontWeight: FontWeight.bold),                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
    );
  }
}
