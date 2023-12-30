import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../extentions/extentions.dart';
import '../../utils/resources/app_styles.dart';
import '../../../config/local/l10n.dart';
import '../../../features/theme/cubit/theme_cubit.dart';
import '../../helpers/navigator_helper.dart';
import '../../utils/resources/app_icons.dart';

class AppDrawerHeader extends StatelessWidget {
  const AppDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: Text(
        AppStrings.of(context).programSections,
        style: AppStyles.title(context).copyWith(color: context.themeColors.background),
      ),
      accountEmail: Container(),
      otherAccountsPicturesSize: const Size.square(60),
      otherAccountsPictures: [_changeThemeIconButton(context)],
    );
  }

  Widget _changeThemeIconButton(BuildContext context) {
    return Padding(
      padding: context.isArabicLang
          ? EdgeInsets.only(left: context.width * 0.055)
          : EdgeInsets.only(right: context.width * 0.055),
      child: CircleAvatar(
        backgroundColor: context.themeColors.background,
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return IconButton(
              onPressed: () async {
                Brightness newThemeBrightness =
                    context.theme.brightness == Brightness.dark ? Brightness.light : Brightness.dark;
                context.read<ThemeCubit>().updateTheme(newThemeBrightness);
                NavigatorHelper.pop();
              },
              icon: AppIcons.animatedLightDark(context),
            );
          },
        ),
      ),
    );
  }
}
