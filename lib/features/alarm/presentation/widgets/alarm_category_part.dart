import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/utils/enums/enums.dart';
import '../../../../core/extentions/extentions.dart';
import '../../../../core/utils/resources/resources.dart';
import '../../../../core/widget/space/space.dart';
import '../../../pray_times/data/models/time.dart';
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
          leading: Text(alarmPartModel.title, style: AppStyles.title2),
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
      leading: Image.asset(imagePath, width: AppSizes.imageAlarmTile),
      title: Text(alarmModel.title),
      trailing: _itemTrailing(alarmModel, context),
    );
  }

  Wrap _itemTrailing(AlarmModel alarmModel, BuildContext context) {
    return Wrap(
      children: [
        _alarmSettingsButton(context, alarmModel),
        _swichButton(alarmModel, context),
      ],
    );
  }

  Switch _swichButton(AlarmModel alarmModel, BuildContext context) {
    return Switch(
      value: alarmModel.isActive,
      onChanged: (val) {
        context.read<AlarmCubit>().triggerAlarmActivation(alarmModel);
      },
    );
  }

  Widget _alarmSettingsButton(BuildContext context, AlarmModel alarmModel) {
    if (alarmModel is PeriodicAlarmModel) {
      if (alarmModel.alarmType.isAdhanType) return const SizedBox(width: 0, height: 0);
      return _updateAlarmTime(alarmModel, context);
    } else {
      return _updateAlarmRepeated(context, alarmModel as RepeatedAlarmModel);
    }
  }

  IconButton _updateAlarmTime(PeriodicAlarmModel alarmModel, BuildContext context) {
    return IconButton(
      icon: alarmModel.isActive ? AppIcons.alarmOn : AppIcons.alarmOff,
      onPressed: () async {
        TimeOfDay? newTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(hour: alarmModel.time.hour, minute: alarmModel.time.minute),
          builder: (BuildContext context, Widget? child) => child!,
        );
        if (newTime == null) return;
        context.read<AlarmCubit>().updateAlarmTime(
              alarmModel,
              Time(hour: newTime.hour, minute: newTime.minute),
            );
        // onChanged(true);
      },
    );
  }

  Widget _updateAlarmRepeated(BuildContext context, RepeatedAlarmModel alarmModel) {
    return PopupMenuButton<RepeatAlarmType>(
      // color: MyColors.background,
      icon: AppIcons.moreVert,
      onSelected: (value) {
        context.read<AlarmCubit>().updateAlarmRepeated(alarmModel, value);
      },
      itemBuilder: (context) {
        return [
          ...RepeatAlarmType.values.map(
            (e) {
              bool isSelected = alarmModel.repeatAlarmType == e;
              return PopupMenuItem(
                value: e,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        iconColor: isSelected ? context.themeColors.primary : null,
                      ),
                      onPressed: null,
                      child: AppIcons.leftArrow,
                    ),
                    Text(
                      e.translatedName,
                      style: AppStyles.title2.copyWith(
                        color: isSelected ? context.themeColors.primary : null,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ];
      },
    );
  }
}
