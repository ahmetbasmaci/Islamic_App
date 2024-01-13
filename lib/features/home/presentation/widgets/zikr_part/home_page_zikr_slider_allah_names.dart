import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/local/l10n.dart';
import '../../../../../src/injection_container.dart';
import '../../../../azkar/azkar.dart';
import '../../cubit/home_cubit.dart';
import 'home_page_zikr_slider_with_title.dart';

class HomePageZikrSliderAllahNames extends StatelessWidget {
  const HomePageZikrSliderAllahNames({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetItManager.instance.azkarCubit,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context2, state) {
          return HomePageZikrSliderWithTitle(
            title: AppStrings.of(context).zikrAllahNamesBigTitle,
            zikrCategoryModels: context2.read<AzkarCubit>().zikrCategoryModelsAllahNames,
          );
        },
      ),
    );
  }
}
