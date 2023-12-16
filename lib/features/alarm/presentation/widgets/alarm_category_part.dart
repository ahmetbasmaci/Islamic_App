import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/extentions/extentions.dart';
import '../../../../core/utils/resources/resources.dart';
import '../../../../core/widget/space/space.dart';
import '../cubit/alarm_cubit.dart';

import '../../data/models/alarm_model.dart';
import '../../data/models/alarm_part_model.dart';

class AlarmCategoryPart extends StatelessWidget {
  const AlarmCategoryPart({super.key, required this.alarmPartModel});
  final AlarmPartModel alarmPartModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Text(alarmPartModel.title, style: AppStyles.title2(context)),
        ),
        Card(
          child: Column(
            children: [
              ...alarmPartModel.alarmModels.map(
                (alarmModel) => _alarmItem(
                  context,
                  alarmPartModel.imagePath,
                  alarmModel,
                ),
              ),
            ],
          ),
        ),
        VerticalSpace(AppSizes.spaceBetweanParts),
      ],
    );
  }

  ListTile _alarmItem(BuildContext context, String imagePath, AlarmModel alarmModel) {
    return ListTile(
      leading: Image.asset(
        imagePath,
        width: AppSizes.imageAlarmTile,
        height: AppSizes.imageAlarmTile,
      ),
      title: Text(alarmModel.title),
      trailing: Wrap(
        children: [
          alarmModel.isPeriodicAlarm
              ? IconButton(
                  onPressed: () {},
                  icon: alarmModel.isActive ? AppIcons.alarmOn : AppIcons.alarmOff,
                )
              : IconButton(
                  onPressed: () {},
                  icon: AppIcons.morevert,
                ),
          Switch(
            value: alarmModel.isActive,
            onChanged: (val) {
              context.read<AlarmCubit>().triggerAlarmActive(alarmModel);
            },
          ),
        ],
      ),
    );
  }
}
