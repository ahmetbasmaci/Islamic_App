import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import '../../../../../core/utils/resources/resources.dart';
import '../../../quran.dart';

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
            Text('تكرار التلاوة:  ', style: AppStyles.contentBold),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                AnimatedOpacity(
                  opacity: context.read<QuranCubit>().state.resitationSettings.isUnlimitRepeatAll
                      ? 0.5
                      : 1,
                  duration: const Duration(milliseconds: 200),
                  child: Row(
                    children: <Widget>[
                      const Text('المقطع :  '),
                      Text(
                          context
                              .read<QuranCubit>()
                              .state
                              .resitationSettings
                              .repeetAllCount
                              .toString(),
                          style: AppStyles.contentBold),
                      IconButton(
                        onPressed:
                            context.read<QuranCubit>().state.resitationSettings.isUnlimitRepeatAll
                                ? null
                                : null, //TODO () => context.read<QuranCubit>().state.selectedPageInfo.repeetAllCount++,
                        icon: AppIcons.plus,
                      ),
                      IconButton(
                        onPressed:
                            context.read<QuranCubit>().state.resitationSettings.isUnlimitRepeatAll
                                ? null
                                : () {
                                    //TODO
                                    // if (context.read<QuranCubit>().state.selectedPageInfo.repeetAllCount != 1)
                                    //   context.read<QuranCubit>().state.selectedPageInfo.repeetAllCount--;
                                  },
                        icon: AppIcons.minus,
                      ),
                    ],
                  ),
                ),
                Checkbox(
                  fillColor: MaterialStateProperty.all<Color>(context.themeColors.background),
                  checkColor: context.themeColors.primary,
                  overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(.1)),
                  value: context.read<QuranCubit>().state.resitationSettings.isUnlimitRepeatAll,
                  onChanged:
                      (value) {}, //TODO context.read<QuranCubit>().state.selectedPageInfo.isUnlimitRepeatAll = value ?? false,
                ),
                const Text('لا محدود'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                AnimatedOpacity(
                  opacity: context.read<QuranCubit>().state.resitationSettings.isUnlimitRepeatAyah
                      ? 0.5
                      : 1,
                  duration: const Duration(milliseconds: 200),
                  child: Row(
                    children: <Widget>[
                      const Text('الآية   :  '),
                      Text(
                        context
                            .read<QuranCubit>()
                            .state
                            .resitationSettings
                            .repeetAyahCount
                            .toString(),
                        style: AppStyles.contentBold,
                      ),
                      IconButton(
                        onPressed: context
                                .read<QuranCubit>()
                                .state
                                .resitationSettings
                                .isUnlimitRepeatAyah
                            ? null
                            : null, //TODO () => context.read<QuranCubit>().state.selectedPageInfo.repeetAyahCount++,
                        icon: AppIcons.plus,
                      ),
                      IconButton(
                        onPressed:
                            context.read<QuranCubit>().state.resitationSettings.isUnlimitRepeatAyah
                                ? null
                                : () {
                                    //TODO
                                    // if (context.read<QuranCubit>().state.selectedPageInfo.repeetAyahCount != 1)
                                    //   context.read<QuranCubit>().state.selectedPageInfo.repeetAyahCount--;
                                  },
                        icon: AppIcons.minus,
                      ),
                    ],
                  ),
                ),
                Checkbox(
                  fillColor: MaterialStateProperty.all<Color>(context.themeColors.background),
                  checkColor: context.themeColors.primary,
                  overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(.1)),
                  value: context.read<QuranCubit>().state.resitationSettings.isUnlimitRepeatAyah,
                  onChanged:
                      (value) {}, //TODO=> context.read<QuranCubit>().state.selectedPageInfo.isUnlimitRepeatAyah = value ?? false,
                ),
                const Text('لا محدود'),
              ],
            )
          ],
        );
      },
    );
  }
}
