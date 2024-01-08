import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/utils/resources/app_constants.dart';
import 'package:zad_almumin/features/quran/presentation/cubit/quran/quran_cubit.dart';
import '../../extentions/extentions.dart';

class AppStyles {
  AppStyles._();
  static TextStyle get title {
    return AppConstants.context.theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w800,
        ) ??
        const TextStyle();
  }

  static TextStyle get title2 {
    return AppConstants.context.theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
        ) ??
        const TextStyle();
  }

  static TextStyle get content {
    return AppConstants.context.theme.textTheme.bodyMedium ?? const TextStyle();
  }

  static TextStyle get contentBold {
    return content.copyWith(
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle get quran {
    return content.copyWith(
      fontSize: AppConstants.context.read<QuranCubit>().state.quranFontSize,
    );
  }
}
