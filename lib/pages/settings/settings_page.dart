import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/components/my_app_bar.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/constents/my_sizes.dart';
import 'package:zad_almumin/localization/my_local_ctr.dart';
import 'package:zad_almumin/moduls/enums.dart';
import '../../constents/my_icons.dart';
import '../../constents/my_texts.dart';
import '../../components/my_switch.dart';
import 'settings_ctr.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static const String id = 'SettingsPage';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with TickerProviderStateMixin {
  final SettingsCtr _settingsCtr = Get.find<SettingsCtr>();
  final MyLocalCtr _myLocalCtr = Get.find<MyLocalCtr>();
  Color pickerColor = MyColors.primary;
  TabController? tabController;

  List<MyLanguages> languagesList = [
    MyLanguages(lang: "العربية", code: "ar"),
    MyLanguages(lang: "English", code: "en"),
    MyLanguages(lang: "Türkçe", code: "tr"),
  ];

  @override
  Widget build(BuildContext context) {
    tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      appBar: MyAppBar(title: 'الإعدادات'.tr, showDrawerBtn: false),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: MyTexts.settingsTitle(title: "تنشيط الوضع اليلي".tr),
                subtitle: MyTexts.settingsContent(title: 'انقر هنا لاختيار الوضع اليلي'.tr),
                trailing: MySwitch(
                  value: Get.isDarkMode,
                  onChanged: (newValue) async {
                    _settingsCtr.changeDarkModeState(newValue);
                    await Future.delayed(Duration(milliseconds: 200));
                    setState(() {});
                  },
                ),
                leading: MyIcons.animated_Light_Dark(size: MySiezes.icon * 1.2),
              ),
              Divider(),
              Obx(
                () => ListTile(
                  title: MyTexts.settingsTitle(title: 'تشفيل صوت الاشعارات'.tr),
                  subtitle: MyTexts.settingsContent(title: 'عند تفعيل هذا الخيار سيتم تشفيل صوت الاشعارات'.tr),
                  trailing: MySwitch(
                    value: _settingsCtr.isNotificationSoundOn.value,
                    onChanged: (newValue) => _settingsCtr.changeNotificationSoundMode(newValue),
                  ),
                  leading: MyIcons.animatedSound_On_Of(size: MySiezes.icon * 1.2),
                ),
              ),
              Divider(),
              ListTile(
                title: MyTexts.settingsTitle(title: 'لغة البرنامج'.tr),
                subtitle: MyTexts.settingsContent(title: 'قم بإختيار لغة البرنامج المناسبة لك'.tr),
                leading: MyIcons.lang(size: MySiezes.icon * 1.2),
                trailing: DropdownButton<String>(
                  items: [
                    ...languagesList.map(
                      (e) => DropdownMenuItem(
                        value: e.code,
                        child: MyTexts.main(
                          title: e.lang,
                          fontFamily: MyFonts.uthmanic.name,
                          color:
                              e.code == _myLocalCtr.currentLocal.languageCode ? MyColors.primary : MyColors.whiteBlack,
                        ),
                      ),
                    ),
                  ],
                  value: _myLocalCtr.currentLocal.languageCode,
                  onChanged: (String? newSlectedLang) async {
                    await _myLocalCtr.updateLanguage(newSlectedLang ?? "");
                    await Future.delayed(Duration(milliseconds: 5));
                    setState(() {});
                  },
                ),
              ),
              Divider(),
              _myLocalCtr.currentLocal.languageCode == "ar"
                  ? ListTile(
                      title: MyTexts.settingsTitle(title: 'تعديل نوع الخط'.tr),
                      subtitle: MyTexts.settingsContent(title: 'قم باختيار نوع الخط المناسب لك'.tr),
                      leading: MyIcons.letter(size: MySiezes.icon * 1.2),
                      trailing: DropdownButton<String>(
                        onChanged: (val) => _settingsCtr.changeMainFont(val!, setState: () => setState(() {})),
                        value: _settingsCtr.defaultFontMain.value,
                        items: [
                          ...MyFonts.values
                              .map((e) => DropdownMenuItem<String>(
                                    value: e.name,
                                    child: Text(
                                      e.arabicName.toString(),
                                      style: TextStyle(
                                        fontFamily: e.name,
                                        color: e.name == _settingsCtr.defaultFontMain.value
                                            ? MyColors.primary
                                            : MyColors.whiteBlack,
                                      ),
                                    ),
                                  ))
                              .toList()
                        ],
                      ),
                    )
                  : Container(),
              Divider(),
              // ListTile(
              //   title: MyTexts.settingsTitle(title: 'تغيير لون التطبيق'.tr),
              //   subtitle: MyTexts.settingsContent(title: 'انقر هنا لاختيار لون التطبيق'.tr),
              //   leading: MyIcons.color(size: MySiezes.icon * 1.2),
              //   trailing: CircleAvatar(backgroundColor: MyColors.primary),
              //   onTap: () {
              //     Get.dialog(
              //       AlertDialog(
              //         contentPadding: EdgeInsets.zero,
              //         title: MyTexts.main(title: "تغيير لون التطبيق".tr, size: 20),
              //         content: SizedBox(
              //           height: Get.height,
              //           width: Get.width,
              //           child: Column(
              //             children: [
              //               TabBar(
              //                 controller: tabController,
              //                 tabs: [
              //                   Tab(child: MyTexts.main(title: "ثابت".tr)),
              //                   Tab(child: MyTexts.main(title: "مدرّج".tr)),
              //                   Tab(child: MyTexts.main(title: "يدوي".tr)),
              //                 ],
              //               ),
              //               Expanded(
              //                 child: TabBarView(
              //                   controller: tabController,
              //                   children: [
              //                     BlockPicker(
              //                         pickerColor: MyColors.primary, onColorChanged: (val) => pickerColor = val),
              //                     MaterialPicker(
              //                         pickerColor: MyColors.primary, onColorChanged: (val) => pickerColor = val),
              //                     ColorPicker(
              //                         pickerColor: MyColors.primary, onColorChanged: (val) => pickerColor = val),
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //         actions: <Widget>[
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.start,
              //             children: [
              //               ElevatedButton(
              //                 child: MyTexts.main(title: 'تأكيد'.tr, color: MyColors.white),
              //                 onPressed: () async {
              //                   await _settingsCtr.changeThemeColor(pickerColor, () => setState(() {}));
              //                   Get.back();
              //                 },
              //               ),
              //               TextButton(
              //                 child: MyTexts.main(title: 'إالغاء'.tr),
              //                 onPressed: () async => Get.back(),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //       // AlertDialog(
              //       //   content: Row(
              //       //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       //     children: <Widget>[
              //       //       ...MyColors.primaryColors.map(
              //       //         (e) => CircleAvatar(
              //       //           backgroundColor: e,
              //       //           child: InkWell(
              //       //             onTap: () async {
              //       //               await _settingsCtr.changeThemeColor(e, () => setState(() {}));
              //       //               Get.back();
              //       //             },
              //       //           ),
              //       //         ),
              //       //       ),
              //       //     ],
              //       //   ),
              //       // ),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyLanguages {
  String lang;
  String code;

  MyLanguages({required this.lang, required this.code});
}
