import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/quran/quran.dart';
import '../../utils/resources/app_icons.dart';

class AddBookMarkButton extends StatelessWidget {
  final bool isMarked;
  final Ayah ayah;
  final VoidCallback? onDone;
  const AddBookMarkButton({
    super.key,
    required this.isMarked,
    required this.ayah,
    this.onDone,
  });
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<QuranCubit>().addBookMarkToAyah(ayah);
        context.read<QuranCubit>().hideSelectedAyah();
        onDone?.call();
      },
      icon: isMarked ? AppIcons.bookmarkAdded : AppIcons.bookmarkAdd,
    );
  }
}
