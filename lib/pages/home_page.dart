import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/components/my_drawer.dart';
import 'package:zad_almumin/components/my_app_bar.dart';
import 'package:zad_almumin/constents/colors.dart';
import 'package:zad_almumin/constents/constents.dart';
import 'package:zad_almumin/constents/sizes.dart';
import 'package:zad_almumin/screens/azkar_blocks_screen.dart';
import 'package:zad_almumin/screens/main_screen.dart';
import '../constents/icons.dart';
import '../services/json_service.dart';
import 'quran/quran_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = 'HomePage';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Constants.setNewOpendPageId(HomePage.id);
  }

  int currentIndex = 0;
  List<Widget> icons = [
    MyIcons.home(color: MyColors.white),
    MyIcons.quran(color: MyColors.white),
    MyIcons.azkar(color: MyColors.white),
    // Icon(Icons.home, color: Colors.grey),
    // Icon(Icons.abc),
    // Icon(Icons.safety_check)
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: currentIndex != 1 ? Constants.systemUiOverlayStyleDefault : Constants.systemUiOverlayStyleQuran,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: currentIndex != 1 ? MyAppBar(title: 'الرئيسية') : null,
          drawer: currentIndex != 1 ? MyDrawer() : null,
          bottomNavigationBar: currentIndex != 1
              ? CurvedNavigationBar(
                  height: MySiezes.navigationTap,
                  items: icons,
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
          // bottomNavigationBar: ConvexAppBar.badge(
          //   const <int, dynamic>{3: '99+'},
          //   style: TabStyle.react,
          //   activeColor: MyColors.white,
          //   backgroundColor: MyColors.primary(),
          //   color: MyColors.background(),
          //   badgeColor: Colors.red,
          //   items: <TabItem>[
          //     for (final entry in icons) TabItem(icon: entry, title: ''),
          //   ],
          //   onTap: (newIndex) => updateCurrentIndex(newIndex),
          // ),
          body: currentIndex != 1
              ? RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(Duration(seconds: 1));
                    Get.offAll(() => HomePage(), transition: Transition.fadeIn, duration: Duration(milliseconds: 300));
                    // setState(() {});
                  },
                  child: screens[currentIndex])
              : screens[currentIndex],
        ),
      ),
    );
  }
}
