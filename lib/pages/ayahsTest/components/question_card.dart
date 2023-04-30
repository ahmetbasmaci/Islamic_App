import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/pages/quran/models/ayah.dart';
import 'package:zad_almumin/services/theme_service.dart';
import '../../../constents/my_colors.dart';
import '../../../constents/my_sizes.dart';
import '../../../constents/my_texts.dart';
import '../../../moduls/enums.dart';
import '../controller/ayahs_questions_ctr.dart';

class QuestionCard extends GetView<ThemeCtr> {
  QuestionCard({super.key, required this.ayah});
  AyahsQuestionsCtr ctr = Get.find<AyahsQuestionsCtr>();
  Ayah ayah;
  @override
  Widget build(BuildContext context) {
    context.theme;
    return Container(
      padding: EdgeInsets.all(MySiezes.cardPadding * 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MySiezes.blockRadius),
        color: MyColors.zikrCard(),
        border: Border.all(color: Colors.black, width: 1),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.6), blurRadius: 5, offset: Offset(0, 5)),
        ],
      ),
      child: MyTexts.quran(
        title: ctr.questionType.value == QuestionType.ayahInJuzAndPage ? ayah.text : ayah.surahName,
      ),
    );
  }
}
