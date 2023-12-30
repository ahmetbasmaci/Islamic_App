import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/local/l10n.dart';
import '../../../../../core/utils/resources/resources.dart';
import '../../../../../core/widget/app_card_widgets/app_card_with_title.dart';
import '../../../../../core/widget/app_card_widgets/app_card_center_part_widget.dart';
import '../../../../../core/widget/app_card_widgets/app_card_content.dart';
import '../../../../../core/widget/app_card_widgets/app_card_content_footer_part_buttons.dart';
import '../../../../../core/widget/space/space.dart';
import '../../../../../src/injection_container.dart';
import '../../../home.dart';

class AppCardContentQuran extends StatelessWidget {
  const AppCardContentQuran({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCardWithTitle(
      outsideTitle: AppStrings.of(context).quranBigTitle,
      child: BlocProvider(
        create: (context) => sl<HomeQuranCardCubit>()..getRandomAyah(),
        child: BlocBuilder<HomeQuranCardCubit, HomeQuranCardState>(
          builder: (context, state) {
            return AppCardContent(
              topPartWidget: _toppartWidget(context, state is HomeQuranCardLoadingState),
              centerPartWidget: _centerPartWidget(context, state),
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

  Widget _centerPartWidget(BuildContext context, HomeQuranCardState state) {
    return Column(
      children: <Widget>[
        AppCardCenterPartWidget(
          content: state is HomeQuranCardLoadedState ? state.quranCardModel.content : '',
          isLoading: state is HomeQuranCardLoadingState,
        ),
        state is HomeQuranCardLoadedState ? _ayahProps(context, state.quranCardModel) : Container(),
      ],
    );
  }

  Widget _ayahProps(BuildContext context, QuranCardModel quranCardModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Divider(
          height: 50,
          indent: 50,
          endIndent: 50,
        ),
        _ayahPropItem(context, AppStrings.of(context).surahName, quranCardModel.surahName),
        _ayahPropItem(context, AppStrings.of(context).ayahNumber, quranCardModel.ayahNumber.toString()),
        _ayahPropItem(context, AppStrings.of(context).juz, quranCardModel.juz.toString()),
      ],
    );
  }

  Widget _ayahPropItem(BuildContext context, String title, String value) {
    return Wrap(
      children: <Widget>[
        Text(title, style: AppStyles.title2(context)),
        const HorizontalSpace(20),
        Text(value),
        //
      ],
    );
  }

  AppCardContentFooterPartButtons _footerPartWidget(HomeQuranCardState state) {
    return AppCardContentFooterPartButtons(
      content: state is HomeQuranCardLoadedState ? state.quranCardModel.content : '',
      isFavorite: false,
    );
  }
}
