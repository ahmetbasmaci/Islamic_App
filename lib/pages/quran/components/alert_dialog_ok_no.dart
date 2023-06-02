import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/my_texts.dart';
import 'package:zad_almumin/services/theme_service.dart';

class AlertDialogOkNo extends GetView<ThemeCtr> {
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
      title: MyTexts.settingsTitle(title: title),
      content: MyTexts.settingsContent(title: content),
      actions: [
        TextButton(
          onPressed: () async => onOk.call(),
          child: MyTexts.main(title: okText),
        ),
        TextButton(
          onPressed: () => onNo.call(),
          child: MyTexts.main(title: noText),
        ),
      ],
    );
  }
}
