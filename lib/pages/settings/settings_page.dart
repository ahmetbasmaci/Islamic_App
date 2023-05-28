import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/components/my_app_bar.dart';
import 'package:zad_almumin/constents/my_sizes.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/pages/quran/components/alert_dialog_ok_no.dart';
import 'package:zad_almumin/pages/quran/components/change_font_list_tile.dart';
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

class _SettingsPageState extends State<SettingsPage> {
  final SettingsCtr _settingsCtr = Get.find<SettingsCtr>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'الإعدادات', showDrawerBtn: false),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: MyTexts.settingsTitle(title: 'تنشيط الوضع اليلي'),
                subtitle: MyTexts.settingsContent(title: 'انقر هنا لاختيار الوضع اليلي'),
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
                  title: MyTexts.settingsTitle(title: 'تشفيل صوت الاشعارات'),
                  subtitle: MyTexts.settingsContent(title: 'عند تفعيل هذا الخيار سيتم تشفيل صوت الاشعارات'),
                  trailing: MySwitch(
                    value: _settingsCtr.isNotificationSoundOn.value,
                    onChanged: (newValue) => _settingsCtr.changeNotificationSoundMode(newValue),
                  ),
                  leading: MyIcons.animatedSound_On_Of(size: MySiezes.icon * 1.2),
                ),
              ),
              Divider(),
              ListTileChangeFont(setState: () => setState(() {}))
              // Divider(),
              // ListTile(
              //   title: MyTexts.settingsTitle(title: 'تغيير لون التطبيق'),
              //   subtitle: MyTexts.settingsContent(title: 'انقر هنا لاختيار لون التطبيق'),
              //   leading: MyIcons.animated_Light_Dark(size: MySiezes.icon * 1.2),
              //   onTap: () {
              //     showCupertinoDialog(
              //         context: context,
              //         builder: ((context) {
              //           return AlertDialog(
              //             content: Column(
              //               children: <Widget>[
              //                 CircleAvatar(
              //                   backgroundColor: MyColors.primaryColors[0],
              //                   radius: 20,
              //                   child: InkWell(
              //                     onTap: () {
              //                       _settingsCtr.changeThemeColor(MyColors.primaryColors[0]);
              //                       setState(() {});
              //                       Navigator.pop(context);
              //                     },
              //                   ),
              //                 ),
              //                 CircleAvatar(
              //                   backgroundColor: MyColors.primaryColors[1],
              //                   radius: 20,
              //                   child: InkWell(
              //                     onTap: () {
              //                       _settingsCtr.changeThemeColor(MyColors.primaryColors[1]);
              //                       setState(() {});
              //                       Navigator.pop(context);
              //                     },
              //                   ),
              //                 )
              //               ],
              //             ),
              //             // content: ListView.builder(
              //             //   itemCount:  MyColors.primaryColors.length,
              //             //     itemBuilder: (context, index) {
              //             //       return CircleAvatar(
              //             //         backgroundColor: MyColors.primaryColors[index],
              //             //         radius: 20,
              //             //         child: InkWell(
              //             //           onTap: () {
              //             //             ThemeService.instance.changeThemeColor(MyColors.primaryColors[index]);
              //             //             setState(() {});
              //             //             Navigator.pop(context);
              //             //           },
              //             //         ),
              //             //       );
              //             //     }),
              //           );
              //         }));
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
