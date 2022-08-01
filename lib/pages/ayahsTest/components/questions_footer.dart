import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/pages/ayahsTest/enums/question_type.dart';
import '../../../services/theme_service.dart';
import '../../../constents/colors.dart';
import '../../../constents/icons.dart';
import '../../../constents/sizes.dart';
import '../../../constents/texts.dart';
import '../controller/first_ayahs_in_pages_ctr.dart';

class QuestionsFooter extends StatelessWidget {
  QuestionsFooter({Key? key, required this.pageSetState}) : super(key: key);
  VoidCallback pageSetState;
  final FirstAyahsInPagesCtr ctr = Get.find<FirstAyahsInPagesCtr>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(thickness: 1, endIndent: 50, indent: 50),
        questionInfoAndNextButton(context),
        selectSpesificJuzAndPage(context),
        answersInfo(context),
      ],
    );
  }

  Row questionInfoAndNextButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1000)),
          elevation: 5,
          color: ThemeService().getThemeMode() == ThemeMode.dark ? MyColors.zikrCard() : MyColors.background(),
          onPressed: () => getNextQuestion(),
          child: Row(
            children: [MyIcons.rightArrow(color: MyColors.primary()), MyTexts.normal(context, title: 'التالي')],
          ),
        ),
        MyTexts.normal(context, title: ' السؤال رقم ${ctr.quastionNumber.value}')
      ],
    );
  }

  Container answersInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: MySiezes.cardPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: MyColors.zikrCard(),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.6), blurRadius: 5, offset: Offset(0, 5)),
        ],
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            correctAndWrongAnswersLabels(context, isCorrect: true),
            correctAndWrongAnswersLabels(context, isCorrect: false),
          ],
        ),
      ),
    );
  }

  Row correctAndWrongAnswersLabels(BuildContext context, {required bool isCorrect}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: isCorrect ? MyIcons.done() : MyIcons.error),
        MyTexts.normal(
          context,
          title: isCorrect ? 'الاجابات الصحيحة:   ' : 'الاجابات الخاطئة:  ',
          color: isCorrect ? MyColors.true_ : MyColors.false_,
          size: 15,
        ),
        Material(
          borderRadius: BorderRadius.circular(100),
          elevation: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: MyTexts.normal(context,
                title: isCorrect ? '${ctr.trueAnswersCounter}' : '${ctr.wrongAnwersCounter}',
                color: isCorrect ? MyColors.true_ : MyColors.false_),
          ),
        )
      ],
    );
  }

  void getNextQuestion() {
    ctr.increaseQuestionCounter();
    pageSetState();
  }

  Widget selectSpesificJuzAndPage(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          selectDifferentTestType(context),
          selectFromOption(context),
          selectToOption(context),
        ],
      ),
    );
  }

  Row selectDifferentTestType(BuildContext context) {
    return Row(
      children: [
        MyTexts.dropDownMenuTitle(context, title: 'نوع الاختبار:  ',),
        DropdownButton<QuestionType>(
          value: ctr.questionType.value,
          iconEnabledColor: MyColors.primary(),
          onChanged: (QuestionType? val) {
            if (ctr.questionType.value != val) {
              ctr.changeQuestionType(val!);
              getNextQuestion();
            }
          },
          items: [
            DropdownMenuItem(
                value: QuestionType.ayahInJusAndPage, child: MyTexts.dropDownMenuItem(context, title: 'الايات')),
            DropdownMenuItem(value: QuestionType.surahInJus, child: MyTexts.dropDownMenuItem(context, title: 'السور')),
          ],
        ),
      ],
    );
  }

  Row selectToOption(BuildContext context) {
    return Row(
      children: [
        MyTexts.dropDownMenuTitle(
          context,
          title: ctr.questionType.value == QuestionType.ayahInJusAndPage ? 'الى الصفحة    ' : 'الى الجزء    ',
        ),
        DropdownButton<int>(
          items: List.generate(
            ctr.questionType.value == QuestionType.ayahInJusAndPage ? 21 - ctr.pageFrom.value : 31 - ctr.juzFrom.value,
            (index) => DropdownMenuItem(
                value: ctr.questionType.value == QuestionType.ayahInJusAndPage
                    ? ctr.pageFrom.value + index
                    : ctr.juzFrom.value + index,
                child: MyTexts.dropDownMenuItem(
                  context,
                  title: ctr.questionType.value == QuestionType.ayahInJusAndPage
                      ? '${ctr.pageFrom.value + index}'
                      : '${ctr.juzFrom.value + index}',
                )),
          ),
          value: ctr.questionType.value == QuestionType.ayahInJusAndPage ? ctr.pageTo.value : ctr.juzTo.value,
          onChanged: (val) {
            ctr.questionType.value == QuestionType.ayahInJusAndPage ? ctr.changePageTo(val!) : ctr.changeJuzTo(val!);
          },
          iconEnabledColor: MyColors.primary(),
        ),
      ],
    );
  }

  Row selectFromOption(BuildContext context) {
    return Row(
      children: [
        MyTexts.dropDownMenuTitle(context,
            title: ctr.questionType.value == QuestionType.ayahInJusAndPage ? 'من الصفحة    ' : 'من الجزء    '),
        DropdownButton<int>(
          items: List.generate(
            ctr.questionType.value == QuestionType.ayahInJusAndPage ? 20 : 30,
            (index) =>
                DropdownMenuItem(value: index + 1, child: MyTexts.dropDownMenuItem(context, title: '${index + 1}')),
          ),
          value: ctr.questionType.value == QuestionType.ayahInJusAndPage ? ctr.pageFrom.value : ctr.juzFrom.value,
          onChanged: (val) {
            ctr.questionType.value == QuestionType.ayahInJusAndPage
                ? ctr.changePageFrom(val!)
                : ctr.changeJuzFrom(val!);
          },
          iconEnabledColor: MyColors.primary(),
        ),
      ],
    );
  }
}
