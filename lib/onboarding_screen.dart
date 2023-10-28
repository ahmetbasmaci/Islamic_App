import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:zad_almumin/constents/assets_manager.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/constents/my_texts.dart';
import 'package:zad_almumin/pages/home/home_page.dart';

class OnboardingScreen extends StatefulWidget {
  static const id = 'OnboardingScreen';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<MyContentConfig> pages = [
    MyContentConfig(
      title: "اهلا بك في تطبيق زاد المؤمن".tr,
      description: "يمكنك قراءة القرآن الكريم كاملاً والاستماع له بصوت العديد من القراء".tr,
      pathImage: ImagesManager.pray_3d,
    ),
    MyContentConfig(
      title: "تفسير القرآن الكريم".tr,
      description: "يمكنك قراءة تفسير القرآن الكريم للعديد من العلماء والمفسرين الكبار ".tr,
      pathImage: ImagesManager.quran2_3d,
    ),
    MyContentConfig(
      title: "تذكير بالاحاديث والصيام".tr,
      description: "يتيح لك التطبيق تذكيرك بالاحاديث والصيام والصلاة والاستغفار والاذكار والقرآن الكريم".tr,
      pathImage: ImagesManager.dua_3d,
    ),
    MyContentConfig(
      title: "اوقات الصلاة".tr,
      description: "يمكنك معرفة اوقات الصلاة والاذان عبر مشاركة موقعك الجغرافي مع التطبيق".tr,
      pathImage: ImagesManager.ezan_3d,
    ),
    MyContentConfig(
      title: "اسئلة عن القرآن الكريم".tr,
      description: "يمكنك اختبار مدى قوة حفظك للقرآن الكريم عبر اجابة على الاسئلة المتعلقة بالقرآن الكريم".tr,
      pathImage: ImagesManager.question_3d,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: IntroSlider(
          backgroundColorAllTabs: MyColors.background,
          listContentConfig: pages,
          renderDoneBtn: MyTexts.zikrTitle(title: 'تم'.tr),
          renderNextBtn: MyTexts.zikrTitle(title: 'التالي'.tr),
          renderPrevBtn: MyTexts.zikrTitle(title: 'السابق'.tr),
          renderSkipBtn: MyTexts.zikrTitle(title: 'تخطي'.tr),
          isShowSkipBtn: false,
          isShowPrevBtn: true,
          isShowDoneBtn: true,
          isShowNextBtn: true,
          indicatorConfig: IndicatorConfig(
            colorIndicator: Colors.grey,
            colorActiveIndicator: MyColors.primary,
            sizeIndicator: 10.5,
            typeIndicatorAnimation: TypeIndicatorAnimation.sliding,
          ),
          onDonePress: () => Get.offAll(HomePage()),
          onSkipPress: () => Get.offAll(HomePage()),
        ),
      ),
    );
  }
}

class MyContentConfig extends ContentConfig {
  MyContentConfig({
    required String title,
    required String description,
    required String pathImage,
  }) : super(
          title: title,
          description: description,
          pathImage: pathImage,
          styleTitle: MyTexts.quranStyle(fontSize: 25, color: MyColors.whiteBlack),
          styleDescription: MyTexts.quranStyle(fontSize: 20, color: MyColors.whiteBlack),
        );
}
