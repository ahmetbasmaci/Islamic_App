import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/utils/resources/app_constants.dart';
import 'package:zad_almumin/features/tafseer/tafseer.dart';

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
    for (var element in ayahs) {
      element.isMarked = true;
    }
    var tafseerModel = AppConstants.context.read<TafseerCubit>().state.tafseerDataModel;
    if (context.read<QuranCubit>().state.showTafseerPage && tafseerModel.surahs.isNotEmpty) {
      return QuranTafseerPart(ayahs: ayahs);
    } else {
      return QuranTextPart(ayahs: ayahs);
    }
  }
}
