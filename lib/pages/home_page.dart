import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/components/my_drawer.dart';
import 'package:zad_almumin/components/my_app_bar.dart';
import 'package:zad_almumin/constents/colors.dart';
import 'package:zad_almumin/constents/sizes.dart';
import 'package:zad_almumin/screens/azkar_blocks_screen.dart';
import 'package:zad_almumin/screens/main_screen.dart';
import '../constents/icons.dart';
import '../components/main_container.dart';
import 'quran_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = 'HomePage';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List<Widget> items = [
    MyIcons.home(color: MyColors.background()),
    MyIcons.quran(color: MyColors.background()),
    MyIcons.azkar(color: MyColors.background()),
  ];
  List<Widget> screens = [
    MainScreen(),
    QuranPage(),
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
        appBar: currentIndex != 1 ? MyAppBar(title: 'الرئيسية') : null,
        drawer: currentIndex != 1 ? MyDrawer() : null,
        bottomNavigationBar: currentIndex != 1
            ? CurvedNavigationBar(
                height: MySiezes.navigationTap,
                items: items,
                color: MyColors.primary(),
                backgroundColor: MyColors.background(),
                animationCurve: Curves.easeInOut,
                animationDuration: Duration(milliseconds: 300),
                index: currentIndex,
                onTap: (newIndex) {
                  updateCurrentIndex(newIndex);
                },
              )
            : null,
        body: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 1));
              Get.offAll(() => HomePage(), transition: Transition.fadeIn);
              // setState(() {});
            },
            child: screens[currentIndex]),
      ),
    );
  }
}
