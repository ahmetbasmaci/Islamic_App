import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../quran.dart';

class QuranTextBodyPart extends StatelessWidget {
  final int page;
  const QuranTextBodyPart({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: _body(context));
  }

  Widget _body(BuildContext context) {
    List<Ayah> ayahs = context.read<QuranCubit>().getAyahsInPage(page);
    if (context.read<QuranCubit>().state.showTafseerPage) {
      return QuranTafseerPart(ayahs: ayahs);
    } else {
      return QuranTextPart(context: context, ayahs: ayahs);
    }
  }
}
