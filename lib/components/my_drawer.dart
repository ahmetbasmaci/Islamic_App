import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zad_almumin/constents/colors.dart';
import 'package:zad_almumin/constents/sizes.dart';
import 'package:zad_almumin/constents/texts.dart';
import 'package:zad_almumin/pages/favorite/favorite_page.dart';
import 'package:zad_almumin/pages/home_page.dart';
import 'package:zad_almumin/pages/settings/settings_ctr.dart';
import 'package:zad_almumin/pages/settings/settings_page.dart';
import 'package:zad_almumin/screens/azkar_blocks_screen.dart';
import '../pages/prayerTimes/prayer_times.dart';
import '../constents/icons.dart';
import '../pages/alarms/alarms_page.dart';
import '../pages/ayahsTest/ayahs_questions.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({
    Key? key,
  }) : super(key: key);
  final SettingsCtr _settingsCtr = Get.find<SettingsCtr>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MySiezes.drawerWith,
      child: ListView(
        shrinkWrap: true,
        physics: PageScrollPhysics(),
        children: [
          UserAccountsDrawerHeader(
            accountName: MyTexts.drawerTitle(title: 'اقسام البرنامج'),
            accountEmail: Text(''),
            decoration: BoxDecoration(color: MyColors.primary()),
            otherAccountsPictures: [
              CircleAvatar(
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                child: IconButton(
                  onPressed: () async {
                    bool isDark = Get.isDarkMode;
                    _settingsCtr.changeDarkModeState(!isDark);
                  },
                  icon: MyIcons.animated_Light_Dark(),
                ),
              )
            ],
            otherAccountsPicturesSize: Size.square(40),
          ),
          drawerItem(
            title: 'الرئيسية',
            icon: MyIcons.home(),
            routeName: HomePage.id,
            onTap: () async => navigateTo(context: context, routeName: HomePage.id, page: HomePage()),
          ),

          // // drawerItem(
          // //   context: context,
          // //   title: 'مواقع الاسواق',
          // //   icon: MyIcons.shop,
          // //   routeName: ShopsPage.id,
          // //   onTap: () async {
          // //     var route = ModalRoute.of(context);
          // //     if (route!.settings.name != ShopsPage.id) {
          // //       await Get.to(ShopsPage());
          // //       if (Get.currentRoute.contains(HomePage.id)) Get.offAll(HomePage());
          // //     } else
          // //       Get.back();
          // //   },
          // // ),

          drawerItem(
            title: 'المنبه',
            icon: MyIcons.notification(),
            routeName: AlarmPage.id,
            onTap: () async => navigateTo(context: context, routeName: AlarmPage.id, page: AlarmPage()),
          ),
          // drawerItem(
          //   title: 'اوقات الصلاة',
          //   icon: MyIcons.prayersTime(),
          //   routeName: PrayerTimes.id,
          //   onTap: () async => navigateTo(context: context, routeName: PrayerTimes.id, page: PrayerTimes()),
          // ),
          drawerItem(
            title: 'مراجعة القران',
            icon: MyIcons.ayahsTest,
            routeName: AyahsQuestions.id,
            onTap: () async => navigateTo(context: context, routeName: AyahsQuestions.id, page: AyahsQuestions()),
          ),
          drawerItem(
            title: 'اذكار المسلم',
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
        ],
      ),
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
          () => page,
          transition: Transition.rightToLeft,
          duration: Duration(milliseconds: 500),
          curve: Curves.decelerate,
        );
      } else {
        Get.back();

        await Get.off(
          page,
          transition: Transition.rightToLeft,
          duration: Duration(milliseconds: 500),
          curve: Curves.decelerate,
        );
      }

      if (Get.currentRoute.contains(HomePage.id)) Get.back();
    }
  }
}

Widget drawerItem(
    {required String title, required Widget icon, required String routeName, required VoidCallback onTap}) {
  return ListTile(
    leading: icon,
    title: Text(title, style: GoogleFonts.harmattan(fontSize: 17, fontWeight: FontWeight.bold)),
    // title: MyTexts.normal(title: title, size: 17, fontWeight: FontWeight.bold),
    selected: Get.currentRoute.contains(routeName),
    selectedColor: MyColors.white,
    iconColor: MyColors.primary(),
    onTap: onTap,
  );
}
