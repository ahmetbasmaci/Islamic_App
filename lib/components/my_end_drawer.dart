import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/constents/my_icons.dart';
import 'package:zad_almumin/constents/my_texts.dart';
import 'package:zad_almumin/pages/quran/controllers/quran_page_ctr.dart';
import 'package:zad_almumin/pages/quran/models/ayah.dart';
import 'package:zad_almumin/services/animation_service.dart';
import 'package:zad_almumin/services/theme_service.dart';

class MyEndDrawer extends GetView<ThemeCtr> {
  MyEndDrawer({super.key});

  final QuranPageCtr _quranCtr = Get.find<QuranPageCtr>();
  MyEndDrawerCtr myEndDrawerCtr = Get.find<MyEndDrawerCtr>();
  PageController pageController = PageController();

  List<Ayah> markedAyahs = [];
  @override
  Widget build(BuildContext context) {
    context.theme;
    pageController = PageController(initialPage: myEndDrawerCtr.currentPage.value);
    _quranCtr.markedList.sort((a, b) => a.pageNumber.compareTo(b.pageNumber));
    markedAyahs = _quranCtr.getMarkedAyahs();
    pageController.addListener(() {
      myEndDrawerCtr.currentPage.value = pageController.page!.toInt();
    });
    return SafeArea(
      child: Drawer(
        backgroundColor: MyColors.quranBackGround(),
        width: Get.width * 0.5,
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                markCategory(title: 'الصفحات', icon: MyIcons.mark(), index: 0),
                markCategory(title: 'الايات', icon: MyIcons.book(), index: 1),
              ],
            ),
            Divider(color: MyColors.quranPrimary()),
            Expanded(
              child: PageView(
                controller: pageController,
                children: [
                  Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      itemCount: _quranCtr.markedList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: index != _quranCtr.markedList.length - 1 ? 10 : 0),
                          child: AnimationService.animationListItemDownToUp(
                            index: index,
                            child: markedListTile(
                              title: 'الجزء ${_quranCtr.markedList[index].juz}',
                              subtitle:
                                  '${_quranCtr.markedList[index].surahName}  |  الصفحة ${_quranCtr.markedList[index].pageNumber}',
                              page: _quranCtr.markedList[index].pageNumber,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      itemCount: markedAyahs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: index != markedAyahs.length - 1 ? 10 : 0),
                          child: AnimationService.animationListItemDownToUp(
                            index: index,
                            child: markedListTile(
                              title: markedAyahs[index].text,
                              subtitle:
                                  '${markedAyahs[index].surahName}  |  الصفحة ${markedAyahs[index].page} | الجزء ${markedAyahs[index].juz}',
                              page: markedAyahs[index].page,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Expanded markCategory({required String title, required Icon icon, required int index}) {
    return Expanded(
      child: Obx(() {
        return Container(
          color: myEndDrawerCtr.currentPage.value == index ? MyColors.quranPrimary() : Colors.transparent,
          child: InkWell(
            child: Column(
              children: [
                icon = Icon(
                  icon.icon,
                  color:
                      myEndDrawerCtr.currentPage.value == index ? MyColors.quranBackGround() : MyColors.quranPrimary(),
                ),
                MyTexts.quranSecondTitle(
                  title: title,
                  color:
                      myEndDrawerCtr.currentPage.value == index ? MyColors.quranBackGround() : MyColors.quranPrimary(),
                )
              ],
            ),
            onTap: () => pageController.animateTo(Get.width * 0.5 * index,
                duration: Duration(milliseconds: 200), curve: Curves.easeIn),
          ),
        );
      }),
    );
  }

  Widget markedListTile({required String title, required String subtitle, required int page}) {
    return Column(
      children: [
        ListTile(
          title: MyTexts.settingsTitle(title: title),
          subtitle: MyTexts.settingsContent(title: subtitle),
          //shape: Border(bottom: BorderSide(color: MyColors.quranPrimary())),
          onTap: () => _quranCtr.markedItemBtnPress(page),
        ),
        Divider(color: MyColors.quranPrimary())
      ],
    );
  }
}

class MyEndDrawerCtr extends GetxController {
  RxInt currentPage = 0.obs;
}
