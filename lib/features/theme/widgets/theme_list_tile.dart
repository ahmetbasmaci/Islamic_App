import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/local/l10n.dart';
import '../../../config/theme/app_themes.dart';
import '../../../core/extentions/extentions.dart';
import '../cubit/theme_cubit.dart';

import '../../../core/utils/resources/app_icons.dart';

class ThemeListTile extends StatelessWidget {
  const ThemeListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return ListTile(
          title: Text(AppStrings.of(context).theme),
          subtitle: Text(AppStrings.of(context).changeTheme),
          leading: AppIcons.animatedLightDark(context),
          trailing: DropdownButton<Brightness>(
            value: state.theme.brightness,
            onChanged: (Brightness? newValue) {
              context.read<ThemeCubit>().updateTheme(newValue!);
            },
            items: AppThemes.themes.map<DropdownMenuItem<Brightness>>(
              (ThemeData value) {
                return DropdownMenuItem<Brightness>(
                  value: value.brightness,
                  child: Text(
                    value.brightness == Brightness.dark ? AppStrings.of(context).light : AppStrings.of(context).dark,
                  ),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
