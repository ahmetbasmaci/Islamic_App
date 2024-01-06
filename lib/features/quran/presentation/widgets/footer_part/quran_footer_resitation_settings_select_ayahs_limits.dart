import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import 'package:zad_almumin/core/helpers/navigator_helper.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';
import 'package:zad_almumin/core/widget/space/vertical_space.dart';
import '../../../../../core/helpers/dialogs_helper.dart';
import '../../../quran.dart';

class QuranFooterResitationSettingsSelectAyahsLimits extends StatelessWidget {
  const QuranFooterResitationSettingsSelectAyahsLimits({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        return Column(
          children: [
            _titels(context),
            VerticalSpace(AppSizes.spaceBetweanParts),
            startEndAyahsSelections(
              context: context,
              title: 'من الآية',
              ayah: context.read<QuranCubit>().getResitationSettingsAyah(isStartAyah: true),
              isStartAyah: true,
            ),
            VerticalSpace(AppSizes.spaceBetweanParts),
            startEndAyahsSelections(
              context: context,
              title: 'الى الآية',
              ayah: context.read<QuranCubit>().getResitationSettingsAyah(isStartAyah: false),
              isStartAyah: false,
            ),
          ],
        );
      },
    );
  }

  Widget _titels(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('تحديد المقطع:', style: AppStyles.contentBold),
        Text(
          context
              .read<QuranCubit>()
              .getSurahByNumber(context.read<QuranCubit>().state.selectedPageInfo.surahNumber)
              .name,
          style: AppStyles.contentBold,
        ),
      ],
    );
  }

  Widget startEndAyahsSelections({
    required BuildContext context,
    required String title,
    required Ayah ayah,
    required bool isStartAyah,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('$title:', style: AppStyles.contentBold),
        InkWell(
          onTap: () => _selectAyahFromDialogClick(context, ayah.text, isStartAyah),
          child: Row(
            children: [
              Text('${ayah.number} - ', style: AppStyles.contentBold),
              SizedBox(
                width: context.width * .3,
                child: SingleChildScrollView(
                  padding: null,
                  scrollDirection: Axis.horizontal,
                  child: Text(ayah.text),
                ),
              ),
              // SingleChildScrollView(
              //           padding: null,
              //           scrollDirection: Axis.horizontal,
              //           child: Text(ayah.text, style: AppStyles.content.copyWith(overflow: TextOverflow.ellipsis)),
              //         ),
              AppIcons.downArrow,
            ],
          ),
        ),
      ],
    );
  }

  void _selectAyahFromDialogClick(BuildContext context, String ayahText, bool isStartAyah) {
    DialogsHelper.showCostumDialog(
      context: context,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('اختر الآية:  ', style: AppStyles.contentBold),
          Text(context.read<QuranCubit>().state.selectedPageInfo.surahName, style: AppStyles.contentBold),
        ],
      ),
      child: _selectAyahFromDialog(context, ayahText, isStartAyah),
    );
  }

  SingleChildScrollView _selectAyahFromDialog(BuildContext context, String ayahText, bool isStartAyah) {
    List<Ayah> ayahs = context.read<QuranCubit>().getAyahsDialogList(isStartAyah);

    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: ayahs
            .map(
              (ayah) => _ayahInDialogItem(
                context: context,
                ayah: ayah,
                isSelected: ayah.text == ayahText,
                isStartAyah: isStartAyah,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _ayahInDialogItem({
    required BuildContext context,
    required Ayah ayah,
    required bool isSelected,
    required bool isStartAyah,
  }) {
    return ListTile(
      leading: Text('${ayah.number} - ', style: AppStyles.contentBold),
      title: SingleChildScrollView(
        padding: null,
        scrollDirection: Axis.horizontal,
        child: Text(ayah.text),
      ),
      selected: isSelected,
      onTap: () {
        if (isStartAyah) {
          context.read<QuranCubit>().updateResitationSettingsStartAyah(ayah);
        } else {
          context.read<QuranCubit>().updateResitationSettingsEndAyah(ayah);
        }
        NavigatorHelper.pop();
      },
    );
  }
}
