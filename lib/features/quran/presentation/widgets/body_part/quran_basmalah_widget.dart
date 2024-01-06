import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';

import '../../../../../core/utils/resources/resources.dart';
import '../../../quran.dart';

class QuranBasmalahWidget extends WidgetSpan {
  final Ayah ayah;
  final BuildContext context;
  QuranBasmalahWidget({
    required this.context,
    required this.ayah,
  }) : super(
          child: _childBody(context, ayah),
        );

  static Widget _childBody(BuildContext context, Ayah ayah) {
    return Column(
      children: [
        _surahHeaderImage(context, ayah),
        _basmalahImage(context),
      ],
    );
  }

  static Stack _surahHeaderImage(BuildContext context, Ayah ayah) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          AppImages.surahHeader,
          height: context.read<QuranCubit>().state.quranFontSize * 1.2,
          width: double.maxFinite,
          fit: BoxFit.fill,
          color: context.themeColors.primary.withOpacity(0.8),
        ),
        Center(
          heightFactor: 1.5,
          child: Text(
            ayah.surahName.removeSurahString,
            style: AppStyles.quran.copyWith(
              fontWeight: FontWeight.bold,
            ),
            // color: MyColors.primary,
          ),
        ),
      ],
    );
  }

  static Image _basmalahImage(BuildContext context) {
    return Image.asset(
      AppImages.bismillah,
      height: context.read<QuranCubit>().state.quranFontSize * 2,
      color: context.themeColors.onBackground,
    );
  }
}
