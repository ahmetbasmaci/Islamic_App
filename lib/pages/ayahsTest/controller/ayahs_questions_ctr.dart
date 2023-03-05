import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/constents/colors.dart';
import 'package:zad_almumin/pages/ayahsTest/classes/ayah_prop.dart';
import 'package:zad_almumin/pages/quran/models/ayah.dart';

import '../../../moduls/enums.dart';

class AyahsQuestionsCtr extends GetxController {
  GetStorage getStorage = GetStorage();
  RxBool isPressed = false.obs;
  Rx<Color> answerColor = MyColors.false_.obs;
  RxInt quastionNumber = 1.obs;
  RxInt trueAnswersCounter = 0.obs;
  RxInt wrongAnwersCounter = 0.obs;
  RxInt pageFrom = 1.obs;
  RxInt pageTo = 20.obs;
  RxInt juzFrom = 1.obs;
  RxInt juzTo = 30.obs;
  RxInt answerJuzDropDown = 1.obs;
  RxInt answerPageDropDown = 1.obs;
  RxInt currectAnswerJuzDropDown = 1.obs;
  RxInt currectAnswerPageDropDown = 1.obs;
  Rx<QuestionType> questionType = QuestionType.ayahInJuzAndPage.obs;
  Rx<AyahsAnswersType> answersType = AyahsAnswersType.dropDownMenu.obs;
  AyahsAnswerStates ayahsAnswerStates = AyahsAnswerStates.none;
  int get getTrueAnwersCounter => trueAnswersCounter.value;

  AyahsQuestionsCtr() {
    int questiontypeIndex = getStorage.read('questionType') ?? QuestionType.ayahInJuzAndPage.index;
    questionType.value = QuestionType.values[questiontypeIndex];

    int answertypeIndex = getStorage.read('answersType') ?? QuestionType.ayahInJuzAndPage.index;
    answersType.value = AyahsAnswersType.values[answertypeIndex];

    pageFrom.value = getStorage.read('pageFrom') ?? 1;
    pageTo.value = getStorage.read('pageTo') ?? 20;
    juzFrom.value = getStorage.read('juzFrom') ?? 1;
    juzTo.value = getStorage.read('juzTo') ?? 30;
  }
  increaseQuestionCounter() {
    quastionNumber.value++;
  }

  increaseTrueAnswerCounter() {
    trueAnswersCounter.value++;
  }

  increaseWrongAnswerCounter() {
    wrongAnwersCounter.value++;
  }

  changePageFrom(int newPage) {
    if (pageTo < newPage) changePageTo(newPage);
    pageFrom.value = newPage;
    getStorage.write('pageFrom', pageFrom.value);
  }

  changePageTo(int newPage) {
    pageTo.value = newPage;
    getStorage.write('pageTo', pageTo.value);
  }

  changeJuzFrom(int newPage) {
    if (juzTo < newPage) juzTo.value = newPage;
    juzFrom.value = newPage;
    getStorage.write('juzFrom', juzFrom.value);
  }

  changeJuzTo(int newPage) {
    juzTo.value = newPage;
    getStorage.write('juzTo', juzTo.value);
  }

  changeQuestionType(QuestionType newType) {
    questionType.value = newType;
    getStorage.write('questionType', newType.index);
  }

  changeAnswerType(AyahsAnswersType newType) {
    answersType.value = newType;
    getStorage.write('answersType', newType.index);
  }

  checkDropDownAnswer(Ayah ayah) {
    isPressed.value = true;
    if (answerJuzDropDown.value == ayah.juz && answerPageDropDown.value == ayah.page) {
      increaseTrueAnswerCounter();
      answerColor.value = MyColors.true_;
      ayahsAnswerStates = AyahsAnswerStates.correct;
    } else {
      increaseWrongAnswerCounter();
      currectAnswerJuzDropDown.value = ayah.juz;
      currectAnswerPageDropDown.value = ayah.page;
      answerColor.value = MyColors.false_;
      ayahsAnswerStates = AyahsAnswerStates.wrong;
    }
  }
}
