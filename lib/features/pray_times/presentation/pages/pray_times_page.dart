import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/config/local/l10n.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/utils/resources/app_sizes.dart';
import 'package:zad_almumin/core/widget/space/vertical_space.dart';
import 'package:zad_almumin/features/pray_times/presentation/cubit/pray_times_cubit.dart';
import '../../../../core/widget/app_scaffold.dart';
import '../widgets/next_prev_days_arrows.dart';
import '../widgets/pray_time_left_card.dart';
import '../widgets/pray_time_update_button.dart';
import '../widgets/pray_times_info.dart';

class PrayTimesPage extends StatelessWidget {
  const PrayTimesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppStrings.of(context).prayTimes,
      body: SafeArea(
        child: BlocConsumer<PrayTimesCubit, PrayTimesState>(
          listener: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text(state.errorMessage),
              //     backgroundColor: context.theme.colorScheme.error,
              //   ),
              // );
            }
          },
          builder: (context, state) {
            return body(context, state);
          },
        ),
      ),
    );
  }

  Widget body(BuildContext context, PrayTimesState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        PrayTimeLeftCard(),
        const VerticalSpace(AppSizes.spaceBetweanParts),
        const NextPrevDaysArrows(),
        ListView(
          shrinkWrap: true,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          // mainAxisSize: MainAxisSize.max,
          children: [
            PrayTimesInfo(),
            const PrayTimeUpdateButton(),
          ],
        ),
      ],
    );
  }
}
