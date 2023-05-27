import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/constants.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/constents/my_sizes.dart';
import 'package:zad_almumin/constents/my_texts.dart';
import 'package:zad_almumin/pages/favorite/favorite_page.dart';
import 'package:zad_almumin/pages/home_page.dart';
import 'package:zad_almumin/pages/prayerTimes/prayer_times.dart';
import 'package:zad_almumin/pages/review_page.dart';
import 'package:zad_almumin/pages/settings/settings_ctr.dart';
import 'package:zad_almumin/pages/settings/settings_page.dart';
import 'package:zad_almumin/pages/user_reviews_page.dart';
import 'package:zad_almumin/screens/azkar_blocks_screen.dart';
import 'package:zad_almumin/services/theme_service.dart';
import '../constents/my_icons.dart';
import '../pages/alarms/alarms_page.dart';
import '../pages/ayahsTest/ayahs_questions.dart';

class MyDrawer extends GetView<ThemeCtr> {
  MyDrawer({
    Key? key,
  }) : super(key: key);
  final SettingsCtr _settingsCtr = Get.find<SettingsCtr>();

  @override
  Widget build(BuildContext context) {
    context.theme;
    return ClipPath(
      clipper: OvalLeftBorderClipper(),
      child: Drawer(
        width: MySiezes.drawerWith,
        child: ListView(
          shrinkWrap: true,
          physics: PageScrollPhysics(),
          children: [
            headerPart(),
            drawerItem(
              title: 'الرئيسية',
              icon: MyIcons.home(),
              routeName: HomePage.id,
              onTap: () async => navigateTo(context: context, routeName: HomePage.id, page: HomePage()),
            ),

            // drawerItem(
            //   title: 'مواقع الاسواق',
            //   icon: MyIcons.shop,
            //   routeName: ShopsPage.id,
            //   onTap: () async {
            //     var route = ModalRoute.of(context);
            //     if (route!.settings.name != ShopsPage.id) {
            //       await Get.to(ShopsPage());
            //       if (Get.currentRoute.contains(HomePage.id)) Get.offAll(HomePage());
            //     } else
            //       Get.back();
            //   },
            // ),

            drawerItem(
              title: 'المنبه',
              icon: MyIcons.notification(),
              routeName: AlarmPage.id,
              onTap: () async => navigateTo(context: context, routeName: AlarmPage.id, page: AlarmPage()),
            ),
            drawerItem(
              title: 'اوقات الصلاة',
              icon: MyIcons.prayersTime(),
              routeName: PrayerTimes.id,
              onTap: () async => navigateTo(context: context, routeName: PrayerTimes.id, page: PrayerTimes()),
            ),
            drawerItem(
              title: 'مراجعة القرآن',
              icon: MyIcons.ayahsTest,
              routeName: AyahsQuestions.id,
              onTap: () async => navigateTo(context: context, routeName: AyahsQuestions.id, page: AyahsQuestions()),
            ),
            drawerItem(
              title: 'أذكار المسلم',
              icon: MyIcons.azkar(),
              routeName: AzkarBlockScreen.id,
              onTap: () async => navigateTo(context: context, routeName: AzkarBlockScreen.id, page: AzkarBlockScreen()),
            ),

            Divider(height: 50, thickness: 2),
            drawerItem(
              title: 'المفضلة',
              icon: MyIcons.favoriteFilled(),
              routeName: FavoritePage.id,
              onTap: () async => navigateTo(context: context, routeName: FavoritePage.id, page: FavoritePage()),
            ),
            drawerItem(
              title: 'الإعدادات',
              icon: MyIcons.settings(),
              routeName: SettingsPage.id,
              onTap: () async => navigateTo(context: context, routeName: SettingsPage.id, page: SettingsPage()),
            ),
            drawerItem(
              title: 'ملاحظة للمطور',
              icon: MyIcons.review(),
              routeName: ReviewPage.id,
              onTap: () async => navigateTo(context: context, routeName: ReviewPage.id, page: ReviewPage()),
            ),
            Constants.machineCode == Constants.developerMachineCode
                ? drawerItem(
                    title: 'ملاحظات المستخدمين',
                    icon: MyIcons.reviewSound(),
                    routeName: UserReviews.id,
                    onTap: () async => navigateTo(context: context, routeName: UserReviews.id, page: UserReviews()),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget headerPart() {
    return UserAccountsDrawerHeader(
      accountName: MyTexts.drawerTitle(title: 'اقسام البرنامج'),
      accountEmail: Text(''),
      decoration: BoxDecoration(color: MyColors.primary()),
      otherAccountsPictures: [
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: CircleAvatar(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            child: IconButton(
              onPressed: () async {
                bool isDark = Get.isDarkMode;
                _settingsCtr.changeDarkModeState(!isDark);
                Get.back();
              },
              icon: MyIcons.animated_Light_Dark(),
            ),
          ),
        )
      ],
      otherAccountsPicturesSize: Size.square(60),
    );
  }

  navigateTo({required BuildContext context, required String routeName, required Widget page}) async {
    var route = ModalRoute.of(context);
    if (route!.settings.name!.contains(routeName)) {
      Get.back();
    } else {
      if (Get.currentRoute.contains(HomePage.id)) {
        Get.back();

        await Get.to(
          page,
          transition: Transition.rightToLeft,
          duration: Duration(milliseconds: 300),
          curve: Curves.decelerate,
        );
      } else {
        Get.back();

        await Get.off(
          page,
          transition: Transition.rightToLeft,
          duration: Duration(milliseconds: 300),
          curve: Curves.decelerate,
        );
      }

      if (Get.currentRoute.contains(HomePage.id)) Get.back();
    }
  }
}

Widget drawerItem(
    {required String title, required Widget icon, required String routeName, required VoidCallback onTap}) {
  bool selected = Get.currentRoute.contains(routeName);
  return ListTile(
    leading: icon,
    title: MyTexts.content(
        title: title,
        size: 17,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.right,
        color: selected ? MyColors.white : MyColors.whiteBlack()),
    selected: selected,
    selectedColor: MyColors.white,
    iconColor: MyColors.primary(),
    onTap: onTap,
  );
}
