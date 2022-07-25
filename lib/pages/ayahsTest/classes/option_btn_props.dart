import 'package:zad_almumin/constents/colors.dart';

import '../../../services/theme_service.dart';
import 'package:flutter/material.dart';
class OptionBtnProps {
  int juz;
  int page;
  Color color = ThemeService().getThemeMode() == ThemeMode.dark ? MyColors.zikrCardDark : MyColors.background;
  Color textColor = ThemeService().getThemeMode() == ThemeMode.dark ? MyColors.white : MyColors.black;
  OptionBtnProps({required this.juz, required this.page});
}



