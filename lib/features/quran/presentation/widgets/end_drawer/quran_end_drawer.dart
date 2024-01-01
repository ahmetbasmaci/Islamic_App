import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import 'package:zad_almumin/src/injection_container.dart';

import '../../../../../core/utils/resources/resources.dart';
import '../../../../../core/widget/animations/animated_list_item_down_to_up.dart';
import '../../../quran.dart';

class QuranEndDrawer extends StatelessWidget {
  const QuranEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<QuranEndDrawerCubit>(),
      child: BlocBuilder<QuranEndDrawerCubit, QuranEndDrawerState>(
        builder: (context, state) {
          return SafeArea(
            child: Drawer(
              width: context.width * 0.6,
              child: Column(
                children: [
                  SizedBox(height: context.height * 0.01),
                  _pagesTitles(context),
                  Divider(color: context.themeColors.primary),
                  _pages(context)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Expanded _pages(BuildContext context) {
    List<Ayah> markedAyahs = context.read<QuranEndDrawerCubit>().getMarkedAyahs;
    List<MarkedPage> markedPages = context.read<QuranEndDrawerCubit>().getMarkedPages;
    return Expanded(
      child: PageView(
        controller: context.read<QuranEndDrawerCubit>().pageController,
        children: [
          _pageChild(
            itemsCount: markedPages.length,
            itemChild: (int index) => markedListTile(
              context: context,
              title: '${'الجزء'} ${markedPages[index].juz}',
              subtitle:
                  '${markedPages[index].surahName.withOutTashkil}  |  ${'الصفحة'} ${markedPages[index].pageNumber}',
              page: markedPages[index].pageNumber,
            ),
          ),
          _pageChild(
            itemsCount: markedAyahs.length,
            itemChild: (int index) => markedListTile(
              context: context,
              title: markedAyahs[index].text,
              subtitle:
                  '${markedAyahs[index].surahName.withOutTashkil}  |  ${'الصفحة'} ${markedAyahs[index].page} | ${'الجزء'} ${markedAyahs[index].juz}',
              page: markedAyahs[index].page,
            ),
          ),
        ],
      ),
    );
  }

  Row _pagesTitles(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        markCategory(
          context: context,
          title: 'الصفحات',
          icon: AppIcons.addBookMark,
          index: 0,
        ),
        markCategory(
          context: context,
          title: 'الايات',
          icon: AppIcons.book,
          index: 1,
        ),
      ],
    );
  }

  Widget _pageChild({
    required int itemsCount,
    required Widget Function(int) itemChild,
  }) {
    return Scrollbar(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemCount: itemsCount,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: index != itemsCount - 1 ? 10 : 0),
            child: AnimatedListItemDownToUp(
              index: index,
              child: itemChild(index),
            ),
          );
        },
      ),
    );
  }

  Expanded markCategory({
    required BuildContext context,
    required String title,
    required Icon icon,
    required int index,
  }) {
    return Expanded(
      child: Container(
        color: context.read<QuranEndDrawerCubit>().state.currentPage == index
            ? context.themeColors.primary
            : Colors.transparent,
        child: InkWell(
          child: Column(
            children: [
              icon = Icon(
                icon.icon,
                color: context.read<QuranEndDrawerCubit>().state.currentPage == index
                    ? context.themeColors.background
                    : context.themeColors.primary,
              ),
              Text(
                title,
                style: AppStyles.content.copyWith(
                  color: context.read<QuranEndDrawerCubit>().state.currentPage == index
                      ? context.themeColors.background
                      : context.themeColors.primary,
                ),
              )
            ],
          ),
          onTap: () {
            context.read<QuranEndDrawerCubit>().goToPage(index);
          },
        ),
      ),
    );
  }

  Widget markedListTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required int page,
  }) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          onTap: () => context.read<QuranEndDrawerCubit>().markedItemBtnPress(page),
        ),
        Divider(color: context.themeColors.primary)
      ],
    );
  }
}
