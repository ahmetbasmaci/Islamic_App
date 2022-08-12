import 'package:zad_almumin/constents/colors.dart';

import '../../../services/theme_service.dart';
import 'package:flutter/material.dart';

class OptionBtnProps {
  int juz;
  int page;
  Color color = ThemeService().getThemeMode() == ThemeMode.dark ? MyColors.zikrCard() :  MyColors.background();
  Color textColor = MyColors.whiteBlack();
  OptionBtnProps({required this.juz, required this.page});
}
