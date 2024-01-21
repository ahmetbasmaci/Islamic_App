import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/features/tafseer/presentation/cubit/tafseer/tafseer_cubit.dart';
import '../../../../../core/utils/resources/app_constants.dart';
import '../../../../../core/utils/resources/resources.dart';
import '../../../quran.dart';

class QuranTafseerWidget extends WidgetSpan {
  final BuildContext context;
  final Ayah ayah;
  QuranTafseerWidget({required this.context, required this.ayah})
      : super(
          child: body(context, ayah),
        );

  static Widget body(BuildContext context, Ayah ayah) {
    String tafseerText = getTafseerText(context, ayah);
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        color: context.themeColors.primary.withOpacity(.15),
      ),
      padding: EdgeInsets.all(AppSizes.cardPadding),
      margin: EdgeInsets.symmetric(vertical: AppSizes.screenPadding),
      child: Text(
        tafseerText,
        textAlign: TextAlign.justify,
        style: AppStyles.quran,
      ),
    );
  }

  static String getTafseerText(BuildContext context, Ayah ayah) {
    var result = AppConstants.context.read<TafseerCubit>().state.tafseerDataModel;
    String tafseerText = result.surahs
        .firstWhere((x) => x.surahNumber == ayah.surahNumber)
        .ayahsTafseer
        .firstWhere((x) => x.ayahNumber == ayah.number)
        .tafseerText;

    return tafseerText;
  }
}
