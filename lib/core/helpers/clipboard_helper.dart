import 'package:flutter/services.dart';
import '../../config/local/l10n.dart';
import 'toats_helper.dart';
import '../utils/constants.dart';

class ClipboardHelper {
  static void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ToatsHelper.show(AppStrings.of(Constants.context).copiedToClipboard);
    Clipboard.getData(Clipboard.kTextPlain).then((value) {});
  }
}
