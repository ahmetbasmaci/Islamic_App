import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/helpers/toats_helper.dart';
import '../../../../config/local/l10n.dart';
import '../../../../core/utils/enums/enums.dart';
import '../cubit/alarm_cubit.dart';

import '../../../../core/widget/app_scaffold.dart';
import '../widgets/alarm_category_part.dart';

class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppStrings.of(context).alarm,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: BlocConsumer<AlarmCubit, AlarmState>(
          listener: (context, state) {
            if (state is AlarmUpdatedState) {
              ToatsHelper.show(state.alarmModel.isActive
                  ? AppStrings.of(context).alarmActivated
                  : AppStrings.of(context).alarmDeactivated);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                AlarmCategoryPart(
                  alarmPartModel: context.read<AlarmCubit>().getAlarmPart(ALarmPart.dua),
                ),
                AlarmCategoryPart(
                  alarmPartModel: context.read<AlarmCubit>().getAlarmPart(ALarmPart.hadith),
                ),
                AlarmCategoryPart(
                  alarmPartModel: context.read<AlarmCubit>().getAlarmPart(ALarmPart.dailyAzkar),
                ),
                AlarmCategoryPart(
                  alarmPartModel: context.read<AlarmCubit>().getAlarmPart(ALarmPart.quran),
                ),
                AlarmCategoryPart(
                  alarmPartModel: context.read<AlarmCubit>().getAlarmPart(ALarmPart.fast),
                ),
                AlarmCategoryPart(
                  alarmPartModel: context.read<AlarmCubit>().getAlarmPart(ALarmPart.pray),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
