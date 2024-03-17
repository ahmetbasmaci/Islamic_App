import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import '../../../../../../core/utils/resources/resources.dart';
import '../../../../quran.dart';

class QuranFooterResitationSettingsSelectRepeat extends StatelessWidget {
  const QuranFooterResitationSettingsSelectRepeat({super.key});

  @override
  Widget build(BuildContext context) {
    return selectRepeet(context);
  }

  Widget selectRepeet(BuildContext context) {
    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            _repeatingWidgt(context: context, isRepeatingPart: true),
            _repeatingWidgt(context: context, isRepeatingPart: false),
          ],
        );
      },
    );
  }

  Text _header() => Text('تكرار التلاوة:  ', style: AppStyles.contentBold);

  Widget _repeatingWidgt({
    required BuildContext context,
    required bool isRepeatingPart,
  }) {
    var quranCubit = context.read<QuranCubit>();

    double opacity = isRepeatingPart
        ? quranCubit.state.resitationSettings.isUnlimitRepeatAll
            ? 0.5
            : 1
        : quranCubit.state.resitationSettings.isUnlimitRepeatAyah
            ? 0.5
            : 1;
    String title = isRepeatingPart ? 'المقطع :  ' : 'الآية   :  ';

    String repeatCount = isRepeatingPart
        ? quranCubit.state.resitationSettings.isUnlimitRepeatAll
            ? '∞'
            : quranCubit.state.resitationSettings.repeetAllCount.toString()
        : quranCubit.state.resitationSettings.isUnlimitRepeatAyah
            ? '∞'
            : quranCubit.state.resitationSettings.repeetAyahCount.toString();

    bool unlimitRepeatall = isRepeatingPart
        ? quranCubit.state.resitationSettings.isUnlimitRepeatAll
        : quranCubit.state.resitationSettings.isUnlimitRepeatAyah;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(title),
        _incresDecreasebuttons(opacity, repeatCount, unlimitRepeatall, isRepeatingPart, quranCubit),
        _checkBoxUnlimitRepeat(context, unlimitRepeatall, isRepeatingPart, quranCubit),
        const Text('لا محدود'),
      ],
    );
  }

  AnimatedOpacity _incresDecreasebuttons(
      double opacity, String repeatCount, bool unlimitRepeatall, bool isRepeatingPart, QuranCubit quranCubit) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 200),
      child: Row(
        children: <Widget>[
          Text(repeatCount, style: AppStyles.contentBold),
          _brnIncreaseLimit(unlimitRepeatall, isRepeatingPart, quranCubit),
          _btnDecreaseLimit(unlimitRepeatall, isRepeatingPart, quranCubit),
        ],
      ),
    );
  }

  IconButton _brnIncreaseLimit(bool unlimitRepeatall, bool isRepeatingPart, QuranCubit quranCubit) {
    return IconButton(
        icon: AppIcons.plus,
        onPressed: unlimitRepeatall
            ? null
            : () {
                if (isRepeatingPart) {
                  quranCubit.updateResitationSettingsInecreaseRepeatAllCount();
                } else {
                  quranCubit.updateResitationSettingsInecreaseRepeatAyahCount();
                }
              });
  }

  IconButton _btnDecreaseLimit(bool unlimitRepeatall, bool isRepeatingPart, QuranCubit quranCubit) {
    return IconButton(
      icon: AppIcons.minus,
      onPressed: unlimitRepeatall
          ? null
          : () {
              if (isRepeatingPart) {
                if (quranCubit.state.resitationSettings.repeetAllCount != 1)
                  quranCubit.updateResitationSettingsDecreaseRepeatAllCount();
              } else {
                if (quranCubit.state.resitationSettings.repeetAyahCount != 1)
                  quranCubit.updateResitationSettingsDecreaseRepeatAyahCount();
              }
            },
    );
  }

  Checkbox _checkBoxUnlimitRepeat(
      BuildContext context, bool unlimitRepeatall, bool isRepeatingPart, QuranCubit quranCubit) {
    return Checkbox(
      fillColor: MaterialStateProperty.all<Color>(context.themeColors.background),
      checkColor: context.themeColors.primary,
      overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(.1)),
      value: unlimitRepeatall,
      onChanged: (value) {
        if (isRepeatingPart) {
          quranCubit.updateResitationSettingsUnlimitedRepeatAll(value ?? false);
        } else {
          quranCubit.updateResitationSettingsUnlimitedRepeatAyah(value ?? false);
        }
      },
    );
  }
}
