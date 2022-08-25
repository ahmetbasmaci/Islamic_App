import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../moduls/enums.dart';

class FirstAyahsInPagesCtr extends GetxController {
  GetStorage getStorage = GetStorage();
  RxInt quastionNumber = 1.obs;
  RxInt trueAnswersCounter = 0.obs;
  RxInt wrongAnwersCounter = 0.obs;
  RxInt pageFrom = 1.obs;
  RxInt pageTo = 20.obs;
  RxInt juzFrom = 1.obs;
  RxInt juzTo = 30.obs;
  Rx<QuestionType> questionType = QuestionType.ayahInJuzAndPage.obs;
  int get getTrueAnwersCounter => trueAnswersCounter.value;
  FirstAyahsInPagesCtr() {
    int typeIndex = getStorage.read('questionType') ?? QuestionType.ayahInJuzAndPage.index;
    questionType.value = QuestionType.values[typeIndex];

    pageFrom.value = getStorage.read('pageFrom') ?? 1;
    pageTo.value = getStorage.read('pageTo') ?? 1;
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
}
