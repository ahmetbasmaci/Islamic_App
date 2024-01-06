import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';

import '../../../../../core/helpers/dialogs_helper.dart';
import '../../../quran.dart';

class QuranFooterButtonsPart extends StatelessWidget {
  const QuranFooterButtonsPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _button(
          icon: AppIcons.settings,
          onPressed: () async => showResitationSettingsDialog(context),
        ),
        _button(icon: AppIcons.animatedPlayPause(context), onPressed: () {} //TODO=> _quranCtr.playPauseBtnPress(),
            ),
        _button(icon: AppIcons.stop, onPressed: () {} //TODO=> _quranCtr.stopAudio(),
            ),
        _button(
          toolTipMessage: 'التنقل بين القران والتفسير',
          icon: AppIcons.animatedQuranTafseerView(context.read<QuranCubit>().state.showTafseerPage),
          onPressed: () async {
            //TODO
            // List<SurahTafseer> allTafseer = Get.find<TafseersCtr>().allTafseer;
            // if (allTafseer.isEmpty) {
            //   Get.to(() => TafseersPage(),
            //       transition: Transition.cupertinoDialog, duration: const Duration(milliseconds: 200));
            //   return;
            // }
            // _quranCtr.changeShowQuranStyle();
          },
        ),
      ],
    );
  }

  Widget _button({required Widget icon, required Function() onPressed, String? toolTipMessage}) {
    return Tooltip(
      message: toolTipMessage ?? '',
      child: IconButton(
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }

  void showResitationSettingsDialog(BuildContext context) {
    DialogsHelper.showCostumDialog(
      context: context,
      title: Text('اعدادات القراءة', style: AppStyles.contentBold),
      child: const QuranFooterResitationSettingsBody(),
    );
  }
}
