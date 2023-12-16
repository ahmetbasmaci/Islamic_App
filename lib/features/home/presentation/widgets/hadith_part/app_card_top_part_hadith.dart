import 'package:flutter/material.dart';
import '../../../../../core/utils/resources/app_styles.dart';
import '../../../../../core/widget/app_card_widgets/app_card_top_part.dart';
import '../referesh_btn_rounded.dart';

class AppCardTopPartHadith extends StatelessWidget {
  const AppCardTopPartHadith({super.key, required this.title, required this.onReferesh});
  final String title;
  final Function onReferesh;
  @override
  Widget build(BuildContext context) {
    return AppCardTopPart(
      startWidget: _refereshBtn(context),
      centerWidget: Text(
        title,
        style: AppStyles.title2(context),
      ),
    );
  }

  _refereshBtn(BuildContext context) {
    return RefereshBtnRounded(onPress: () async => onReferesh.call());
  }
}
