import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:zad_almumin/config/local/l10n.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import 'package:zad_almumin/core/helpers/dialogs/dialogs_helper.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';
import '../../../quran.dart';

class QuranPageBodyTexts extends StatelessWidget {
  QuranPageBodyTexts({super.key, this.page = 0});
  final int page;
  late QuranCubit quranCubit;
  @override
  Widget build(BuildContext context) {
    quranCubit = context.read<QuranCubit>();
    return Container(
      padding: EdgeInsets.only(left: context.width * 0.04, right: context.width * 0.04, bottom: context.height * 0.01),
      constraints: BoxConstraints(minHeight: context.height),
      child: Column(
        children: [
          quranTextUpPart(context),
          Expanded(child: quranBodyPart(context, page)),
          quranTextFooterPart(context),
        ],
      ),
    );
  }

  Widget quranTextUpPart(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: context.width * 0.02),
        height: kToolbarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${AppStrings.of(context).juz}   ${quranCubit.state.selectedPageInfo.juz.arabicNumber}',
              style: AppStyles.contentBold,
            ),
            Text(
              quranCubit.state.selectedPageInfo.surahName,
              style: AppStyles.contentBold,
            ),
          ],
        ),
      ),
    );
  }

  Widget quranBodyPart(BuildContext context, int page) {
    List<Ayah> ayahs = quranCubit.getAyahsInPage(page);

    return quranCubit.state.showTafseerPage ? getQuranTafseePart(ayahs) : getQuranTextPart(context, ayahs);
  }

  Widget getQuranTafseePart(List<Ayah> ayahs) {
    return ScrollablePositionedList.builder(
      itemCount: ayahs.length,
      shrinkWrap: true,
      itemScrollController: quranCubit.itemScrollController,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        Ayah ayah = ayahs[index];
        return ayah.isBasmalah
            ? myRichText([basmalahPart(context, ayah)])
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  myRichText(
                    [
                      WidgetSpan(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding / 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSizes.cardRadius),
                            color: quranCubit.state.selectedAyah.number == ayah.number &&
                                    quranCubit.state.selectedAyah.surahNumber == ayah.surahNumber
                                ? context.themeColors.primary.withOpacity(0.5)
                                : ayah.isMarked
                                    ? context.theme.colorScheme.secondary.withOpacity(0.2)
                                    : Colors.transparent,
                          ),
                          child: myRichText([ayahPart(context, ayah)]),
                        ),
                      )
                    ],
                  ),
                  tafseerPart(ayah),
                ],
              );
      },
    );
  }

  Widget getQuranTextPart(BuildContext context, List<Ayah> ayahs) {
    return ListView(
      controller: quranCubit.scrollController,
      children: [
        myRichText(
          [
            ...ayahs.map((ayah) => ayah.isBasmalah ? basmalahPart(context, ayah) : ayahPart(context, ayah)),
          ],
        ),
      ],
    );
  }

  RichText myRichText(List<InlineSpan> textSpanChildredn) {
    return RichText(
      textAlign: TextAlign.justify,
      textDirection: TextDirection.rtl,
      text: TextSpan(
        children: textSpanChildredn,
        style: AppStyles.quran,
      ),
    );
  }

  WidgetSpan basmalahPart(BuildContext context, Ayah ayah) {
    return WidgetSpan(
      child: Column(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      AppImages.surahHeader,
                      height: quranCubit.state.quranFontSize * 1.2,
                      width: double.maxFinite,
                      fit: BoxFit.fill,
                      color: context.themeColors.primary.withOpacity(0.8),
                    ),
                    Center(
                      heightFactor: 1.5,
                      child: Text(
                        ayah.surahName,
                        textAlign: TextAlign.center,
                        //fontSize: quranCubit.state.quranFontSize.value * 1.05,
                        // fontWeight: FontWeight.bold,
                        // color: MyColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Image.asset(
            AppImages.bismillah,
            height: quranCubit.state.quranFontSize * 2,
            color: context.themeColors.onBackground,
          ),
        ],
      ),
    );
  }

  TextSpan ayahPart(BuildContext context, Ayah ayah) {
    return TextSpan(
      text: ayah.text,
      style: TextStyle(
        wordSpacing: -1,
        background: Paint()
          ..color = quranCubit.state.showTafseerPage
              ? Colors.transparent
              : quranCubit.state.selectedAyah.number == ayah.number &&
                      quranCubit.state.selectedAyah.surahNumber == ayah.surahNumber
                  ? context.themeColors.primary.withOpacity(0.2)
                  : ayah.isMarked
                      ? context.theme.colorScheme.secondary.withOpacity(0.2)
                      : Colors.transparent
          ..strokeJoin = StrokeJoin.round
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.fill,
      ),
      recognizer: LongPressGestureRecognizer()
        ..onLongPressStart = (details) => onAyahLongPressStart(context, details, ayah),
      children: [
        TextSpan(
          text: ' ${ayah.number.arabicNumber} ',
          style: TextStyle(
            wordSpacing: 0,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.uthmanic2.name,
            color: context.themeColors.primary,
          ),
        ),
        quranCubit.state.showTafseerPage
            ? WidgetSpan(
                child: Container(
                  color: Colors.red,
                  width: 1, //TODo
                  height: 1,
                  // child: MyTexts.quran(title: ""),
                ),
              )
            : const TextSpan(),
      ],
    );
  }

  Widget tafseerPart(Ayah ayah) {
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

  Widget quranTextFooterPart(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: context.height * 0.03,
        child: Center(
          child: Text(
            page.arabicNumber,
            // size: 16,
            // fontWeight: FontWeight.bold,
            // color: MyColors.quranPrimary,
          ),
        ),
      ),
    );
  }

  void onAyahLongPressStart(BuildContext context, LongPressStartDetails details, Ayah ayah) {
    quranCubit.updateSelectedAyah(ayah); //set selected ayah

    DialogsHelper.showSelectAyahBotToatsDialog(context: context, details: details, ayah: ayah);
  }
}
