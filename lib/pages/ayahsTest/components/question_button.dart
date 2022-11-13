import 'dart:math';

import 'package:get/get.dart';
import 'package:zad_almumin/pages/settings/settings_ctr.dart';
import 'package:zad_almumin/services/theme_service.dart';
import 'package:zad_almumin/pages/ayahsTest/controller/ayahs_questions_ctr.dart';
import '../../../constents/sizes.dart';
import '../../../constents/texts.dart';
import '../../../constents/colors.dart';
import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import '../../../moduls/enums.dart';
import '../classes/ayah_prop.dart';
import '../classes/option_btn_props.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class QuestionButtons extends StatelessWidget {
  QuestionButtons({Key? key, required this.selectedAyah}) : super(key: key);
  final AyahProp selectedAyah;
  List<OptionBtnProps> questionBtnProps = [];
  AyahsQuestionsCtr questionsCtr = Get.find<AyahsQuestionsCtr>();

  @override
  Widget build(BuildContext context) {
    questionBtnProps = getRandomJuzAndPages();
    return Column(
      children: <Widget>[
        const SizedBox(height: MySiezes.betweanCardItems * 2),
        MyTexts.outsideHeader(title: 'اختر الصفحة والجزء'),
        const SizedBox(height: MySiezes.betweanCardItems),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            OptionButton(
                optionBtnProps: questionBtnProps[0], questionBtnProps: questionBtnProps, selectedAyah: selectedAyah),
            OptionButton(
                optionBtnProps: questionBtnProps[1], questionBtnProps: questionBtnProps, selectedAyah: selectedAyah),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            OptionButton(
                optionBtnProps: questionBtnProps[2], questionBtnProps: questionBtnProps, selectedAyah: selectedAyah),
            OptionButton(
                optionBtnProps: questionBtnProps[3], questionBtnProps: questionBtnProps, selectedAyah: selectedAyah),
          ],
        )
      ],
    );
  }

  List<OptionBtnProps> getRandomJuzAndPages() {
    List<OptionBtnProps> list = [];
    int page1 = 0;
    int page2 = 0;
    int page3 = 0;
    int juz1 = 0;
    int juz2 = 0;
    int juz3 = 0;

    //check if page1 is not the same as page2 and in arrange betwean 1 and 20
    int random = Random().nextInt(3);
    if (random == 0) {
      page1 = selectedAyah.page - 1 > 0 ? selectedAyah.page - 1 : selectedAyah.page + 1;
      page2 = selectedAyah.page - 2 > 0 ? selectedAyah.page - 2 : selectedAyah.page + 2;
      page3 = selectedAyah.page - 3 > 0 ? selectedAyah.page - 3 : selectedAyah.page + 3;

      juz1 = selectedAyah.juz - 1 > 0 ? selectedAyah.juz - 1 : selectedAyah.juz + 1;
      juz2 = selectedAyah.juz - 2 > 0 ? selectedAyah.juz - 2 : selectedAyah.juz + 2;
      juz3 = selectedAyah.juz - 3 > 0 ? selectedAyah.juz - 3 : selectedAyah.juz + 3;
    } else if (random == 1) {
      page1 = selectedAyah.page - 1 > 0 ? selectedAyah.page - 1 : selectedAyah.page + 2;
      page2 = selectedAyah.page - 2 > 0 ? selectedAyah.page - 2 : selectedAyah.page + 3;
      page3 = selectedAyah.page + 1 < 21 ? selectedAyah.page + 1 : selectedAyah.page - 3;

      juz1 = selectedAyah.juz - 1 > 0 ? selectedAyah.juz - 1 : selectedAyah.juz + 2;
      juz2 = selectedAyah.juz - 2 > 0 ? selectedAyah.juz - 2 : selectedAyah.juz + 3;
      juz3 = selectedAyah.juz + 1 < 31 ? selectedAyah.juz + 1 : selectedAyah.juz - 3;
    } else if (random == 2) {
      page1 = selectedAyah.page - 1 > 0 ? selectedAyah.page - 2 : selectedAyah.page + 3;
      page2 = selectedAyah.page + 1 < 21 ? selectedAyah.page + 1 : selectedAyah.page - 1;
      page3 = selectedAyah.page + 2 < 21 ? selectedAyah.page + 2 : selectedAyah.page - 2;

      juz1 = selectedAyah.juz - 1 > 0 ? selectedAyah.juz - 2 : selectedAyah.juz + 3;
      juz2 = selectedAyah.juz + 1 < 31 ? selectedAyah.juz + 1 : selectedAyah.juz - 1;
      juz3 = selectedAyah.juz + 2 < 31 ? selectedAyah.juz + 2 : selectedAyah.juz - 2;
    } else if (random == 3) {
      page1 = selectedAyah.page + 1 < 21 ? selectedAyah.page + 1 : selectedAyah.page - 1;
      page2 = selectedAyah.page + 2 < 21 ? selectedAyah.page + 2 : selectedAyah.page - 2;
      page3 = selectedAyah.page + 3 < 21 ? selectedAyah.page + 3 : selectedAyah.page - 3;

      juz1 = selectedAyah.juz + 1 < 31 ? selectedAyah.juz + 1 : selectedAyah.juz - 1;
      juz2 = selectedAyah.juz + 2 < 31 ? selectedAyah.juz + 2 : selectedAyah.juz - 2;
      juz3 = selectedAyah.juz + 3 < 31 ? selectedAyah.juz + 3 : selectedAyah.juz - 3;
    }

    list.add(OptionBtnProps(juz: selectedAyah.juz, page: selectedAyah.page));
    list.add(OptionBtnProps(juz: juz1, page: page1));
    list.add(OptionBtnProps(juz: juz2, page: page2));
    list.add(OptionBtnProps(juz: juz3, page: page3));
    list.shuffle(); //resort randomly
    return list;
  }

  // Widget optionButton({required OptionBtnProps optionBtnProps}) {
  //   double blure = questionsCtr.isPressed.value ? 5 : 10;
  //   Offset distance = questionsCtr.isPressed.value ? Offset(1, 1) : Offset(2, 2);
  //   return Obx(() => InkWell(
  //         //  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //         borderRadius: BorderRadius.circular(10),
  //         onTap: questionsCtr.isPressed.value
  //             ? null
  //             : () {
  //                 bool currectAnswerIsTrue = false;
  //                 if (questionsCtr.questionType.value == QuestionType.ayahInJuzAndPage) {
  //                   if (optionBtnProps.juz == selectedAyah.juz && optionBtnProps.page == selectedAyah.page)
  //                     currectAnswerIsTrue = true;
  //                 } else if (questionsCtr.questionType.value == QuestionType.surahInJuz) if (optionBtnProps.juz ==
  //                     selectedAyah.juz) currectAnswerIsTrue = true;

  //                 if (currectAnswerIsTrue) {
  //                   optionBtnProps.color = MyColors.true_;
  //                   questionsCtr.increaseTrueAnswerCounter();
  //                 } else {
  //                   optionBtnProps.color = MyColors.false_;

  //                   questionsCtr.increaseWrongAnswerCounter();
  //                   findCurrectAnswer();
  //                 }
  //                 optionBtnProps.textColor = MyColors.white;
  //                 questionsCtr.isPressed.value = true;
  //               },
  //         child: AnimatedContainer(
  //           padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
  //           duration: Duration(milliseconds: 200),
  //           width: Get.size.width * .4,
  //           decoration: BoxDecoration(color: optionBtnProps.color, borderRadius: BorderRadius.circular(10), boxShadow: [
  //             BoxShadow(
  //               offset: -distance,
  //               color: MyColors.whiteBlack().withOpacity(.2),
  //               blurRadius: blure,
  //               inset: questionsCtr.isPressed.value,
  //             ),
  //             BoxShadow(
  //               offset: distance,
  //               color: Get.isDarkMode ? Color(0xff23262a) : Color(0xffa7a9af),
  //               blurRadius: blure,
  //               spreadRadius: 1,
  //               inset: questionsCtr.isPressed.value,
  //             ),
  //           ]),
  //           child: MyTexts.content(
  //             title: questionsCtr.questionType.value == QuestionType.ayahInJuzAndPage
  //                 ? '- الجزء: ${optionBtnProps.juz}\n- الصفحة: ${optionBtnProps.page}'
  //                 : '- الجزء: ${optionBtnProps.juz}',
  //           ),
  //         ),
  //       ));
  // }

  findCurrectAnswer() {
    for (OptionBtnProps optionBtnProps in questionBtnProps)
      if (optionBtnProps.juz == selectedAyah.juz && optionBtnProps.page == selectedAyah.page) {
        optionBtnProps.color = MyColors.true_;
        optionBtnProps.textColor = MyColors.white;
      }
  }
}

class OptionButton extends GetView<ThemeCtr> {
  OptionButton({super.key, required this.optionBtnProps, required this.selectedAyah, required this.questionBtnProps});
  OptionBtnProps optionBtnProps;
  final AyahProp selectedAyah;
  final List<OptionBtnProps> questionBtnProps;
  AyahsQuestionsCtr questionsCtr = Get.find<AyahsQuestionsCtr>();
  @override
  Widget build(BuildContext context) {
    context.theme;
    Offset distance = questionsCtr.isPressed.value ? Offset(1, 1) : Offset(2, 2);
    double blure = questionsCtr.isPressed.value ? 5 : 10;
    return Obx(() => InkWell(
          //  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          borderRadius: BorderRadius.circular(10),
          onTap: questionsCtr.isPressed.value
              ? null
              : () {
                  questionsCtr.isPressed.value = true;
                  optionBtnProps.isPressed = true;

                  bool currectAnswerIsTrue = false;
                  if (questionsCtr.questionType.value == QuestionType.ayahInJuzAndPage) {
                    if (optionBtnProps.juz == selectedAyah.juz && optionBtnProps.page == selectedAyah.page)
                      currectAnswerIsTrue = true;
                  } else if (questionsCtr.questionType.value == QuestionType.surahInJuz) if (optionBtnProps.juz ==
                      selectedAyah.juz) currectAnswerIsTrue = true;

                  if (currectAnswerIsTrue) {
                    optionBtnProps.color = MyColors.true_;
                    questionsCtr.increaseTrueAnswerCounter();
                  } else {
                    optionBtnProps.color = MyColors.false_;

                    questionsCtr.increaseWrongAnswerCounter();
                    findCurrectAnswer();
                  }
                },
          child: AnimatedContainer(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            duration: Duration(milliseconds: 200),
            width: Get.size.width * .4,
            decoration: BoxDecoration(
              color:
                  questionsCtr.isPressed.value && optionBtnProps.isPressed ? optionBtnProps.color : MyColors.zikrCard(),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: -distance,
                  color: MyColors.whiteBlack().withOpacity(.2),
                  blurRadius: blure,
                  inset: questionsCtr.isPressed.value,
                ),
                BoxShadow(
                  offset: distance,
                  color: Get.isDarkMode ? Color(0xff23262a) : Color(0xffa7a9af),
                  blurRadius: blure,
                  spreadRadius: 1,
                  inset: questionsCtr.isPressed.value,
                ),
              ],
            ),
            child: MyTexts.content(
              title: questionsCtr.questionType.value == QuestionType.ayahInJuzAndPage
                  ? '- الجزء: ${optionBtnProps.juz}\n- الصفحة: ${optionBtnProps.page}'
                  : '- الجزء: ${optionBtnProps.juz}',
            ),
          ),
        ));
  }

  findCurrectAnswer() {
    for (OptionBtnProps optionBtnProps in questionBtnProps)
      if (optionBtnProps.juz == selectedAyah.juz && optionBtnProps.page == selectedAyah.page) {
        optionBtnProps.color = MyColors.true_;
        optionBtnProps.textColor = MyColors.white;
      }
  }
}
