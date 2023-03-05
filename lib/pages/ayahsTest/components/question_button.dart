import 'dart:math';
import 'package:get/get.dart';
import 'package:zad_almumin/pages/quran/models/ayah.dart';
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

class QuestionAnswerOptions extends GetView<ThemeCtr> {
  QuestionAnswerOptions({Key? key, required this.selectedAyah}) : super(key: key);
  final Ayah selectedAyah;
  List<OptionBtnProps> questionBtnProps = [];
  AyahsQuestionsCtr ayahsQuestionsCtr = Get.find<AyahsQuestionsCtr>();

  @override
  Widget build(BuildContext context) {
    context.theme;
    questionBtnProps = getRandomJuzAndPages();
    return Column(
      children: <Widget>[
        const SizedBox(height: MySiezes.betweanCardItems * 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            MyTexts.outsideHeader(title: 'اختر الصفحة والجزء'),
            MyTexts.outsideHeader(title: ''),
            Obx(
              () => Align(
                alignment: Alignment.centerLeft,
                child: DropdownButton<AyahsAnswersType>(
                  value: ayahsQuestionsCtr.answersType.value,
                  onChanged: (val) => ayahsQuestionsCtr.changeAnswerType(val!),
                  iconEnabledColor: MyColors.primary(),
                  items: List.generate(
                    AyahsAnswersType.values.length,
                    (index) => DropdownMenuItem(
                        value: AyahsAnswersType.values.elementAt(index),
                        child: MyTexts.dropDownMenuItem(title: AyahsAnswersType.values.elementAt(index).arabicName)),
                  ),
                ),
              ),
            )
          ],
        ),
        Obx(
          () => ayahsQuestionsCtr.answersType.value == AyahsAnswersType.dropDownMenu
              ? dropDownAnswers()
              : buttonsAnswers(),
        ),
      ],
    );
  }

  Widget dropDownAnswers() {
    Offset distance = ayahsQuestionsCtr.isPressed.value ? Offset(1, 1) : Offset(2, 2);
    double blure = ayahsQuestionsCtr.isPressed.value ? 5 : 10;
    return Column(
      children: <Widget>[
        SizedBox(height: MySiezes.betweanCardItems),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            MyTexts.normal(title: "اختر جزء:"),
            AnimatedOpacity(
              opacity: ayahsQuestionsCtr.ayahsAnswerStates == AyahsAnswerStates.wrong ? 1 : 0,
              duration: Duration(milliseconds: 200),
              child: MyTexts.normal(
                title: ayahsQuestionsCtr.currectAnswerJuzDropDown.value.toString(),
                color: MyColors.true_,
                fontWeight: FontWeight.bold,
                size: 20,
              ),
            ),
            DropdownButton<int>(
              value: ayahsQuestionsCtr.answerJuzDropDown.value,
              onChanged: (val) => ayahsQuestionsCtr.answerJuzDropDown.value = val!,
              iconEnabledColor: MyColors.primary(),
              items: _getSelectJuzOptions(),
            )
          ],
        ),
        SizedBox(height: MySiezes.betweanCardItems),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            MyTexts.normal(title: "اختر الصفحة:"),
            AnimatedOpacity(
              opacity: ayahsQuestionsCtr.ayahsAnswerStates == AyahsAnswerStates.wrong ? 1 : 0,
              duration: Duration(milliseconds: 200),
              child: MyTexts.normal(
                title: ayahsQuestionsCtr.currectAnswerPageDropDown.value.toString(),
                color: MyColors.true_,
                fontWeight: FontWeight.bold,
                size: 20,
              ),
            ),
            DropdownButton<int>(
              value: ayahsQuestionsCtr.answerPageDropDown.value,
              onChanged: (val) => ayahsQuestionsCtr.answerPageDropDown.value = val!,
              iconEnabledColor: MyColors.primary(),
              items: _getSelectPageOptions(),
            )
          ],
        ),
        SizedBox(height: MySiezes.betweanCardItems * 2),
        Center(
          child: Obx(
            () => InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => ayahsQuestionsCtr.checkDropDownAnswer(selectedAyah),
              child: AnimatedContainer(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                duration: Duration(milliseconds: 200),
                width: Get.size.width * .4,
                decoration: BoxDecoration(
                  color: ayahsQuestionsCtr.isPressed.value ? ayahsQuestionsCtr.answerColor.value : MyColors.zikrCard(),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: -distance,
                      color: MyColors.whiteBlack().withOpacity(.2),
                      blurRadius: blure,
                      inset: ayahsQuestionsCtr.isPressed.value,
                    ),
                    BoxShadow(
                      offset: distance,
                      color: Get.isDarkMode ? Color(0xff23262a) : Color(0xffa7a9af),
                      blurRadius: blure,
                      spreadRadius: 1,
                      inset: ayahsQuestionsCtr.isPressed.value,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: MyTexts.normal(title: "تأكيد", color: MyColors.whiteBlack()),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buttonsAnswers() {
    return Column(
      children: <Widget>[
        SizedBox(height: MySiezes.betweanCardItems),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            OptionButton(
                optionBtnProps: questionBtnProps[0], questionBtnProps: questionBtnProps, selectedAyah: selectedAyah),
            OptionButton(
                optionBtnProps: questionBtnProps[1], questionBtnProps: questionBtnProps, selectedAyah: selectedAyah),
          ],
        ),
        SizedBox(height: MySiezes.betweanCardItems),
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

  List<DropdownMenuItem<int>> _getSelectPageOptions() {
    List<DropdownMenuItem<int>> result = [];
    for (var index = 0; index < (ayahsQuestionsCtr.pageTo.value - ayahsQuestionsCtr.pageFrom.value) + 1; index++) {
      result.add(DropdownMenuItem(
        value: index + ayahsQuestionsCtr.pageFrom.value,
        child: MyTexts.dropDownMenuItem(title: '${index + ayahsQuestionsCtr.pageFrom.value}'),
      ));
    }
    bool inRange = false;
    for (var element in result) {
      if (element.value == ayahsQuestionsCtr.answerPageDropDown.value) {
        inRange = true;
        break;
      }
    }
    if (!inRange) ayahsQuestionsCtr.answerPageDropDown.value = ayahsQuestionsCtr.pageFrom.value;
    return result;
  }

  List<DropdownMenuItem<int>> _getSelectJuzOptions() {
    List<DropdownMenuItem<int>> result = [];
    for (var index = 0; index < (ayahsQuestionsCtr.juzTo.value - ayahsQuestionsCtr.juzFrom.value) + 1; index++) {
      result.add(DropdownMenuItem(
        value: index + ayahsQuestionsCtr.juzFrom.value,
        child: MyTexts.dropDownMenuItem(title: '${index + ayahsQuestionsCtr.juzFrom.value}'),
      ));
    }
    return result;
  }
}

class OptionButton extends GetView<ThemeCtr> {
  OptionButton({super.key, required this.optionBtnProps, required this.selectedAyah, required this.questionBtnProps});
  OptionBtnProps optionBtnProps;
  final Ayah selectedAyah;
  final List<OptionBtnProps> questionBtnProps;
  AyahsQuestionsCtr ayahsQuestionsCtr = Get.find<AyahsQuestionsCtr>();
  @override
  Widget build(BuildContext context) {
    context.theme;
    Offset distance = ayahsQuestionsCtr.isPressed.value ? Offset(1, 1) : Offset(2, 2);
    double blure = ayahsQuestionsCtr.isPressed.value ? 5 : 10;
    return Obx(() => InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: answerBtnClick,
          child: AnimatedContainer(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            duration: Duration(milliseconds: 200),
            width: Get.size.width * .4,
            decoration: BoxDecoration(
              color: ayahsQuestionsCtr.isPressed.value ? optionBtnProps.color : MyColors.zikrCard(),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: -distance,
                  color: MyColors.whiteBlack().withOpacity(.2),
                  blurRadius: blure,
                  inset: ayahsQuestionsCtr.isPressed.value,
                ),
                BoxShadow(
                  offset: distance,
                  color: Get.isDarkMode ? Color(0xff23262a) : Color(0xffa7a9af),
                  blurRadius: blure,
                  spreadRadius: 1,
                  inset: ayahsQuestionsCtr.isPressed.value,
                ),
              ],
            ),
            child: MyTexts.content(
              title: ayahsQuestionsCtr.questionType.value == QuestionType.ayahInJuzAndPage
                  ? '- الجزء: ${optionBtnProps.juz}\n- الصفحة: ${optionBtnProps.page}'
                  : '- الجزء: ${optionBtnProps.juz}',
              color: optionBtnProps.textColor,
            ),
          ),
        ));
  }

  void answerBtnClick() {
    if (ayahsQuestionsCtr.isPressed.value) return;

    ayahsQuestionsCtr.isPressed.value = true;
    optionBtnProps.isPressed = true;

    bool currectAnswerIsTrue = false;
    if (ayahsQuestionsCtr.questionType.value == QuestionType.ayahInJuzAndPage)
      currectAnswerIsTrue = optionBtnProps.juz == selectedAyah.juz && optionBtnProps.page == selectedAyah.page;
    else if (ayahsQuestionsCtr.questionType.value == QuestionType.surahInJuz)
      currectAnswerIsTrue = optionBtnProps.juz == selectedAyah.juz;

    if (currectAnswerIsTrue) {
      optionBtnProps.color = MyColors.true_;
      optionBtnProps.textColor = MyColors.white;
      ayahsQuestionsCtr.increaseTrueAnswerCounter();
      ayahsQuestionsCtr.ayahsAnswerStates = AyahsAnswerStates.correct;
    } else {
      optionBtnProps.color = MyColors.false_;
      optionBtnProps.textColor = MyColors.white;
      ayahsQuestionsCtr.increaseWrongAnswerCounter();
      ayahsQuestionsCtr.ayahsAnswerStates = AyahsAnswerStates.wrong;
      findCurrectAnswer();
    }
  }

  findCurrectAnswer() {
    for (OptionBtnProps optionBtnProps in questionBtnProps)
      if (optionBtnProps.juz == selectedAyah.juz && optionBtnProps.page == selectedAyah.page) {
        optionBtnProps.color = MyColors.true_;
        optionBtnProps.textColor = MyColors.white;
        ayahsQuestionsCtr.currectAnswerJuzDropDown.value = selectedAyah.juz;
        ayahsQuestionsCtr.currectAnswerPageDropDown.value = selectedAyah.page;
      }
  }
}
