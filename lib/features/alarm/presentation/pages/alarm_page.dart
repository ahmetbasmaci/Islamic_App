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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: BlocBuilder<AlarmCubit, AlarmState>(
          builder: (context, state) {
            return Column(
              children: [
                AlarmCategoryPart(
                  alarmPartModel: context.read<AlarmCubit>().getAlarmPart(ALarmType.dua),
                ),
                AlarmCategoryPart(
                  alarmPartModel: context.read<AlarmCubit>().getAlarmPart(ALarmType.hadith),
                ),
                AlarmCategoryPart(
                  alarmPartModel: context.read<AlarmCubit>().getAlarmPart(ALarmType.dailyAzkar),
                ),
                AlarmCategoryPart(
                  alarmPartModel: context.read<AlarmCubit>().getAlarmPart(ALarmType.quran),
                ),
                AlarmCategoryPart(
                  alarmPartModel: context.read<AlarmCubit>().getAlarmPart(ALarmType.fast),
                ),
                AlarmCategoryPart(
                  alarmPartModel: context.read<AlarmCubit>().getAlarmPart(ALarmType.pray),
                ),
                // alarmBlockTitle(title: 'تذكير بالدعاء'.tr),
                // duaAlarms(),
                // alarmBlockTitle(title: 'تذكير الاحاديث'.tr),
                // hadithsAlarms(),
                // alarmBlockTitle(title: 'الأذكار اليومية'.tr),
                // azkarAlamrs(),
                // alarmBlockTitle(title: 'قراءة القرآن'.tr),
                // quranAlarms(),
                // alarmBlockTitle(title: 'اوقات الصيام'.tr),
                // fastAlarms(),
                // alarmBlockTitle(title: 'اوقات الاذان'.tr),
                // prayTimesAlarms(),
              ],
            );
          },
        ),
      ),
    );
  }
}
