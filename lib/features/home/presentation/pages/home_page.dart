import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/extentions/extentions.dart';
import '../../../../core/helpers/navigator_helper.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widget/app_scaffold.dart';
import '../cubit/home_cubit.dart';
import '../widgets/home_page_body.dart';
import '../../../../config/local/l10n.dart';
import '../../../../core/utils/constants.dart';
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
      value: Constants.systemUiOverlayStyleDefault, //: AppSettings.systemUiOverlayStyleQuran,
      child: SafeArea(
        bottom: false,
        child: AppScaffold(
          title: AppStrings.of(context).mainPageTitle,
          showSettingsBtn: true,
          actions: [
            IconButton(
              onPressed: () => _quranIconClick(),
              icon: AppIcons.quran,
            )
          ],
          body: RefreshIndicator(
            color: context.primaryColor,
            onRefresh: () => _refereshIndecatorEvent(),
            child: HomePageBody(),
          ),
        ),
      ),
    );
  }

  void _quranIconClick() {
//TODO
//Get.offAll(QuranPage(), duration: Duration(milliseconds: 200), transition: Transition.zoom)
  }
  Future<void> _refereshIndecatorEvent() async {
    await Future.delayed(Duration(seconds: 1));
    NavigatorHelper.pushReplacementNamed(Routes.home);
  }
}
