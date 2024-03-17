import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      usePadding: false,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocBuilder<AlarmCubit, AlarmState>(
          builder: (context, state) {
            return Column(
              children: [
                AlarmCategoryPart(
                  alarmPartModel: context.read<AlarmCubit>().getAlarmPart(AlarmPart.dua),
                ),
                AlarmCategoryPart(
                  alarmPartModel: context.read<AlarmCubit>().getAlarmPart(AlarmPart.hadith),
                ),
                AlarmCategoryPart(
                  alarmPartModel: context.read<AlarmCubit>().getAlarmPart(AlarmPart.dailyAzkar),
                ),
                AlarmCategoryPart(
                  alarmPartModel: context.read<AlarmCubit>().getAlarmPart(AlarmPart.quran),
                ),
                AlarmCategoryPart(
                  alarmPartModel: context.read<AlarmCubit>().getAlarmPart(AlarmPart.fast),
                ),
                AlarmCategoryPart(
                  alarmPartModel: context.read<AlarmCubit>().getAlarmPart(AlarmPart.pray),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
