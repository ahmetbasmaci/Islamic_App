import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../moduls/enums.dart';
import '../../../services/theme_service.dart';
import '../../../constents/my_colors.dart';
import '../../../constents/my_icons.dart';
import '../../../constents/my_sizes.dart';
import '../../../constents/my_texts.dart';
import '../controller/ayahs_questions_ctr.dart';

class QuestionsFooter extends GetView<ThemeCtr> {
  QuestionsFooter({Key? key, required this.pageSetState}) : super(key: key);
  final VoidCallback pageSetState;
  final AyahsQuestionsCtr ayahsQuestionsCtr = Get.find<AyahsQuestionsCtr>();

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Column(
      children: <Widget>[
        Divider(thickness: 1, endIndent: 50, indent: 50),
        SizedBox(height: Get.height * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            questionInfoAndNextButton(),
            boottomSheetHandleButton(),
          ],
        ),
        SizedBox(height: Get.height * 0.02),
        answersInfo(),
      ],
    );
  }

  Widget boottomSheetHandleButton() {
    bool isBottomSheetActive = false;
    return StatefulBuilder(builder: ((context, iconSetState) {
      return Container(
        width: 120,
        decoration: BoxDecoration(
          color: MyColors.primary(),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: MyColors.primary(),
              blurRadius: 100,
              spreadRadius: .1,
            )
          ],
        ),
        child: MaterialButton(
          onPressed: () {
            getBottomSheet(context, isBottomSheetActive);
            isBottomSheetActive = !isBottomSheetActive;
            iconSetState(() {});
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTexts.normal(title: ' خيارات ', color: MyColors.white),
              MyIcons.optinos(color: MyColors.white),
            ],
          ),
        ),
      );
    }));
  }

  getBottomSheet(BuildContext context, bool isBottomSheetActive) {
    Get.bottomSheet(Stack(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: MyColors.background(),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: MyColors.shadow(),
                blurRadius: 10,
                spreadRadius: 5,
              )
            ],
          ),
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [selectDifferentTestType()],
                ),

                ayahsQuestionsCtr.questionType.value == QuestionType.ayahInJuzAndPage
                    ? selectSpecificJuz(context)
                    : Container(),
                selectSpecificPage(),
                //  answersInfo(),
              ],
            ),
          ),
        ),
        // Positioned(
        //   left: 10,
        //   top: 10,
        //   child: Container(
        //     padding: EdgeInsets.all(2),
        //     decoration:
        //         BoxDecoration(color: MyColors.background(), borderRadius: BorderRadius.circular(100), boxShadow: [
        //       BoxShadow(
        //         color: MyColors.primary().withOpacity(.2),
        //         blurRadius: 10,
        //         spreadRadius: 5,
        //       )
        //     ]),
        //     child: IconButton(
        //       onPressed: () => Navigator.pop(context),
        //       icon: const Icon(Icons.keyboard_arrow_down),
        //     ),
        //   ),
        // ),
      ],
    ));
  }

  Row questionInfoAndNextButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1000)),
          elevation: 5,
          color: MyColors.zikrCard(),
          onPressed: () => getNextQuestion(),
          child: Row(
            children: [
              MyIcons.rightArrow(color: MyColors.primary()),
              MyTexts.normal(title: 'التالي', color: MyColors.whiteBlack())
            ],
          ),
        ),
        //MyTexts.normal(title: ' السؤال رقم ${ayahsQuestionsCtr.quastionNumber.value}', color: MyColors.whiteBlack())
      ],
    );
  }

  Widget answersInfo() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          correctAndWrongAnswersLabels(isCorrect: true),
          //Expanded(child: Container()),
          correctAndWrongAnswersLabels(isCorrect: false),
        ],
      ),
    );
  }

  void getNextQuestion() {
    ayahsQuestionsCtr.increaseQuestionCounter();
    ayahsQuestionsCtr.isPressed.value = false;
    ayahsQuestionsCtr.ayahsAnswerStates = AyahsAnswerStates.correct;
    pageSetState();
  }

  Row selectDifferentTestType() {
    return Row(
      children: [
        MyTexts.dropDownMenuTitle(title: 'نوع الاختبار:  '),
        DropdownButton<QuestionType>(
          value: ayahsQuestionsCtr.questionType.value,
          iconEnabledColor: MyColors.primary(),
          onChanged: (QuestionType? val) {
            if (ayahsQuestionsCtr.questionType.value != val) {
              ayahsQuestionsCtr.changeQuestionType(val!);
              getNextQuestion();
            }
          },
          items: [
            DropdownMenuItem(value: QuestionType.ayahInJuzAndPage, child: MyTexts.dropDownMenuItem(title: 'الايات')),
            DropdownMenuItem(value: QuestionType.surahInJuz, child: MyTexts.dropDownMenuItem(title: 'السور')),
          ],
        ),
      ],
    );
  }

  Widget selectSpecificPage() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          selectFromOption(true),
          selectToOption(true),
        ],
      ),
    );
  }

  Widget selectSpecificJuz(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          selectFromOption(false),
          selectToOption(false),
        ],
      ),
    );
  }

  Row selectFromOption(bool isPage) {
    return Row(
      children: [
        MyTexts.dropDownMenuTitle(title: isPage ? 'من الصفحة    ' : 'من الجزء    '),
        DropdownButton<int>(
          items: List.generate(
            isPage ? 20 : 30,
            (index) => DropdownMenuItem(value: index + 1, child: MyTexts.dropDownMenuItem(title: '${index + 1}')),
          ),
          value: isPage ? ayahsQuestionsCtr.pageFrom.value : ayahsQuestionsCtr.juzFrom.value,
          iconEnabledColor: MyColors.primary(),
          onChanged: (val) {
            if (isPage) {
              ayahsQuestionsCtr.changePageFrom(val!);
              if (ayahsQuestionsCtr.answerPageDropDown.value < ayahsQuestionsCtr.pageFrom.value)
                ayahsQuestionsCtr.answerPageDropDown.value = ayahsQuestionsCtr.pageFrom.value;
            } else {
              ayahsQuestionsCtr.changeJuzFrom(val!);
              if (ayahsQuestionsCtr.answerJuzDropDown.value < ayahsQuestionsCtr.juzFrom.value)
                ayahsQuestionsCtr.answerJuzDropDown.value = ayahsQuestionsCtr.juzFrom.value;
            }
          },
        ),
      ],
    );
  }

  Row selectToOption(bool isPage) {
    return Row(
      children: [
        MyTexts.dropDownMenuTitle(title: isPage ? 'الى الصفحة    ' : 'الى الجزء    '),
        DropdownButton<int>(
          value: isPage ? ayahsQuestionsCtr.pageTo.value : ayahsQuestionsCtr.juzTo.value,
          iconEnabledColor: MyColors.primary(),
          onChanged: (val) {
            if (isPage) {
              ayahsQuestionsCtr.changePageTo(val!);
              if (ayahsQuestionsCtr.answerPageDropDown.value > ayahsQuestionsCtr.pageTo.value)
                ayahsQuestionsCtr.answerPageDropDown.value = ayahsQuestionsCtr.pageTo.value;
            } else {
              ayahsQuestionsCtr.changeJuzTo(val!);
              if (ayahsQuestionsCtr.answerJuzDropDown.value > ayahsQuestionsCtr.juzTo.value)
                ayahsQuestionsCtr.answerJuzDropDown.value = ayahsQuestionsCtr.juzTo.value;
            }
          },
          items: List.generate(
            isPage ? 21 - ayahsQuestionsCtr.pageFrom.value : 31 - ayahsQuestionsCtr.juzFrom.value,
            (index) => DropdownMenuItem(
              value: isPage ? ayahsQuestionsCtr.pageFrom.value + index : ayahsQuestionsCtr.juzFrom.value + index,
              child: MyTexts.dropDownMenuItem(
                  title: isPage
                      ? '${ayahsQuestionsCtr.pageFrom.value + index}'
                      : '${ayahsQuestionsCtr.juzFrom.value + index}'),
            ),
          ),
        ),
      ],
    );
  }

  Widget correctAndWrongAnswersLabels({required bool isCorrect}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: const EdgeInsets.all(MySiezes.cardPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: MyColors.background(),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.2), blurRadius: 1, offset: Offset(0, 10)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: isCorrect ? MyIcons.done() : MyIcons.error),
          MyTexts.normal(
            title: isCorrect ? 'الاجابات الصحيحة:   ' : 'الاجابات الخاطئة:  ',
            color: isCorrect ? MyColors.true_ : MyColors.false_,
            size: 13,
          ),
          Material(
            borderRadius: BorderRadius.circular(100),
            elevation: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: MyTexts.normal(
                  title:
                      isCorrect ? '${ayahsQuestionsCtr.trueAnswersCounter}' : '${ayahsQuestionsCtr.wrongAnwersCounter}',
                  color: isCorrect ? MyColors.true_ : MyColors.false_),
            ),
          )
        ],
      ),
    );
  }
}
