import 'package:flutter/material.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';

import '../../utils/resources/resources.dart';

class AlertDialogOkNo extends StatelessWidget {
  AlertDialogOkNo(
      {super.key,
      required this.title,
      required this.content,
      required this.okText,
      required this.noText,
      required this.onOk,
      required this.onNo});

  String title;
  String content;
  String okText;
  String noText;
  VoidCallback onOk;
  VoidCallback onNo;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: AppStyles.title2),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () async => onOk.call(),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              context.theme.colorScheme.primary,
            ),
          ),
          child: Text(
            okText,
            style: AppStyles.content.copyWith(
              color: context.theme.colorScheme.background,
            ),
          ),
        ),
        TextButton(
          onPressed: () => onNo.call(),
          child: Text(
            noText,
            style: AppStyles.content.copyWith(
              color: context.theme.colorScheme.error,
            ),
          ),
        ),
      ],
    );
  }
}
