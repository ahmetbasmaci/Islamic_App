import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../core/utils/app_router.dart';
import '../features/pray_times/pray_times.dart';
import '../features/theme/cubit/theme_cubit.dart';
import 'injection_container.dart' as di;
import '../config/local/l10n.dart';
import '../features/locale/cubit/locale_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<ThemeCubit>()..getSavedTheme()),
        BlocProvider(create: (context) => di.sl<LocaleCubit>()..getSavedLocale()),
        BlocProvider(create: (context) => di.sl<PrayTimesCubit>()..updatePrayerTimes()),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, lcoaleState) => BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) => _materialWidget(lcoaleState, themeState),
        ),
      ),
    );
  }

  Widget _materialWidget(LocaleState lcoaleState, ThemeState themeState) {
    return MaterialApp.router(
      routerConfig: appRouter,
      localizationsDelegates: [
        AppStrings.delegate,
        const AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppStrings.delegate.supportedLocales,
      locale: Locale(lcoaleState.locale),
      // key: Constants.scaffoldKey,
      theme: themeState.theme,
      debugShowCheckedModeBanner: false,
    );
  }
}
