import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/app_settings.dart';
import 'package:zad_almumin/constents/my_sizes.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/pages/quran/models/menu_options_item.dart';
import 'package:zad_almumin/pages/quran/components/quran_search_delegate.dart';
import '../../../constents/my_colors.dart';
import '../../../constents/my_icons.dart';
import '../../../constents/my_texts.dart';
import '../../../services/theme_service.dart';
import '../../home/home_page.dart';
import '../../settings/settings_ctr.dart';
import '../controllers/quran/quran_page_ctr.dart';
import '../tafseer_page.dart';

class QuranPageUp extends GetView<ThemeCtr> {
  QuranPageUp({Key? key, required this.quranPageSetState}) : super(key: key);
  VoidCallback quranPageSetState;
  final double _upPartHeight = 50;
  final QuranPageCtr _quranCtr = Get.find<QuranPageCtr>();
  final SettingsCtr _settingsCtr = Get.find<SettingsCtr>();
  var goToPageTextCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.theme;

    return SafeArea(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: _quranCtr.onShown.value ? _upPartHeight : 0,
        width: Get.size.width,
        decoration: BoxDecoration(
          color: MyColors.quranBackGround,
          // boxShadow: [
          //   BoxShadow(
          //     color: MyColors.quranPrimary.withOpacity(0.5),
          //     offset: Offset(0, 5),
          //     blurRadius: 30,
          //     spreadRadius: .5,
          //   )
          // ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AnimatedOpacity(
              opacity: _quranCtr.onShown.value ? 1 : 0,
              duration: Duration(milliseconds: 200),
              child: PopupMenuButton(
                color: MyColors.quranBackGround,
                icon: MyIcons.moreVert(color: MyColors.quranPrimary),
                itemBuilder: (context) => getMenuItems(),
              ),
            ),
            appBarButton(
              onPressed: () => Get.offAll(() => HomePage()),
              icon: MyIcons.home(color: MyColors.quranPrimary),
            ),
            appBarButton(
              onPressed: () => _quranCtr.changeQuranImagesStyle(),
              icon: Obx(() => MyIcons.animated_swichQuranImages(color: MyColors.quranPrimary)),
            ),
            Expanded(flex: 2, child: Container()),
            appBarButton(
              onPressed: () => showSearch(context: context, delegate: QuranSearchDelegate()),
              icon: MyIcons.search(color: MyColors.quranPrimary),
            ),
            appBarButton(
              onPressed: () => AppSettings.scaffoldKey.currentState!.openEndDrawer(),
              icon: MyIcons.book(color: MyColors.quranPrimary),
            )
          ],
        ),
      ),
    );
  }

  Widget appBarButton({required VoidCallback onPressed, required Widget icon}) {
    return AnimatedOpacity(
      opacity: _quranCtr.onShown.value ? 1 : 0,
      duration: Duration(milliseconds: 200),
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }

  List<PopupMenuItem> getMenuItems() {
    List<PopupMenuItem> itemsList = [];
    List<MenuOptionsItem> menuItemList = [
      MenuOptionsItem(
        title: 'اضافة علامة'.tr,
        icon: MyIcons.mark(color: MyColors.quranPrimary),
        onTap: () => _quranCtr.showMarkDialog(),
      ),
      MenuOptionsItem(
        title: 'تغير الثيم'.tr,
        icon: MyIcons.animated_Light_Dark(),
        onTap: () {
          _settingsCtr.changeDarkModeState(!Get.isDarkMode);
          _quranCtr.changeOnShownState(false);
          Future.delayed(Duration(milliseconds: 200), () {
            quranPageSetState.call();
          });
        },
      ),
      MenuOptionsItem(
        title: 'التفاسير'.tr,
        icon: MyIcons.peaper(color: MyColors.quranPrimary),
        onTap: () =>
            Get.to(() => TafseersPage(), transition: Transition.cupertinoDialog, duration: Duration(milliseconds: 200)),
      ),
    ];
    MenuOptionsItem changeFontSizeMenu = MenuOptionsItem(
      child: Obx(() {
        return SizedBox(
          width: Get.width * .30,
          child: Slider(
            max: (Get.width * Get.height * 0.00010),
            min: (Get.width * Get.height * 0.000040),
            activeColor: MyColors.quranPrimary,
            thumbColor: MyColors.quranBackGround,
            value: _quranCtr.quranFontSize.value,
            onChanged: (val) => _quranCtr.updateQuranFontSize(val),
          ),
        );
      }),
      icon: MyIcons.letterSize(color: MyColors.quranPrimary),
      title: "حجم الخط".tr,
      onTap: null,
    );
    MenuOptionsItem changeFontTypeMenu = MenuOptionsItem(
      child: Obx(() {
        return DropdownButton<String>(
          onChanged: (val) => _settingsCtr.changeQuranFont(val!, setState: quranPageSetState),
          value: _settingsCtr.defaultFontQuran.value,
          items: MyFonts.values
              .map(
                (e) => DropdownMenuItem<String>(
                  value: e.name,
                  child: Text(
                    e.arabicName.toString().tr,
                    style: TextStyle(
                      fontFamily: AppSettings.isArabicLang ? e.name : FontStyle.normal.toString(),
                      color: _settingsCtr.defaultFontQuran.value == e.name ? MyColors.primary : MyColors.whiteBlack,
                    ),
                  ),
                ),
              )
              .toList(),
        );
      }),
      icon: MyIcons.letter(size: MySiezes.icon),
      title: "تعديل نوع الخط".tr,
      onTap: null,
    );

    itemsList.add(
      PopupMenuItem(
        value: changeFontSizeMenu,
        onTap: null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            changeFontSizeMenu.icon,
            SizedBox(width: Get.width * .04),
            MyTexts.main(title: changeFontSizeMenu.title, size: 16),
            changeFontSizeMenu.child != null ? changeFontSizeMenu.child! : Container(),
          ],
        ),
      ),
    );
    itemsList.add(
      PopupMenuItem(
        value: changeFontTypeMenu,
        onTap: null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            changeFontTypeMenu.icon,
            SizedBox(width: Get.width * .04),
            MyTexts.main(title: changeFontTypeMenu.title.tr, size: 16),
            SizedBox(width: Get.width * .04),
            changeFontTypeMenu.child != null ? changeFontTypeMenu.child! : Container(),
          ],
        ),
      ),
    );

    itemsList.addAll(
      menuItemList.map(
        (e) => PopupMenuItem(
          value: e,
          onTap: null,
          child: GestureDetector(
            onTap: () {
              Get.back();
              e.onTap?.call();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                e.icon,
                SizedBox(width: Get.width * .04),
                MyTexts.main(title: e.title, size: 16),
                e.child != null ? e.child! : Container(),
              ],
            ),
          ),
        ),
      ),
    );

    return itemsList;
  }
}
