import 'package:flutter/services.dart';
import '../../config/local/l10n.dart';
import 'toats_helper.dart';
import '../utils/resources/app_constants.dart';

class ClipboardHelper {
  ClipboardHelper._();
  static void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ToatsHelper.show(AppStrings.of(AppConstants.context).copiedToClipboard);
    Clipboard.getData(Clipboard.kTextPlain).then((value) {});
  }
}
