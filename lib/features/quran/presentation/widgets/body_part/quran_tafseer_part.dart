import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../quran.dart';

class QuranTafseerPart extends StatelessWidget {
  final List<Ayah> ayahs;
  const QuranTafseerPart({super.key, required this.ayahs});

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemCount: ayahs.length,
      shrinkWrap: true,
      itemScrollController: context.read<QuranCubit>().itemScrollController,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return _basmalahOrAyahOrTafseer(context, ayahs[index]);
      },
    );
  }

  Widget _basmalahOrAyahOrTafseer(BuildContext context, Ayah ayah) {
    late List<InlineSpan> childs;

    if (ayah.isBasmalah) {
      childs = [QuranBasmalahWidget(context: context, ayah: ayah)];
    } else {
      childs = [
        QuranAyahWidget(context: context, ayah: ayah),
        QuranTafseerWidget(context: context, ayah: ayah),
      ];
    }

    return QuranRichText(textSpanChilderen: childs);
  }

  Widget tafseerAyah(Ayah ayah) {
    return const Text('');
    /* List<SurahTafseer> allTafseer = Get.find<TafseersCtr>().allTafseer;
    String tafseerText = allTafseer
        .firstWhere((x) => x.surahNumber == ayah.surahNumber)
        .ayahsTafseer
        .firstWhere((x) => x.ayahNumber == ayah.ayahNumber)
        .tafseerText;
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MySiezes.blockRadius),
        color: MyColors.primary.withOpacity(.15),
      ),
      padding: EdgeInsets.all(MySiezes.screenPadding),
      margin: EdgeInsets.symmetric(vertical: MySiezes.screenPadding),
      child: MyTexts.quran(
        title: tafseerText,
        textAlign: TextAlign.justify,
        // textAlign: AppSettings.isArabicLang ? TextAlign.right : TextAlign.left,
        color: MyColors.whiteBlack,
        fontSize: _quranCtr.quranFontSize.value,
      ),
    );
  
  */
  }
}


/*
 Ayah ayah = ayahs[index];
        return ayah.isBasmalah
            ? _basmalahPart(context, ayah)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuranRichText(
                    textSpanChilderen: [
                      WidgetSpan(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding / 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSizes.cardRadius),
                            color: context.read<QuranCubit>().state.selectedAyah.number == ayah.number &&
                                    context.read<QuranCubit>().state.selectedAyah.surahNumber == ayah.surahNumber
                                ? context.themeColors.primary.withOpacity(0.5)
                                : ayah.isMarked
                                    ? context.theme.colorScheme.secondary.withOpacity(0.2)
                                    : Colors.transparent,
                          ),
                          child: QuranRichText(
                            textSpanChilderen: [
                              QuranAyahWidget(
                                context: context,
                                ayah: ayah,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  tafseerAyah(ayah),
                ],
              );

*/