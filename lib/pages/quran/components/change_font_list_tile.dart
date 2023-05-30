import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/my_icons.dart';
import 'package:zad_almumin/constents/my_sizes.dart';
import 'package:zad_almumin/constents/my_texts.dart';
import 'package:zad_almumin/moduls/enums.dart';
import 'package:zad_almumin/pages/settings/settings_ctr.dart';

class ListTileChangeFont extends StatelessWidget {
  ListTileChangeFont({super.key, this.setState});
  VoidCallback? setState;
  final SettingsCtr _settingsCtr = Get.find<SettingsCtr>();
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: MyTexts.settingsTitle(title: 'تعديل نوع الخط'),
      subtitle: MyTexts.settingsContent(title: 'قم باختيار نوع الخط المناسب لك'),
      trailing: DropdownButton<String>(
        onChanged: (val) => _settingsCtr.changeMainFont(val!, setState: setState),
        value: _settingsCtr.defaultFontMain.value,
        items: [
          ...MyFonts.values
              .map((e) => DropdownMenuItem<String>(
                    value: e.name,
                    child: Text(e.arabicName.toString(), style: TextStyle(fontFamily: e.name)),
                  ))
              .toList()
        ],
      ),
      leading: MyIcons.letter(size: MySiezes.icon * 1.2),
    );
  }
}
