import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:zad_almumin/components/my_drawer.dart';
import 'package:zad_almumin/components/my_app_bar.dart';
import 'package:zad_almumin/constents/colors.dart';
import 'package:zad_almumin/constents/sizes.dart';
import 'package:zad_almumin/screens/azkar_blocks_screen.dart';
import 'package:zad_almumin/screens/main_screen.dart';
import '../services/theme_service.dart';
import '../components/main_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = 'HomePage';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List<Widget> items = [
    Image.asset("assets/images/islam.png", width: MySiezes.tapbarImage),
    Image.asset("assets/images/azkar.png", width: MySiezes.tapbarImage),
  ];
  List<Widget> screens = [
    MainScreen(),
    AzkarBlockScreen(),
  ];

  updateCurrentIndex(int newIndex) {
    currentIndex = newIndex;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: MyAppBar(title: 'الرئيسية'),
          drawer: MyDrawer(),
          bottomNavigationBar: CurvedNavigationBar(
            height: MySiezes.navigationTap,
            items: items,
            color: ThemeService().getThemeMode() == ThemeMode.dark ? MyColors.primaryDark : MyColors.primary,
            backgroundColor:
                ThemeService().getThemeMode() == ThemeMode.dark ? MyColors.backgroundDark : MyColors.background,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 300),
            index: currentIndex,
            onTap: (newIndex) {
              updateCurrentIndex(newIndex);
            },
          ),
          body: mainContainer(child: screens[currentIndex])),
    );
  }
}
