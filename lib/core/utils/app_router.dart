import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zad_almumin/features/pray_times/presentation/pages/pray_times_page.dart';
import 'package:zad_almumin/features/quran/presentation/pages/quran_page.dart';
import '../helpers/pages_helper.dart';
import '../../features/alarm/presentation/cubit/alarm_cubit.dart';
import '../../features/alarm/presentation/pages/alarm_page.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/azkar/azkar.dart';
import '../../features/onboarding/pages/onboarding_page.dart';
import '../../features/splash/pages/splash_page.dart';
import '../../src/injection_container.dart';
import 'constants.dart';

enum AppRoutes {
  root("/Splash"),
  splash("/Splash"),

  // Home
  home("/home"),

  // Settings
  settings("/settings"),

  onboarding("/Onboarding"),
  azkar("/azkar"),
  allAzkars("/allAzkars"),
  alarm("/alarm"),
  prayTimes("/prayTimes"),
  quran("/quran"),
  ;

  const AppRoutes(this.path);
  final String path;
}

GoRouter appRouter = GoRouter(
  initialLocation: PagesHelper.getPagePath,
  navigatorKey: Constants.navigatorKey,
  debugLogDiagnostics: kDebugMode,
  routes: [
    //    GoRoute(
    //   path: Routes.root.path,
    //   name: Routes.root.name,
    //   redirect: (_, __) => Routes.signIn.path,
    // ),
    GoRoute(
      path: AppRoutes.root.path,
      name: AppRoutes.root.name,
      builder: (context, state) => SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.onboarding.path,
      name: AppRoutes.onboarding.name,
      builder: (context, state) => const Onboardingpage(),
    ),
    GoRoute(
      path: AppRoutes.home.path,
      name: AppRoutes.home.name,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<HomeCubit>(),
        child: const HomePage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.settings.path,
      name: AppRoutes.settings.name,
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: AppRoutes.azkar.path,
      name: AppRoutes.azkar.name,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<AzkarCubit>(),
        child: AzkarPage(zikrCategoryModel: state.extra as ZikrCategoryModel),
      ),
    ),
    GoRoute(
      path: AppRoutes.allAzkars.path,
      name: AppRoutes.allAzkars.name,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<AzkarCubit>(),
        child: const AllAzkarsPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.alarm.path,
      name: AppRoutes.alarm.name,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<AlarmCubit>(),
        child: const AlarmPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.prayTimes.path,
      name: AppRoutes.prayTimes.name,
      builder: (context, state) => const PrayTimesPage(),
    ),
    GoRoute(
      path: AppRoutes.quran.path,
      name: AppRoutes.quran.name,
      builder: (context, state) => QuranPage(),
    ),
  ],
);
