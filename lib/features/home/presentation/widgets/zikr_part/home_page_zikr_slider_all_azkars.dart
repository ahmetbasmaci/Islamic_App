import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/local/l10n.dart';
import '../../../../../src/injection_container.dart';
import '../../../../azkar/azkar.dart';
import 'home_page_zikr_slider_with_title.dart';

class HomePageZikrSliderAllAzkars extends StatelessWidget {
  const HomePageZikrSliderAllAzkars({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AzkarCubit>(),
      child: BlocBuilder<AzkarCubit, AzkarState>(
        builder: (context2, state) {
          return HomePageZikrSliderWithTitle(
            title: AppStrings.of(context).zikrAllAzkarsBigTitle,
            zikrCategoryModels: context2.read<AzkarCubit>().zikrCategoryModelsAllAzkars,
          );
        },
      ),
    );
  }
}
