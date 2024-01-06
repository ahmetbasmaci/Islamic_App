import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';

import '../../../../../core/helpers/dialogs_helper.dart';
import '../../../../../core/utils/resources/resources.dart';
import '../../../quran.dart';

class QuranAyahWidget extends TextSpan {
  final BuildContext context;
  final Ayah ayah;
  QuranAyahWidget({required this.context, required this.ayah})
      : super(
          text: ayah.text,
          style: _textStyle(ayah, context),
          recognizer: _recognizer(context, ayah),
          children: [_markBetweanAyahsStyle(ayah, context)],
        );

  static LongPressGestureRecognizer _recognizer(BuildContext context, Ayah ayah) {
    return LongPressGestureRecognizer()
      ..onLongPressStart = (details) => onAyahLongPressStart(
            context,
            details,
            ayah,
          );
  }

  static TextSpan _markBetweanAyahsStyle(Ayah ayah, BuildContext context) {
    return TextSpan(
      text: ' ${ayah.number.arabicNumber} ',
      style: TextStyle(
        wordSpacing: 0,
        fontWeight: FontWeight.bold,
        fontFamily: AppFonts.uthmanic2.name,
        color: context.themeColors.primary,
      ),
    );
  }

  static TextStyle _textStyle(Ayah ayah, BuildContext context) {
    return TextStyle(
      wordSpacing: -1,
      background: Paint()
        ..color = _ayahBackgroudColor(ayah, context)
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.fill,
    );
  }

  static Color _ayahBackgroudColor(Ayah ayah, BuildContext context) {
    if (context.read<QuranCubit>().state.showTafseerPage) {
      return Colors.transparent;
    } else if (context.read<QuranCubit>().state.selectedAyah.number == ayah.number &&
        context.read<QuranCubit>().state.selectedAyah.surahNumber == ayah.surahNumber) {
      return context.themeColors.primary.withOpacity(0.2);
    } else if (context.read<QuranCubit>().state.markedAyahs.contains(ayah)) {
      ayah = ayah.copyWith(isMarked: true);
      return context.theme.colorScheme.secondary.withOpacity(0.2);
    } else {
      return Colors.transparent;
    }
  }

  static void onAyahLongPressStart(BuildContext context, LongPressStartDetails details, Ayah ayah) {
    context.read<QuranCubit>().updateSelectedAyah(ayah); //set selected ayah

    DialogsHelper.showSelectAyahBotToatsDialog(context: context, details: details, ayah: ayah);
  }
}
