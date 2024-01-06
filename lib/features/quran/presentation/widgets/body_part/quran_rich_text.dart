import 'package:flutter/material.dart';

import '../../../../../core/utils/resources/resources.dart';

class QuranRichText extends StatelessWidget {
  final List<InlineSpan> textSpanChilderen;
  const QuranRichText({super.key, required this.textSpanChilderen});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.justify,
      textDirection: TextDirection.rtl,
      text: TextSpan(
        children: textSpanChilderen,
        style: AppStyles.quran,
      ),
    );
  }
}
