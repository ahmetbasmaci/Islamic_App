import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        color: context.backgroundColor,
        icon: AppIcons.moreVert,
        itemBuilder: (context) => contextMenuItems(context),
      ),
    );
  }

  List<PopupMenuItem> contextMenuItems(BuildContext context) {
    List<PopupMenuItem> itemsList = [
      PopupMenuItem(
        value: null,
        onTap: null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppIcons.letterSize,
            SizedBox(width: context.width * .04),
            const Text("حجم الخط"),
            SizedBox(
              width: context.width * .30,
              child: Slider(
                max: (context.width * context.height * 0.00010),
                min: (context.width * context.height * 0.000040),
                activeColor: context.primaryColor,
                thumbColor: context.backgroundColor,
                value: context.read<QuranCubit>().state.quranFontSize,
                onChanged: (val) => context.read<QuranCubit>().updateQuranFontSize(val),
              ),
            )
          ],
        ),
      ),
      PopupMenuItem(
        value: null,
        onTap: null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppIcons.letter,
            SizedBox(width: context.width * .04),
            const Text("تعديل نوع الخط"),
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
      ),
      PopupMenuItem(
        value: null,
        onTap: () => context.read<QuranCubit>().showMarkDialog(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppIcons.addBookMark,
            SizedBox(width: context.width * .04),
            const Text('اضافة علامة'),
          ],
        ),
      ),
      PopupMenuItem(
        value: null,
        onTap: () => context.read<ThemeCubit>().triggerTheme(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppIcons.animatedLightDark(context),
            SizedBox(width: context.width * .04),
            const Text('تغير الثيم'),
          ],
        ),
      ),
      //TODO
      PopupMenuItem(
        value: null,
        onTap: () {}, //NavigatorHelper.pushNamed(AppRoutes.tafseer),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppIcons.tafseer,
            SizedBox(width: context.width * .04),
            const Text('التفاسير'),
          ],
        ),
      ),
    ];

    return itemsList;
  }
}
