import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/constents.dart';
import 'package:zad_almumin/constents/my_sizes.dart';
import 'package:zad_almumin/pages/quran/components/menu_options_item.dart';
import 'package:zad_almumin/pages/quran/components/quran_search_delegate.dart';
import '../../../constents/my_colors.dart';
import '../../../constents/my_icons.dart';
import '../../../constents/my_texts.dart';
import '../../../services/theme_service.dart';
import '../../home_page.dart';
import '../../settings/settings_ctr.dart';
import '../controllers/quran_page_ctr.dart';

class QuranPageUp extends GetView<ThemeCtr> {
  QuranPageUp({Key? key, required this.quranPageSetState}) : super(key: key);
  VoidCallback quranPageSetState;
  final double _upPartHeight = Constants.quranUpPartHeight + 30; //30 is the height of the menu options

  final QuranPageCtr _quranCtr = Get.find<QuranPageCtr>();
  final SettingsCtr _settingsCtr = Get.find<SettingsCtr>();
  var goToPageTextCtr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    context.theme;
    List<MenuOptionsItem> menuItemList = [
      MenuOptionsItem(
        title: 'اضافة علامة',
        icon: MyIcons.mark(color: MyColors.quranPrimary()),
        onTap: () => _quranCtr.showMarkDialog(),
      ),
      MenuOptionsItem(
        title: 'تغير الثيم',
        icon: MyIcons.animated_Light_Dark(color: MyColors.quranPrimary()),
        onTap: () async {
          bool isDark = Get.isDarkMode;
          _settingsCtr.changeDarkModeState(!isDark);
          _quranCtr.changeOnShownState(false);
          Future.delayed(Duration(milliseconds: 200), () {
            quranPageSetState.call();
          });
        },
      ),
    ];
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      top: _quranCtr.onShown.value ? 0 : -_upPartHeight,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: _upPartHeight,
        width: Get.size.width,
        decoration: BoxDecoration(
          color: MyColors.quranBackGround(),
          boxShadow: [
            BoxShadow(
                color: MyColors.quranPrimary().withOpacity(0.2), offset: Offset(0, 5), blurRadius: 30, spreadRadius: .5)
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: MySiezes.btnIcon * .5),
                      child: AnimatedButton(
                        color: MyColors.quranBackGround(),
                        width: MySiezes.btnIcon,
                        height: MySiezes.btnIcon,
                        onPressed: () => Get.offAll(() => HomePage()),
                        child: MyIcons.home(color: MyColors.quranPrimary()),
                      ),
                    ),
                    PopupMenuButton(
                        color: MyColors.quranBackGround(),
                        icon: MyIcons.moreVert(color: MyColors.quranPrimary()),
                        itemBuilder: (context) {
                          return [
                            ...menuItemList.map((e) => PopupMenuItem(
                                  value: e,
                                  child: InkWell(
                                    onTap: () {
                                      Get.back();
                                      e.onTap();
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        e.icon,
                                        SizedBox(width: Get.width * .04),
                                        MyTexts.quran(title: e.title, color: MyColors.quranPrimary(), size: 16),
                                      ],
                                    ),
                                  ),
                                )),
                          ];
                        }),
                    AnimatedButton(
                      color: MyColors.quranBackGround(),
                      width: MySiezes.btnIcon,
                      height: MySiezes.btnIcon,
                      onPressed: () => _quranCtr.changeShowQuranStyle(),
                      child: MyIcons.swichQuranImages(color: MyColors.quranPrimary()),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // MyTexts.quranSecondTitle(title: 'الصفحة:   '),
                  // SizedBox(
                  //   width: 40,
                  //   child: Focus(
                  //     focusNode: Constants.focusScopeNode,
                  //     child: TextField(
                  //       controller: goToPageTextCtr,
                  //       keyboardType: TextInputType.number,
                  //       maxLength: 3,
                  //       cursorHeight: 20,
                  //       showCursor: false,
                  //       onSubmitted: (val) {
                  //         goToPageTextCtr.clear();
                  //         _quranCtr.changeOnShownState(false);
                  //       },
                  //       onTap: () => goToPageTextCtr.clear(),
                  //       onChanged: (query) {
                  //         if (query == '') return;
                  //         if (int.parse(query) > 604 || int.parse(query) < 1) {
                  //           Fluttertoast.showToast(msg: 'صفحة غير موجودة');
                  //           return;
                  //         }
                  //         _quranCtr.tabCtr.index = int.parse(goToPageTextCtr.text) - 1;
                  //       },
                  //       decoration: InputDecoration(
                  //         isDense: true,
                  //         contentPadding: EdgeInsets.fromLTRB(2, 2, 5, 2),
                  //         border: UnderlineInputBorder(),
                  //         counterText: "",
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  IconButton(
                      onPressed: () => showSearch(context: context, delegate: QuranSearchDelegate()),
                      icon: MyIcons.search(color: MyColors.quranPrimary())),
                  IconButton(
                    onPressed: () => Constants.scaffoldKey.currentState!.openEndDrawer(),
                    icon: MyIcons.book(color: MyColors.quranPrimary()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
