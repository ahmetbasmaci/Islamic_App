import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../quran.dart';

class QuranTextPart extends StatelessWidget {
  final BuildContext context;
  final List<Ayah> ayahs;
  const QuranTextPart({super.key, required this.context, required this.ayahs});

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: context.read<QuranCubit>().scrollController,
      children: [
        QuranRichText(
          textSpanChilderen: [
            ...ayahs.map(
              (ayah) => _basmalahOrAyahBody(ayah, context),
            ),
          ],
        ),
      ],
    );
  }

  InlineSpan _basmalahOrAyahBody(Ayah ayah, BuildContext context) {
    if (ayah.isBasmalah) {
      return QuranBasmalahWidget(
        context: context,
        ayah: ayah,
      );
    } else {
      return QuranAyahWidget(
        context: context,
        ayah: ayah,
      );
    }
  }
}
