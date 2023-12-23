import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/toats_helper.dart';
import '../../../../../core/widget/app_card_widgets/app_card_center_part_widget.dart';
import '../../../../../core/widget/app_card_widgets/app_card_content.dart';
import '../../../../../core/widget/app_card_widgets/app_card_with_title.dart';
import '../../../../../core/utils/resources/app_styles.dart';
import '../../../data/models/hadith_card_model.dart';
import '../../../../../config/local/l10n.dart';
import '../../../../../core/widget/app_card_widgets/app_card_content_footer_part_buttons.dart';
import '../../../../../core/widget/space/horizontal_space.dart';
import '../../cubit/cubit_hadith/home_hadith_card_cubit.dart';
import 'app_card_top_part_hadith.dart';
import '../../../../../src/injection_container.dart' as di;

class AppCardContentHadith extends StatelessWidget {
  const AppCardContentHadith({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCardWithTitle(
      outsideTitle: AppStrings.of(context).hadithBigTitle,
      child: BlocProvider(
        create: (context) => di.sl<HomeHadithCardCubit>()..getRandomHadith(),
        child: BlocConsumer<HomeHadithCardCubit, HomeHadithCardState>(
          listener: (context, state) {
            if (state is HomeHadithCardFieldState) ToatsHelper.showError(state.message);
          },
          builder: (context, state) {
            return AppCardContent(
              topPartWidget: _toppartWidget(context),
              centerPartWidget: _centerPartWidget(context, state),
              footerPartWidget: _footerPartWidget(state),
            );
          },
        ),
      ),
    );
  }

  AppCardTopPartHadith _toppartWidget(BuildContext context) {
    return AppCardTopPartHadith(
      title: AppStrings.of(context).hadithTitle,
      onReferesh: () {
        context.read<HomeHadithCardCubit>().getRandomHadith();
      },
    );
  }

  Widget _centerPartWidget(BuildContext context, HomeHadithCardState state) {
    return Column(
      children: <Widget>[
        AppCardCenterPartWidget(
          content: state is HomeHadithCardLoadedState
              ? '${state.hadithCardModel.hadithSanad}\n${state.hadithCardModel.hadithText}'
              : '',
          isLoading: state is HomeHadithCardLoadingState,
        ),
        state is HomeHadithCardLoadedState ? _hadithProps(context, state.hadithCardModel) : Container(),
      ],
    );
  }

  Widget _hadithProps(BuildContext context, HadithCardModel hadithCardModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Divider(
          height: 50,
          indent: 50,
          endIndent: 50,
        ),
        _hadothPropItem(context, AppStrings.of(context).hadithBookName, hadithCardModel.hadithBookName),
        _hadothPropItem(context, AppStrings.of(context).categoryBookname, hadithCardModel.categoryBookname),
        _hadothPropItem(context, AppStrings.of(context).chapterName, hadithCardModel.chapterName),
        _hadothPropItem(context, AppStrings.of(context).hadithId, hadithCardModel.hadithId.toString()),
      ],
    );
  }

  Widget _hadothPropItem(BuildContext context, String title, String value) {
    return Wrap(
      children: <Widget>[
        Text(title, style: AppStyles.title2(context)),
        const HorizontalSpace(20),
        Text(value),
      ],
    );
  }

  AppCardContentFooterPartButtons _footerPartWidget(HomeHadithCardState state) {
    return AppCardContentFooterPartButtons(
      content: state is HomeHadithCardLoadedState ? state.hadithCardModel.hadithText : '',
      isFavorite: false,
    );
  }
}
