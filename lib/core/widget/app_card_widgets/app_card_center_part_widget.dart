import 'package:flutter/material.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';
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
          ? const AppLinearProgressIndicator()
          : Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: content),
                  TextSpan(
                    text: '\n\n$description',
                    style: AppStyles.contentBold,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
    );
  }
}
