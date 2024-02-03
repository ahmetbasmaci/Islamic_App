import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zad_almumin/core/utils/params/params.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../quran/quran.dart';
import '../../quran_questions.dart';

part 'quran_questions_state.dart';

class QuranQuestionsCubit extends Cubit<QuranQuestionsState> {
  final QuranQuestionGetRandomAyahUseCase quranQuestionGetRandomAyahUseCase;
  final QuranQuestionGetJuzToUseCase quranQuestionGetJuzToUseCase;
  final QuranQuestionSaveJuzToUseCase quranQuestionSaveJuzToUseCase;
  final QuranQuestionGetJuzFromUseCase quranQuestionGetJuzFromUseCase;
  final QuranQuestionSaveJuzFromUseCase quranQuestionSaveJuzFromUseCase;
  final QuranQuestionGetPageToUseCase quranQuestionGetPageToUseCase;
  final QuranQuestionSavePageToUseCase quranQuestionSavePageToUseCase;
  final QuranQuestionGetPageFromUseCase quranQuestionGetPageFromUseCase;
  final QuranQuestionSavePageFromUseCase quranQuestionSavePageFromUseCase;
  final QuranQuestionGetAnswerTypeUseCase quranQuestionGetAnswerTypeUseCase;
  final QuranQuestionSaveAnswerTypeUseCase quranQuestionSaveAnswerTypeUseCase;
  final QuranQuestionSaveQuestionTypeUseCase quranQuestionSaveQuestionTypeUseCase;
  final QuranQuestionGetQuestionTypeUseCase quranQuestionGetQuestionTypeUseCase;
  late List<QuranQuestionBottonModel> quranQuestionButtonModels;

  QuranQuestionsCubit({
    required this.quranQuestionGetRandomAyahUseCase,
    required this.quranQuestionGetJuzToUseCase,
    required this.quranQuestionSaveJuzToUseCase,
    required this.quranQuestionGetJuzFromUseCase,
    required this.quranQuestionSaveJuzFromUseCase,
    required this.quranQuestionGetPageToUseCase,
    required this.quranQuestionSavePageToUseCase,
    required this.quranQuestionGetPageFromUseCase,
    required this.quranQuestionSavePageFromUseCase,
    required this.quranQuestionGetAnswerTypeUseCase,
    required this.quranQuestionSaveAnswerTypeUseCase,
    required this.quranQuestionSaveQuestionTypeUseCase,
    required this.quranQuestionGetQuestionTypeUseCase,
  }) : super(QuranQuestionsState.init()) {
    updateAyah();
  }

  void changePageFrom(int newVal) async {
    int newPageTp = state.pageTo;
    if (newPageTp <= newVal) {
      newPageTp = newVal + 1;
      if (newPageTp > 20) {
        newPageTp = 20;
        newVal = newPageTp - 1;
      }
    }

    var result = await quranQuestionSavePageFromUseCase(PageFromParams(pageFrom: newVal));
    result.fold(
      (l) => null,
      (r) {
        emit(
          state.copyWith(
            pageFrom: newVal,
            pageTo: newPageTp,
          ),
        );
      },
    );
  }

  void changeJuzFrom(int newVal) async {
    int newJuzTo = state.juzTo;
    if (newJuzTo < newVal) {
      newJuzTo = newVal;
      if (newJuzTo > 30) {
        newJuzTo = 30;
        newVal = newJuzTo;
      }
    }
    var result = await quranQuestionSaveJuzFromUseCase(JuzFromParams(juzFrom: newVal));
    result.fold(
      (l) => null,
      (r) {
        emit(
          state.copyWith(
            juzFrom: newVal,
            juzTo: newJuzTo,
          ),
        );
      },
    );
  }

  void changePageTo(int newVal) async {
    var result = await quranQuestionSavePageToUseCase(PageToParams(pageTo: newVal));
    result.fold(
      (l) => null,
      (r) {
        emit(state.copyWith(pageTo: newVal));
      },
    );
  }

  void changeJuzTo(int newVal) async {
    var result = await quranQuestionSaveJuzToUseCase(JuzToParams(juzTo: newVal));
    result.fold(
      (l) => null,
      (r) {
        emit(state.copyWith(juzTo: newVal));
      },
    );
  }

  void changeAnswerType(AyahsAnswersType newVal) async {
    var result = quranQuestionSaveAnswerTypeUseCase(AnswerTypeParams(answerType: newVal));
    result.then((value) {
      if (value.isRight()) {
        emit(state.copyWith(answersType: newVal));
      }
    });
  }

  void changeQuestionType(QuestionType newVal) {
    var result = quranQuestionSaveQuestionTypeUseCase(QuestionTypeParams(questionType: newVal));
    result.then((value) {
      if (value.isRight()) {
        emit(state.copyWith(questionType: newVal));
      }
    });
  }

  void updateSelectedDropDownAnswerJuz(int newVal) {
    emit(state.copyWith(selectedDropDownAnswerJuz: newVal));
  }

  void updateSelectedDropDownAnswerPage(int newVal) {
    emit(state.copyWith(selectedDropDownAnswerPage: newVal));
  }

  void updateAyah() {
    Ayah ayah = getRandomPageStartAyah;

    emit(
      state.copyWith(
        successQuestionAyah: ayah,
        isPressed: false,
        ayahsAnswerStates: AyahsAnswerStates.none,
      ),
    );
  }

  Ayah get getRandomPageStartAyah {
    late Ayah newAyah;
    var result = quranQuestionGetRandomAyahUseCase(GetRandomStartAyahParams(
      juzFrom: state.juzFrom,
      juzTo: state.juzTo,
      pageFrom: state.pageFrom,
      pageTo: state.pageTo,
    ));
    result.fold(
      (failure) {
        emit(state.copyWith(errorMessage: failure.toString()));
        newAyah = Ayah.empty();
      },
      (ayah) {
        newAyah = ayah;
      },
    );

    quranQuestionButtonModels = getRandomJuzAndPages(newAyah);
    return newAyah;
  }

  void getNextQuestion() {
    int questionNumber = increaseQuestionCounter();
    Ayah newAyah = getRandomPageStartAyah;
    emit(
      state.copyWith(
        isPressed: false,
        ayahsAnswerStates: AyahsAnswerStates.none,
        quastionNumber: questionNumber,
        successQuestionAyah: newAyah,
      ),
    );
  }

  List<QuranQuestionBottonModel> getRandomJuzAndPages(Ayah newAyah) {
    List<QuranQuestionBottonModel> list = [];
    int juz1 = 0;
    int page1 = 0;
    int juz2 = 0;
    int page2 = 0;
    int juz3 = 0;
    int page3 = 0;

    //check if page1 is not the same as page2 and in arrange betwean 1 and 20
    int random = Random().nextInt(3);
    if (random == 0) {
      page1 = newAyah.page - 1 > 0 ? newAyah.page - 1 : newAyah.page + 1;
      page2 = newAyah.page - 2 > 0 ? newAyah.page - 2 : newAyah.page + 2;
      page3 = newAyah.page - 3 > 0 ? newAyah.page - 3 : newAyah.page + 3;

      juz1 = newAyah.juz - 1 > 0 ? newAyah.juz - 1 : newAyah.juz + 1;
      juz2 = newAyah.juz - 2 > 0 ? newAyah.juz - 2 : newAyah.juz + 2;
      juz3 = newAyah.juz - 3 > 0 ? newAyah.juz - 3 : newAyah.juz + 3;
    } else if (random == 1) {
      page1 = newAyah.page - 1 > 0 ? newAyah.page - 1 : newAyah.page + 2;
      page2 = newAyah.page - 2 > 0 ? newAyah.page - 2 : newAyah.page + 3;
      page3 = newAyah.page + 1 < 21 ? newAyah.page + 1 : newAyah.page - 3;

      juz1 = newAyah.juz - 1 > 0 ? newAyah.juz - 1 : newAyah.juz + 2;
      juz2 = newAyah.juz - 2 > 0 ? newAyah.juz - 2 : newAyah.juz + 3;
      juz3 = newAyah.juz + 1 < 31 ? newAyah.juz + 1 : newAyah.juz - 3;
    } else if (random == 2) {
      page1 = newAyah.page - 1 > 0 ? newAyah.page - 2 : newAyah.page + 3;
      page2 = newAyah.page + 1 < 21 ? newAyah.page + 1 : newAyah.page - 1;
      page3 = newAyah.page + 2 < 21 ? newAyah.page + 2 : newAyah.page - 2;

      juz1 = newAyah.juz - 1 > 0 ? newAyah.juz - 2 : newAyah.juz + 3;
      juz2 = newAyah.juz + 1 < 31 ? newAyah.juz + 1 : newAyah.juz - 1;
      juz3 = newAyah.juz + 2 < 31 ? newAyah.juz + 2 : newAyah.juz - 2;
    } else if (random == 3) {
      page1 = newAyah.page + 1 < 21 ? newAyah.page + 1 : newAyah.page - 1;
      page2 = newAyah.page + 2 < 21 ? newAyah.page + 2 : newAyah.page - 2;
      page3 = newAyah.page + 3 < 21 ? newAyah.page + 3 : newAyah.page - 3;

      juz1 = newAyah.juz + 1 < 31 ? newAyah.juz + 1 : newAyah.juz - 1;
      juz2 = newAyah.juz + 2 < 31 ? newAyah.juz + 2 : newAyah.juz - 2;
      juz3 = newAyah.juz + 3 < 31 ? newAyah.juz + 3 : newAyah.juz - 3;
    }

    list.add(QuranQuestionDefaultBottonModel(juz: newAyah.juz, page: newAyah.page));
    list.add(QuranQuestionDefaultBottonModel(juz: juz1, page: page1));
    list.add(QuranQuestionDefaultBottonModel(juz: juz2, page: page2));
    list.add(QuranQuestionDefaultBottonModel(juz: juz3, page: page3));
    list.shuffle(); //resort randomly
    return list;
  }

  void buttonAnswerPressed(QuranQuestionBottonModel quranQuestionButtonModel) {
    if (state.isPressed) return;

    quranQuestionButtonModel.isPressed = true;

    bool isAnswerCorrect = _checkAnswer(quranQuestionButtonModel.juz, quranQuestionButtonModel.page);

    updateQuestionButtonType(quranQuestionButtonModel, isAnswerCorrect);

    int trueAnswersCounter = state.trueAnswersCounter;
    int wrongAnwersCounter = state.wrongAnwersCounter;

    if (isAnswerCorrect) {
      trueAnswersCounter = increaseTrueAnswerCounter();
    } else {
      wrongAnwersCounter = increaseWrongAnswerCounter();
      findCurrectAnswer();
    }
    emit(
      state.copyWith(
        isPressed: true,
        ayahsAnswerStates: isAnswerCorrect ? AyahsAnswerStates.currect : AyahsAnswerStates.wrong,
        trueAnswersCounter: trueAnswersCounter,
        wrongAnwersCounter: wrongAnwersCounter,
      ),
    );
  }

  void dropDownAnswerPressed() {
    if (state.isPressed) return;

    bool isAnswerCorrect = _checkAnswer(state.selectedDropDownAnswerJuz, state.selectedDropDownAnswerPage);

    int trueAnswersCounter = state.trueAnswersCounter;
    int wrongAnwersCounter = state.wrongAnwersCounter;
    if (isAnswerCorrect) {
      trueAnswersCounter = increaseTrueAnswerCounter();
    } else {
      wrongAnwersCounter = increaseWrongAnswerCounter();
      findCurrectAnswer();
    }
    emit(
      state.copyWith(
        isPressed: true,
        ayahsAnswerStates: isAnswerCorrect ? AyahsAnswerStates.currect : AyahsAnswerStates.wrong,
        trueAnswersCounter: trueAnswersCounter,
        wrongAnwersCounter: wrongAnwersCounter,
      ),
    );

    emit(state.copyWith(isPressed: true));
  }

  bool _checkAnswer(int juz, int page) {
    bool answerIsTrue = false;

    bool isJuzMatched = juz == state.successQuestionAyah.juz;

    if (state.questionType == QuestionType.ayahInJuzAndPage) {
      bool isPageMatched = page == state.successQuestionAyah.page;
      answerIsTrue = isJuzMatched && isPageMatched;
    } else if (state.questionType == QuestionType.surahInJuz) {
      answerIsTrue = isJuzMatched;
    }
    return answerIsTrue;
  }

  void findCurrectAnswer() {
    for (var element in quranQuestionButtonModels) {
      if (_checkAnswer(element.juz, element.page)) {
        updateQuestionButtonType(element, true);
      }
    }
  }

  void updateQuestionButtonType(QuranQuestionBottonModel quranQuestionButtonModel, bool isCurrect) {
    int index = quranQuestionButtonModels.lastIndexOf(quranQuestionButtonModel);
    quranQuestionButtonModels.remove(quranQuestionButtonModel);
    if (isCurrect) {
      quranQuestionButtonModels.insert(
        index,
        QuranQuestionCurrectBottonModel(juz: quranQuestionButtonModel.juz, page: quranQuestionButtonModel.page),
      );
    } else {
      quranQuestionButtonModels.insert(
        index,
        QuranQuestionWrongBottonModel(juz: quranQuestionButtonModel.juz, page: quranQuestionButtonModel.page),
      );
    }
  }

  int increaseTrueAnswerCounter() {
    int currectCounter = state.trueAnswersCounter + 1;
    return currectCounter;
  }

  int increaseWrongAnswerCounter() {
    int wrongCounter = state.wrongAnwersCounter + 1;
    return wrongCounter;
  }

  int increaseQuestionCounter() {
    return state.quastionNumber + 1;
  }
}
