import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import '../../../config/local/l10n.dart';
import '../../../core/extentions/extentions.dart';
import '../../../core/helpers/navigator_helper.dart';
import '../../../core/utils/app_router.dart';
import '../../../core/utils/resources/app_images.dart';
import '../model/my_content_config.dart';

class Onboardingpage extends StatefulWidget {
  const Onboardingpage({super.key});

  @override
  State<Onboardingpage> createState() => _OnboardingpageState();
}

class _OnboardingpageState extends State<Onboardingpage> {
  List<MyContentConfig> pages = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setPagesDataToList();
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: IntroSlider(
          backgroundColorAllTabs: context.themeColors.background,
          listContentConfig: pages,
          renderDoneBtn: _textButton(AppStrings.of(context).done),
          renderNextBtn: _textButton(AppStrings.of(context).next),
          renderPrevBtn: _textButton(AppStrings.of(context).prev),
          renderSkipBtn: _textButton(AppStrings.of(context).skip),
          isShowSkipBtn: false,
          isShowPrevBtn: true,
          isShowDoneBtn: true,
          isShowNextBtn: true,
          indicatorConfig: IndicatorConfig(
            colorIndicator: Colors.grey,
            colorActiveIndicator: context.themeColors.primary,
            sizeIndicator: 10.5,
            typeIndicatorAnimation: TypeIndicatorAnimation.sliding,
          ),
          onDonePress: () => _onDonePress(context),
          onSkipPress: () => _onSkipPress(context),
        ),
      ),
    );
  }

  void setPagesDataToList() {
    pages = [
      MyContentConfig(
        context: context,
        title: AppStrings.of(context).welcomeToApp,
        description: AppStrings.of(context).youCanListenAHoleQuran,
        pathImage: AppImages.pray_3d,
      ),
      MyContentConfig(
        context: context,
        title: AppStrings.of(context).quranTefsirTitle,
        description: AppStrings.of(context).quranTefsirDesc,
        pathImage: AppImages.quran2_3d,
      ),
      MyContentConfig(
        context: context,
        title: AppStrings.of(context).hadithAndFastReminderTitle,
        description: AppStrings.of(context).hadithAndFastReminderDesc,
        pathImage: AppImages.dua_3d,
      ),
      MyContentConfig(
        context: context,
        title: AppStrings.of(context).prayTimesTitle,
        description: AppStrings.of(context).prayTimesDesc,
        pathImage: AppImages.ezan_3d,
      ),
      MyContentConfig(
        context: context,
        title: AppStrings.of(context).questinosAboutQuranTitle,
        description: AppStrings.of(context).questinosAboutQuranDesc,
        pathImage: AppImages.question_3d,
      ),
    ];
  }

  Widget _textButton(String title) {
    return Text(title);
  }

  void _onDonePress(BuildContext context) {
    NavigatorHelper.pushReplacementNamed(AppRoutes.home);
  }

  void _onSkipPress(BuildContext context) {
    NavigatorHelper.pushReplacementNamed(AppRoutes.home);
  }
}
