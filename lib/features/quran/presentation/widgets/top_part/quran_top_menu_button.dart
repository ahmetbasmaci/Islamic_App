import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/config/local/l10n.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import '../../../../../core/utils/resources/resources.dart';
import '../../../../theme/theme.dart';
import '../../../quran.dart';

class QuranTopMenuButton extends StatelessWidget {
  const QuranTopMenuButton({super.key});
  @override
  Widget build(BuildContext context) {
    return QuranAppbarButton(
      child: PopupMenuButton(
        color: context.themeColors.background,
        icon: AppIcons.moreVert,
        itemBuilder: (context) => contextMenuItems(context),
      ),
    );
  }

  List<PopupMenuItem> contextMenuItems(BuildContext context) {
    PopupMenuItem changeFontSizeItem = PopupMenuItem(
      value: null,
      onTap: null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppIcons.letterSize,
          SizedBox(width: context.width * .04),
          Text(AppStrings.of(context).fontSize),
          SizedBox(
            width: context.width * .30,
            child: BlocBuilder<QuranCubit, QuranState>(
              builder: (context, state) {
                return Slider(
                  max: (AppSizes.maxQuranFontSize),
                  min: (AppSizes.minQuranFontSize),
                  activeColor: context.themeColors.primary,
                  thumbColor: context.themeColors.background,
                  divisions: 5,
                  value: context.read<QuranCubit>().state.quranFontSize,
                  onChanged: (val) => context.read<QuranCubit>().updateQuranFontSize(val),
                );
              },
            ),
          )
        ],
      ),
    );
    PopupMenuItem changeFontTypeItem = PopupMenuItem(
      value: null,
      onTap: null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppIcons.letter,
          SizedBox(width: context.width * .04),
          Text(AppStrings.of(context).FontType),
          //TODO
          // DropdownButton<String>(
          //   onChanged: (val) => _settingsCtr.changeQuranFont(val!, setState: quranPageSetState),
          //   value: _settingsCtr.defaultFontQuran.value,
          //   items: MyFonts.values
          //       .map(
          //         (e) => DropdownMenuItem<String>(
          //           value: e.name,
          //           child: Text(
          //             e.arabicName.toString().tr,
          //             style: TextStyle(
          //               fontFamily: AppSettings.isArabicLang ? e.name : FontStyle.normal.toString(),
          //               color: _settingsCtr.defaultFontQuran.value == e.name ? MyColors.primary : MyColors.whiteBlack,
          //             ),
          //           ),
          //         ),
          //       )
          //       .toList(),
          // )
        ],
      ),
    );
    PopupMenuItem addBookMarkItem = PopupMenuItem(
      value: null,
      onTap: () => context.read<QuranCubit>().showAddQuranPageMarkDialog(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppIcons.addBookMark,
          SizedBox(width: context.width * .04),
          Text(AppStrings.of(context).addBookMark),
        ],
      ),
    );
    PopupMenuItem changeThemeItem = PopupMenuItem(
      value: null,
      onTap: () => context.read<ThemeCubit>().triggerTheme(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppIcons.animatedLightDark(context),
          SizedBox(width: context.width * .04),
          Text(AppStrings.of(context).changeTheme),
        ],
      ),
    );
    PopupMenuItem tefsirPageItem = PopupMenuItem(
      value: null,
      onTap: () {}, //NavigatorHelper.pushNamed(AppRoutes.tafseer),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppIcons.tafseer,
          SizedBox(width: context.width * .04),
          Text(AppStrings.of(context).tafsirs),
        ],
      ),
    );
    List<PopupMenuItem> itemsList = [
      addBookMarkItem,
      changeThemeItem,
      tefsirPageItem,
    ];
    if (!context.read<QuranCubit>().state.quranViewModeInImages) {
      itemsList.add(changeFontTypeItem);
      itemsList.add(changeFontSizeItem);
    }

    return itemsList;
  }
}
