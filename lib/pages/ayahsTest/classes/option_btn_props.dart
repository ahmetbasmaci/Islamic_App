import 'package:get/get.dart';
import 'package:zad_almumin/constents/colors.dart';

import '../../../services/theme_service.dart';
import 'package:flutter/material.dart';

class OptionBtnProps {
  int juz;
  int page;
  Color color = MyColors.zikrCard();
  Color textColor = MyColors.whiteBlack();
  bool isPressed = false;
  OptionBtnProps({required this.juz, required this.page});
}
