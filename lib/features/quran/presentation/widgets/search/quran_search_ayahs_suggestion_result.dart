import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';
import 'package:zad_almumin/core/widget/space/space.dart';
import 'package:zad_almumin/features/quran/quran.dart';

import '../../../../../config/local/l10n.dart';
import '../../../../../core/helpers/navigator_helper.dart';

class QuranSearchAyahsSuggestionResult extends StatelessWidget {
  final String query;
  const QuranSearchAyahsSuggestionResult({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    if (query == '') return Container();
    return ayahsSuggestionResult(context);
  }

  Widget ayahsSuggestionResult(BuildContext context) {
    List<Ayah> ayahs = context.read<QuranSearchCubit>().searchAyahs(query);
    return Container(
      constraints: BoxConstraints(maxHeight: context.height * .6),
      child: Scrollbar(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: ayahs.length,
          itemBuilder: (context, index) => _resultItem(context, ayahs[index]),
        ),
      ),
    );
  }

  Widget _resultItem(BuildContext context, Ayah ayah) {
    return Container(
      margin: EdgeInsets.all(context.height * .02),
      padding: EdgeInsets.symmetric(vertical: context.height * .02),
      decoration: AppDecorations.quranTopCard(context),
      child: MaterialButton(
        onPressed: () {
          NavigatorHelper.pop();
          context.read<QuranCubit>().updateSelectedAyah(ayah);
          context.read<QuranCubit>().goToPage(ayah.page - 1);
        },
        child: _itemTitels(ayah, context),
      ),
    );
  }

  Column _itemTitels(Ayah ayah, BuildContext context) {
    return Column(
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            ayah.text,
            textAlign: TextAlign.justify,
            style: AppStyles.content.copyWith(
              fontFamily: AppFonts.uthmanic.name,
              fontSize: 25,
            ),
          ),
        ),
        VerticalSpace(AppSizes.spaceBetweanWidgets),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _titleRow(context, ayah.surahName.removeTashkilAndSpace, ayah.number.toString()),
            _titleRow(context, AppStrings.of(context).page, ayah.page.toString()),
          ],
        ),
      ],
    );
  }

  Row _titleRow(BuildContext context, String text1, String text2) {
    return Row(
      children: [
        Text(
          '$text1:',
          textAlign: TextAlign.right,
          style: AppStyles.quran.copyWith(color: context.themeColors.primary),
        ),
        SizedBox(width: context.width * .03),
        Text(
          text2,
          textAlign: TextAlign.right,
          style: AppStyles.quran.copyWith(),
        ),
      ],
    );
  }
}
