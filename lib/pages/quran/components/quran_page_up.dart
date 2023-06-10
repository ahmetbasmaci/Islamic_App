import 'package:animated_button/animated_button.dart';
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
import '../../home_page.dart';
import '../../settings/settings_ctr.dart';
import '../controllers/quran_page_ctr.dart';

class QuranPageUp extends GetView<ThemeCtr> {
  QuranPageUp({Key? key, required this.quranPageSetState}) : super(key: key);
  VoidCallback quranPageSetState;
  // final double _upPartHeight = Constants.quranUpPartHeight; //30 is the height of the menu options
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
          color: MyColors.quranBackGround(),
          boxShadow: [
            BoxShadow(
                color: MyColors.quranPrimary().withOpacity(0.5), offset: Offset(0, 5), blurRadius: 30, spreadRadius: .5)
          ],
        ),
        child: Align(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedOpacity(
                      opacity: _quranCtr.onShown.value ? 1 : 0,
                      duration: Duration(milliseconds: 200),
                      child: PopupMenuButton(
                          color: MyColors.quranBackGround(),
                          icon: MyIcons.moreVert(color: MyColors.quranPrimary()),
                          itemBuilder: (context) => getMenuItems()),
                    ),
                    AnimatedButton(
                      color: MyColors.quranBackGround(),
                      width: MySiezes.btnIcon,
                      height: MySiezes.btnIcon,
                      onPressed: () => Get.offAll(() => HomePage()),
                      child: MyIcons.home(color: MyColors.quranPrimary()),
                    ),
                    // SizedBox(width: MySiezes.btnIcon),
                    // AnimatedButton(
                    //   color: MyColors.quranBackGround(),
                    //   width: MySiezes.btnIcon,
                    //   height: MySiezes.btnIcon,
                    //   onPressed: () => _quranCtr.changeShowQuranStyle(),
                    //   child: Obx(() => MyIcons.animated_swichQuranImages(color: MyColors.quranPrimary())),
                    // ),
                  ],
                ),
              ),
              Expanded(flex: 2, child: Container()),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AnimatedButton(
                        color: MyColors.quranBackGround(),
                        width: MySiezes.btnIcon,
                        height: MySiezes.btnIcon,
                        onPressed: () => showSearch(context: context, delegate: QuranSearchDelegate()),
                        child: MyIcons.search(color: MyColors.quranPrimary())),
                    SizedBox(width: MySiezes.btnIcon),
                    AnimatedButton(
                      color: MyColors.quranBackGround(),
                      width: MySiezes.btnIcon,
                      height: MySiezes.btnIcon,
                      onPressed: () => AppSettings.scaffoldKey.currentState!.openEndDrawer(),
                      child: MyIcons.book(color: MyColors.quranPrimary()),
                    ),
                    SizedBox(width: MySiezes.btnIcon / 2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget changeFontSize() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [],
    );
  }

  List<PopupMenuItem> getMenuItems() {
    List<PopupMenuItem> itemsList = [];
    List<MenuOptionsItem> menuItemList = [
      MenuOptionsItem(
        title: 'اضافة علامة'.tr,
        icon: MyIcons.mark(color: MyColors.quranPrimary()),
        onTap: () => _quranCtr.showMarkDialog(),
      ),
      MenuOptionsItem(
        title: 'تغير الثيم'.tr,
        icon: MyIcons.animated_Light_Dark(color: MyColors.quranPrimary()),
        onTap: () {
          _settingsCtr.changeDarkModeState(!Get.isDarkMode);
          _quranCtr.changeOnShownState(false);
          Future.delayed(Duration(milliseconds: 200), () {
            quranPageSetState.call();
          });
        },
      ),
    ];
    MenuOptionsItem changeFontSizeMenu = MenuOptionsItem(
      child: Obx(() {
        return SizedBox(
          width: Get.width * .30,
          // height: Get.width * .06,
          child: Slider(
            max: (Get.width * Get.height * 0.00010),
            min: (Get.width * Get.height * 0.000040),
            activeColor: MyColors.quranPrimary(),
            thumbColor: MyColors.quranBackGround(),
            value: _quranCtr.quranFontSize.value,
            onChanged: (val) {
              _quranCtr.updateQuranFontSize(val);
            },
          ),
        );
      }),
      icon: MyIcons.letterSize(color: MyColors.quranPrimary()),
      title: "حجم الخط".tr,
      onTap: () async {},
    );
    MenuOptionsItem changeFontTypeMenu = MenuOptionsItem(
      child: Obx(() {
        return DropdownButton<String>(
          onChanged: (val) => _settingsCtr.changeQuranFont(val!, setState: quranPageSetState),
          value: _settingsCtr.defaultFontQuran.value,
          items: MyFonts.values
              .map((e) => DropdownMenuItem<String>(
                    value: e.name,
                    child: Text(e.arabicName.toString().tr,
                        style: TextStyle(fontFamily: AppSettings.isArabicLang ? e.name : FontStyle.normal.toString())),
                  ))
              .toList(),
        );
      }),
      icon: MyIcons.letter(size: MySiezes.icon),
      title: "تعديل نوع الخط".tr,
      onTap: () {},
    );

    itemsList.add(PopupMenuItem(
      value: changeFontSizeMenu,
      onTap: null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          changeFontSizeMenu.icon,
          SizedBox(width: Get.width * .04),
          MyTexts.main(title: changeFontSizeMenu.title, color: MyColors.quranPrimary(), size: 16),
          changeFontSizeMenu.child != null ? changeFontSizeMenu.child! : Container(),
        ],
      ),
    ));
    itemsList.add(PopupMenuItem(
      value: changeFontTypeMenu,
      onTap: null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          changeFontTypeMenu.icon,
          SizedBox(width: Get.width * .04),
          MyTexts.main(title: changeFontTypeMenu.title.tr, color: MyColors.quranPrimary(), size: 16),
          SizedBox(width: Get.width * .04),
          changeFontTypeMenu.child != null ? changeFontTypeMenu.child! : Container(),
        ],
      ),
    ));

    itemsList.addAll(menuItemList.map(
      (e) => PopupMenuItem(
        value: e,
        onTap: null,
        child: GestureDetector(
          onTap: () {
            Get.back();
            e.onTap();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              e.icon,
              SizedBox(width: Get.width * .04),
              MyTexts.main(title: e.title, color: MyColors.quranPrimary(), size: 16),
              e.child != null ? e.child! : Container(),
            ],
          ),
        ),
      ),
    ));

    return itemsList;
  }
}
