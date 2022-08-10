import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/components/my_drawer.dart';
import 'package:zad_almumin/constents/colors.dart';
import 'package:zad_almumin/constents/icons.dart';

import 'home_page.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({Key? key}) : super(key: key);
  static const String id = 'QuranPage';
  @override
  State<QuranPage> createState() => _QuranPageState();
}

final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

class _QuranPageState extends State<QuranPage> with SingleTickerProviderStateMixin {
  bool onShown = false;
  var goToPageCtr = TextEditingController();
  late TabController tabCtr;
  @override
  void initState() {
    super.initState();
    tabCtr = TabController(length: 604, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        endDrawer: Drawer(),
        drawer: MyDrawer(),
        body: Stack(
          children: [
            DefaultTabController(
              initialIndex: 50,
              length: 604,
              child: TabBarView(
                controller: tabCtr,
                children: [for (var i = 1; i <= 604; i++) quranPage(index: i)],
              ),
            ),
            onShown
                ? Align(
                    alignment: Alignment.topCenter,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      height: 70,
                      decoration: BoxDecoration(color: MyColors.quranBackGround(), boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10, spreadRadius: 5),
                      ]),
                      child: Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () => Get.offAll(() => HomePage()),
                                icon: MyIcons.home(),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                SizedBox(
                                    width: 150,
                                    height: 30,
                                    child: TextField(
                                      controller: goToPageCtr,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      textAlignVertical: TextAlignVertical.center,
                                      maxLength: 3,
                                      maxLengthEnforcement: MaxLengthEnforcement.none,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'اذهب للصفحة',
                                        prefixIcon: IconButton(
                                          onPressed: () {
                                            if (int.parse(goToPageCtr.text) > 604 || int.parse(goToPageCtr.text) < 1) {
                                              Fluttertoast.showToast(msg: 'صفحة غير موجودة');
                                              return;
                                            }
                                            tabCtr.index = int.parse(goToPageCtr.text) - 1;
                                          },
                                          icon: MyIcons.send,
                                        ),
                                      ),
                                    )),
                                IconButton(
                                  onPressed: () {},
                                  icon: MyIcons.search,
                                ),
                                IconButton(
                                  onPressed: () => _key.currentState!.openEndDrawer(),
                                  icon: MyIcons.book,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container()
          ],
        ));
  }

  Widget quranPage({required int index}) {
    return InkWell(
      onTap: () {
        onShown = !onShown;
        setState(() {});
      },
      child: Container(
        color: MyColors.quranBackGround(),
        child: Stack(
          children: [
            Image.asset('assets/images/quran pages/00$index.png', fit: BoxFit.cover),
            Image.asset('assets/images/quran pages/000$index.png', fit: BoxFit.cover),
          ],
        ),
      ),
    );
  }
}
