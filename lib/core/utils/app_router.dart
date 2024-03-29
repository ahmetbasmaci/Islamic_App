import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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

enum Routes {
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
  ;

  const Routes(this.path);
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
      path: Routes.root.path,
      name: Routes.root.name,
      builder: (context, state) => SplashPage(),
    ),
    GoRoute(
      path: Routes.onboarding.path,
      name: Routes.onboarding.name,
      builder: (context, state) => Onboardingpage(),
    ),
    GoRoute(
      path: Routes.home.path,
      name: Routes.home.name,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<HomeCubit>(),
        child: HomePage(),
      ),
    ),
    GoRoute(
      path: Routes.settings.path,
      name: Routes.settings.name,
      builder: (context, state) => SettingsPage(),
    ),
    GoRoute(
      path: Routes.azkar.path,
      name: Routes.azkar.name,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<AzkarCubit>(),
        child: AzkarPage(zikrCategoryModel: state.extra as ZikrCategoryModel),
      ),
    ),
    GoRoute(
      path: Routes.allAzkars.path,
      name: Routes.allAzkars.name,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<AzkarCubit>(),
        child: AllAzkarsPage(),
      ),
    ),
    GoRoute(
      path: Routes.alarm.path,
      name: Routes.alarm.name,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<AlarmCubit>(),
        child: AlarmPage(),
      ),
    ),
  ],
);
