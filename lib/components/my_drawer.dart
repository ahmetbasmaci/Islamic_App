import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/colors.dart';
import 'package:zad_almumin/constents/sizes.dart';
import 'package:zad_almumin/constents/texts.dart';
import 'package:zad_almumin/pages/favorite_page.dart';
import 'package:zad_almumin/pages/home_page.dart';
import 'package:zad_almumin/pages/settings_page.dart';
import '../services/theme_service.dart';
import '../constents/icons.dart';
import '../pages/alarms_page.dart';
import '../pages/ayahsTest/first_ayahs_in_pages_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MySiezes.drawerWith,
      child: ListView(
        shrinkWrap: true,
        physics: PageScrollPhysics(),
        children: [
          UserAccountsDrawerHeader(
            accountName: MyTexts.drawerTitle(context, title: 'اقسام البرنامج'),
            accountEmail: Text(''),
            decoration: ThemeService().getThemeMode() == ThemeMode.dark
                ? BoxDecoration(color: MyColors.primaryDark)
                : BoxDecoration(color: MyColors.primary),
            // arrowColor: MyColors.background,
            // onDetailsPressed: () {
            //   print('onDetailsPressed');
            // },
            otherAccountsPictures: [
              CircleAvatar(
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                child: IconButton(
                  onPressed: () {
                    bool isDark = ThemeService().getThemeMode() == ThemeMode.dark;
                    ThemeService().changeThemeMode(!isDark);
                  },
                  icon: MyIcons.animated_Light_Dark(),
                ),
              )
            ],
            otherAccountsPicturesSize: Size.square(40),
          ),
          drawerItem(
            context: context,
            title: 'الرئيسية',
            icon: MyIcons.home,
            routeName: HomePage.id,
            onTap: () async {
              var route = ModalRoute.of(context);
              if (route!.settings.name != HomePage.id) {
                await Get.offAll(HomePage());
              } else
                Get.back();
            },
          ),

          // drawerItem(
          //   context: context,
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
            context: context,
            title: 'المنبه',
            icon: MyIcons.notification,
            routeName: AlarmPage.id,
            onTap: () async {
              navigateTo(context: context, routeName: AlarmPage.id, page: AlarmPage());
            },
          ),
          drawerItem(
            context: context,
            title: 'مراجعة القران',
            icon: MyIcons.ayahsTest,
            routeName: FirstAyahsInPages.id,
            onTap: () async {
              navigateTo(context: context, routeName: FirstAyahsInPages.id, page: FirstAyahsInPages());
            },
          ),
          Divider(height: 50, thickness: 2),
          drawerItem(
            context: context,
            title: 'المفضلة',
            icon: MyIcons.favoriteFilled,
            routeName: FavoritePage.id,
            onTap: () async {
              navigateTo(context: context, routeName: FavoritePage.id, page: FavoritePage());
            },
          ),
          drawerItem(
            context: context,
            title: 'الإعدادات',
            icon: MyIcons.settings,
            routeName: SettingsPage.id,
            onTap: () async {
              var route = ModalRoute.of(context);
              if (route!.settings.name != SettingsPage.id) {
                await Get.off(SettingsPage());
              } else
                Get.back();
            },
          ),
        ],
      ),
    );
  }

  navigateTo({required BuildContext context, required String routeName, required Widget page}) async {
    var route = ModalRoute.of(context);
    if (route!.settings.name != routeName) {
      if (Get.currentRoute.contains(HomePage.id))
        await Get.to(page);
      else
        await Get.off(page);

      if (Get.currentRoute.contains(HomePage.id)) Get.offAll(HomePage());
    } else
      Get.back();
  }
}

Widget drawerItem(
    {required BuildContext context,
    required String title,
    required Widget icon,
    required String routeName,
    required VoidCallback onTap}) {
  return ListTile(
    leading: icon,
    title: Text(title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
    tileColor: Get.currentRoute.contains(routeName)
        ? ThemeService().getThemeMode() == ThemeMode.dark
            ? MyColors.primaryDark.withOpacity(.5)
            : MyColors.primary.withOpacity(.8)
        : null,
    textColor: Get.currentRoute.contains(routeName)
        ? Color.fromARGB(255, 255, 255, 255)
        : ThemeService().getThemeMode() == ThemeMode.dark
            ? MyColors.white
            : MyColors.black,
    iconColor: Get.currentRoute.contains(routeName)
        ? Color.fromARGB(255, 239, 239, 239)
        : ThemeService().getThemeMode() == ThemeMode.dark
            ? MyColors.primaryDark
            : MyColors.primary,
    onTap: onTap,
  );
}
