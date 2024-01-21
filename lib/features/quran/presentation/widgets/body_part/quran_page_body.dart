import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';

import '../../../quran.dart';

class QuranPageBody extends StatelessWidget {
  const QuranPageBody({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, snapshot) {
        return SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: DefaultTabController(
              length: 604,
              child: TabBarView(
                controller: context.read<QuranCubit>().tabCtr,
                children: quranBodys(context),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> quranBodys(BuildContext context) {
    List<Widget> quranPages = [];
    bool isMarked = false;
    List<bool> markedPages = _getMarkedPages(context);
    for (var page = 1; page <= 604; page++) {
      isMarked = markedPages[page];
      quranPages.add(
        _quranPageWidget(isMarked, context, page),
      );
    }
    return quranPages;
  }

  QuranBanner _quranPageWidget(bool isMarked, BuildContext context, int page) {
    return QuranBanner(
      isMarked: isMarked,
      child: InkWell(
        onTap: () => context.read<QuranCubit>().pagePressed(),
        onLongPress: () => context.read<QuranCubit>().showAddQuranPageMarkDialog(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          color: context.themeColors.background,
          child: context.read<QuranCubit>().state.quranViewModeInImages
              ? QuranPageBodyImages(page: page)
              : QuranPageBodyTexts(page: page),
        ),
      ),
    );
  }

  List<bool> _getMarkedPages(BuildContext context) {
    List<bool> markedPages = List.generate(605, (index) => false);
    for (var element in context.read<QuranCubit>().state.markedPages) {
      if (element.isMarked) markedPages[element.pageNumber] = true;
    }
    return markedPages;
  }
}
