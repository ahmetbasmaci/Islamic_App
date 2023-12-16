import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/local/l10n.dart';
import '../../../../../core/widget/app_card_widgets/app_card_with_title.dart';
import '../../../../../core/widget/app_card_widgets/app_card_center_part_widget.dart';
import '../../../../../core/widget/app_card_widgets/app_card_content.dart';
import '../../../../../core/widget/app_card_widgets/app_card_content_footer_part_buttons.dart';
import '../../cubit/cubit_quran/home_quran_card_cubit.dart';
import 'app_card_top_part_quran.dart';

class AppCardContentQuran extends StatelessWidget {
  const AppCardContentQuran({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCardWithTitle(
      outsideTitle: AppStrings.of(context).quranBigTitle,
      child: BlocProvider(
        create: (context) => HomeQuranCardCubit()..getRandomAyah(),
        child: BlocBuilder<HomeQuranCardCubit, HomeQuranCardState>(
          builder: (context, state) {
            return AppCardContent(
              topPartWidget: _toppartWidget(context, state is HomeQuranCardLoadingState),
              centerPartWidget: _centerPartWidget(state),
              footerPartWidget: _footerPartWidget(state),
            );
          },
        ),
      ),
    );
  }

  AppCardTopPartQuran _toppartWidget(BuildContext context, bool isLoading) {
    return AppCardTopPartQuran(
      title: AppStrings.of(context).quranTitle,
      onReferesh: isLoading
          ? () {}
          : () {
              context.read<HomeQuranCardCubit>().getRandomAyah();
            },
    );
  }

  StatelessWidget _centerPartWidget(HomeQuranCardState state) {
    return AppCardCenterPartWidget(
      content: state is HomeQuranCardLoadedState ? state.quranCardModel.content : '',
      isLoading: state is HomeQuranCardLoadingState,
    );
  }

  AppCardContentFooterPartButtons _footerPartWidget(HomeQuranCardState state) {
    return AppCardContentFooterPartButtons(
      content: state is HomeQuranCardLoadedState ? state.quranCardModel.content : '',
      isFavorite: false,
    );
  }
}
