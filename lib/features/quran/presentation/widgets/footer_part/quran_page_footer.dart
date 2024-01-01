import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';
import 'package:zad_almumin/features/quran/quran.dart';

class QuranPageFooter extends StatelessWidget {
  const QuranPageFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        return _animatedParent(
          context: context,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              QuranFooterDownloadingProgressPart(),
              QuranFooterSelectReaderAndSurahParts(),
              QuranFooterButtonsPart(),
            ],
          ),
        );
      },
    );
  }

  Widget _animatedParent({required BuildContext context, required Widget child}) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      bottom: context.read<QuranCubit>().state.showTopFooterPart ? 0 : -AppSizes.downPartHeight,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: AppSizes.downPartHeight + (context.read<QuranCubit>().state.isLoading ? AppSizes.loadingRowHeight : 0),
        width: context.width,
        decoration: AppDecorations.quranBottmCard(context),
        child: child,
      ),
    );
  }
}
