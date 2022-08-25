import 'package:get/get.dart';
import 'package:zad_almumin/services/theme_service.dart';
import 'package:zad_almumin/pages/ayahsTest/controller/first_ayahs_in_pages_ctr.dart';
import '../../../constents/sizes.dart';
import '../../../constents/texts.dart';
import '../../../constents/colors.dart';
import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import '../../../moduls/enums.dart';
import '../classes/ayah_prop.dart';
import '../classes/option_btn_props.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class QuestionButton extends StatefulWidget {
  const QuestionButton({Key? key, required this.selectedAyah, required this.questionBtnProps}) : super(key: key);
  final AyahProp selectedAyah;
  final List<OptionBtnProps> questionBtnProps;
  @override
  State<QuestionButton> createState() => _QuestionButtonState();
}

class _QuestionButtonState extends State<QuestionButton> {
  bool isPressed = false;
  FirstAyahsInPagesCtr ctr = Get.find<FirstAyahsInPagesCtr>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: MySiezes.betweanCardItems * 2),
        MyTexts.outsideHeader(context, title: 'اختر الصفحة والجزء'),
        const SizedBox(height: MySiezes.betweanCardItems),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            optionButton(optionBtnProps: widget.questionBtnProps[0]),
            optionButton(optionBtnProps: widget.questionBtnProps[1]),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            optionButton(optionBtnProps: widget.questionBtnProps[2]),
            optionButton(optionBtnProps: widget.questionBtnProps[3]),
          ],
        )
      ],
    );
  }

  Widget optionButton({required OptionBtnProps optionBtnProps}) {
    double blure = isPressed ? 5 : 30;
    Offset distance = isPressed ? Offset(1, 1) : Offset(2, 2);
    return InkWell(
      //  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      borderRadius: BorderRadius.circular(10),

      onTap: isPressed
          ? null
          : () {
              bool currectAnswerIsTrue = false;
              if (ctr.questionType.value == QuestionType.ayahInJuzAndPage) {
                if (optionBtnProps.juz == widget.selectedAyah.juz && optionBtnProps.page == widget.selectedAyah.page)
                  currectAnswerIsTrue = true;
              } else if (ctr.questionType.value == QuestionType.surahInJuz) if (optionBtnProps.juz ==
                  widget.selectedAyah.juz) currectAnswerIsTrue = true;

              if (currectAnswerIsTrue) {
                optionBtnProps.color = MyColors.true_;
                ctr.increaseTrueAnswerCounter();
              } else {
                optionBtnProps.color = MyColors.false_;

                ctr.increaseWrongAnswerCounter();
                findCurrectAnswer();
              }
              optionBtnProps.textColor = MyColors.white;
              isPressed = true;
              setState(() {});
            },
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        duration: Duration(milliseconds: 200),
        width: MediaQuery.of(context).size.width * .4,
        decoration: BoxDecoration(color: optionBtnProps.color, borderRadius: BorderRadius.circular(10), boxShadow: [
          BoxShadow(
            offset: -distance,
            color: MyColors.black.withOpacity(.2),
            blurRadius: blure,
            inset: isPressed,
          ),
          BoxShadow(
            offset: distance,
            color: ThemeService().getThemeMode() == ThemeMode.dark ? Color(0xff23262a) : Color(0xffa7a9af),
            blurRadius: blure,
            spreadRadius: 1,
            inset: isPressed,
          ),
        ]),
        child: Text(
          ctr.questionType.value == QuestionType.ayahInJuzAndPage
              ? '- الجزء: ${optionBtnProps.juz}\n- الصفحة: ${optionBtnProps.page}'
              : '- الجزء: ${optionBtnProps.juz}',
          style: TextStyle(color: optionBtnProps.textColor, fontSize: 16),
        ),
      ),
    );
  }

  findCurrectAnswer() {
    for (OptionBtnProps optionBtnProps in widget.questionBtnProps)
      if (optionBtnProps.juz == widget.selectedAyah.juz && optionBtnProps.page == widget.selectedAyah.page) {
        optionBtnProps.color = MyColors.true_;
        optionBtnProps.textColor = MyColors.white;
      }
  }
}
