import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zad_almumin/core/helpers/toats_helper.dart';
import 'package:zad_almumin/core/utils/resources/app_constants.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';
import 'package:zad_almumin/core/widget/app_scaffold.dart';
import 'package:zad_almumin/core/widget/space/space.dart';

import '../../../../config/local/l10n.dart';

class MemorizePage extends StatelessWidget {
  const MemorizePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppStrings.of(context).shayhIbrahimGroup,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            VerticalSpace(AppSizes.spaceBetweanParts),
            Text(AppStrings.of(context).shayhIbrahimTarjama, textAlign: TextAlign.center),
            VerticalSpace(AppSizes.spaceBetweanParts * 2),
            InkWell(
              onTap: () async {
                //how to open telegram link
                const url = AppConstants.shayhIbrahimTelegramLink;
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                } else {
                  ToatsHelper.showError(AppStrings.of(context).linkNotAvailable);
                }
              },
              child: Text(
                AppStrings.of(context).joinToShayhIbrahimTelegramGroup,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.blue),
              ),
            )
          ],
        ),
      ),
      usePadding: true,
    );
  }
}
