import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../moduls/enums.dart';
import '../../../services/theme_service.dart';
import '../../../constents/colors.dart';
import '../../../constents/icons.dart';
import '../../../constents/sizes.dart';
import '../../../constents/texts.dart';
import '../controller/first_ayahs_in_pages_ctr.dart';

class QuestionsFooter extends StatelessWidget {
  QuestionsFooter({Key? key, required this.pageSetState}) : super(key: key);
  final VoidCallback pageSetState;
  final FirstAyahsInPagesCtr ctr = Get.find<FirstAyahsInPagesCtr>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(thickness: 1, endIndent: 50, indent: 50),
        questionInfoAndNextButton(),
        boodumSheetHandleButton(),
      ],
    );
  }

  Widget boodumSheetHandleButton() {
    bool isBottomSheetActive = false;
    return StatefulBuilder(builder: ((context, iconSetState) {
      return SizedBox(
        width: 120,
        child: MaterialButton(
          onPressed: () {
            getBottomSheet(context, isBottomSheetActive);
            isBottomSheetActive = !isBottomSheetActive;
            iconSetState(() {});
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.keyboard_arrow_up),
              MyTexts.normal( title: ' خيارات '),
              Icon(Icons.keyboard_arrow_up),
            ],
          ),
        ),
      );
    }));
  }

  getBottomSheet(BuildContext context, bool isBottomSheetActive) {
    showBottomSheet(
        context: context,
        builder: ((context) {
          return Stack(
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
                        children: [
                          selectDifferentTestType(),
                        ],
                      ),
                      selectSpecificPage(),
                      ctr.questionType.value == QuestionType.ayahInJuzAndPage
                          ? selectSpecificJuz(context)
                          : Container(),
                      answersInfo(),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 10,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration:
                      BoxDecoration(color: MyColors.background(), borderRadius: BorderRadius.circular(100), boxShadow: [
                    BoxShadow(
                      color: MyColors.primary().withOpacity(.2),
                      blurRadius: 10,
                      spreadRadius: 5,
                    )
                  ]),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.keyboard_arrow_down),
                  ),
                ),
              ),
            ],
          );
        }));
  }

  Row questionInfoAndNextButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1000)),
          elevation: 5,
          color: ThemeService().getThemeMode() == ThemeMode.dark ? MyColors.zikrCard() : MyColors.background(),
          onPressed: () => getNextQuestion(),
          child: Row(
            children: [MyIcons.rightArrow(color: MyColors.primary()), MyTexts.normal(title: 'التالي')],
          ),
        ),
        MyTexts.normal(title: ' السؤال رقم ${ctr.quastionNumber.value}')
      ],
    );
  }

  Widget answersInfo() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          correctAndWrongAnswersLabels( isCorrect: true),
          Expanded(child: Container()),
          correctAndWrongAnswersLabels(isCorrect: false),
        ],
      ),
    );
  }

  void getNextQuestion() {
    ctr.increaseQuestionCounter();
    pageSetState();
  }

  Row selectDifferentTestType() {
    return Row(
      children: [
        MyTexts.dropDownMenuTitle(
        
          title: 'نوع الاختبار:  ',
        ),
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
                value: QuestionType.ayahInJuzAndPage, child: MyTexts.dropDownMenuItem( title: 'الايات')),
            DropdownMenuItem(value: QuestionType.surahInJuz, child: MyTexts.dropDownMenuItem( title: 'السور')),
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
          selectFromOption( true),
          selectToOption( true),
        ],
      ),
    );
  }

  Widget selectSpecificJuz(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          selectFromOption( false),
          selectToOption(false),
        ],
      ),
    );
  }

  Row selectFromOption(bool isPage) {
    return Row(
      children: [
        MyTexts.dropDownMenuTitle( title: isPage ? 'من الصفحة    ' : 'من الجزء    '),
        DropdownButton<int>(
          items: List.generate(
            isPage ? 20 : 30,
            (index) =>
                DropdownMenuItem(value: index + 1, child: MyTexts.dropDownMenuItem( title: '${index + 1}')),
          ),
          value: isPage ? ctr.pageFrom.value : ctr.juzFrom.value,
          onChanged: (val) {
            isPage ? ctr.changePageFrom(val!) : ctr.changeJuzFrom(val!);
          },
          iconEnabledColor: MyColors.primary(),
        ),
      ],
    );
  }

  Row selectToOption( bool isPage) {
    return Row(
      children: [
        MyTexts.dropDownMenuTitle(
        
          title: isPage ? 'الى الصفحة    ' : 'الى الجزء    ',
        ),
        DropdownButton<int>(
          items: List.generate(
            isPage ? 21 - ctr.pageFrom.value : 31 - ctr.juzFrom.value,
            (index) => DropdownMenuItem(
                value: isPage ? ctr.pageFrom.value + index : ctr.juzFrom.value + index,
                child: MyTexts.dropDownMenuItem(
                
                  title: isPage ? '${ctr.pageFrom.value + index}' : '${ctr.juzFrom.value + index}',
                )),
          ),
          value: isPage ? ctr.pageTo.value : ctr.juzTo.value,
          onChanged: (val) {
            isPage ? ctr.changePageTo(val!) : ctr.changeJuzTo(val!);
          },
          iconEnabledColor: MyColors.primary(),
        ),
      ],
    );
  }

  Widget correctAndWrongAnswersLabels({required bool isCorrect}) {
    return Expanded(
      flex: 6,
      child: AnimatedContainer(
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
              size: 10,
            ),
            Material(
              borderRadius: BorderRadius.circular(100),
              elevation: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: MyTexts.normal(
                    title: isCorrect ? '${ctr.trueAnswersCounter}' : '${ctr.wrongAnwersCounter}',
                    color: isCorrect ? MyColors.true_ : MyColors.false_),
              ),
            )
          ],
        ),
      ),
    );
  }
}
