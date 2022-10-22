import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/services/theme_service.dart';
import 'package:zad_almumin/constents/sizes.dart';
import '../constents/icons.dart';
import '../constents/texts.dart';
import '../components/my_switch.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static const String id = 'SettingsPage';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyTexts.outsideHeader(title: 'الإعدادات'),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: MyIcons.backArrow,
                  ),
                ],
              ),
              ListTile(
                title: MyTexts.settingsTitle(title: 'تنشيط الوضع اليلي'),
                subtitle: MyTexts.settingsContent(title: 'انقر هنا لاختيار الوضع اليلي'),
                trailing: MySwitch(
                    value: ThemeService().getThemeMode() == ThemeMode.dark,
                    onChanged: (newValue) async {
                      ThemeService().changeThemeMode(newValue);
                      await Future.delayed(Duration(milliseconds: 100));
                      setState(() {});
                    }),
                leading: MyIcons.animated_Light_Dark(size: MySiezes.icon * 1.2),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsCtr extends GetxController {
  RxBool isDarkMode = false.obs;
  SettingsCtr() {
    final getStorage = GetStorage();
    isDarkMode.value = getStorage.read('isDarkMode') ?? false;
  }
  changeDarkModeState(bool newValue) async {
    isDarkMode.value = newValue;
    ThemeService().changeThemeMode(newValue);
  }
}
