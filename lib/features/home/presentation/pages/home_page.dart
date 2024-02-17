import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/navigator_helper.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widget/app_scaffold.dart';
import '../cubit/cubit_quran/cubit_home/home_cubit.dart';
import '../widgets/home_page_body.dart';
import '../../../../config/local/l10n.dart';
import '../../../../core/utils/resources/app_constants.dart';
import '../../../../core/utils/resources/resources.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().updateLastOpenedPageId();
    context.read<HomeCubit>().updatePrayerTimesOnLoad();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppConstants.systemUiOverlayStyleDefault, //: AppSettings.systemUiOverlayStyleQuran,
      child: SafeArea(
        bottom: false,
        child: AppScaffold(
          title: AppStrings.of(context).mainPageTitle,
          showSettingsBtn: true,
          showDrawerBtn: true,
          actions: _actions,
          body: const HomePageBody(),

          // RefreshIndicator(
          //   color: context.themeColors.primary,
          //   onRefresh: () => _refereshIndecatorEvent(),
          //   child: const HomePageBody(),
          // ),
        ),
      ),
    );
  }

  List<Widget> get _actions {
    return [
      IconButton(
        onPressed: () => _quranIconClick(),
        icon: AppIcons.quran,
      )
    ];
  }

  void _quranIconClick() {
    NavigatorHelper.pushReplacementNamed(AppRoutes.quran);
  }

  // Future<void> _refereshIndecatorEvent() async {
  //   await Future.delayed(const Duration(seconds: 1));
  //   NavigatorHelper.pushReplacementNamed(AppRoutes.home);
  // }
}
