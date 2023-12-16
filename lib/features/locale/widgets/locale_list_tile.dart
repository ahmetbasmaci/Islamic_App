import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/locale_cubit.dart';

import '../../../config/local/l10n.dart';
import '../../../core/utils/resources/app_icons.dart';

class LocaleListTile extends StatelessWidget {
  const LocaleListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        return ListTile(
          title: Text(AppStrings.of(context).language),
          subtitle: Text(AppStrings.of(context).changeLanguage),
          leading: AppIcons.language,
          trailing: DropdownButton<String>(
            value: state.locale,
            onChanged: (String? newValue) {
              context.read<LocaleCubit>().changeLocale(newValue!);
            },
            items: AppStrings.delegate.supportedLocales.map<DropdownMenuItem<String>>(
              (Locale value) {
                return DropdownMenuItem<String>(
                  value: value.languageCode,
                  child: Text(value.languageCode),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
