import 'package:flutter/material.dart';
import '../../../../config/local/l10n.dart';
import '../widgets/settings_divider.dart';
import '../../../theme/widgets/theme_list_tile.dart';

import '../../../../core/widget/app_appbar.dart';
import '../../../locale/widgets/locale_list_tile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: AppStrings.of(context).settings, showDrawerBtn: false),
      body: const Padding(
        padding: EdgeInsets.only(top: 30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ThemeListTile(),
              SettingsDivider(),
              LocaleListTile(),
              SettingsDivider(),
            ],
          ),
        ),
      ),
    );
  }
}
