part of 'quran_questions_cubit.dart';

class QuranQuestionsState extends Equatable {
  final QuestionType questionType;
  final AyahsAnswersType answersType;
  final AyahsAnswerStates ayahsAnswerStates;
  final Ayah successQuestionAyah;
  final String errorMessage;
  final bool isLoading;
  final bool isPressed;
  final int quastionNumber;
  final int trueAnswersCounter;
  final int wrongAnwersCounter;
  final int selectedDropDownAnswerPage;
  final int selectedDropDownAnswerJuz;
  final int pageFrom;
  final int pageTo;
  final int juzFrom;
  final int juzTo;
  const QuranQuestionsState({
    required this.questionType,
    required this.answersType,
    required this.ayahsAnswerStates,
    required this.successQuestionAyah,
    required this.errorMessage,
    required this.isLoading,
    required this.isPressed,
    required this.quastionNumber,
    required this.trueAnswersCounter,
    required this.wrongAnwersCounter,
    required this.selectedDropDownAnswerPage,
    required this.selectedDropDownAnswerJuz,
    required this.pageFrom,
    required this.pageTo,
    required this.juzFrom,
    required this.juzTo,
  });

  QuranQuestionsState.init()
      : questionType = QuestionType.ayahInJuzAndPage,
        answersType = AyahsAnswersType.buttons,
        ayahsAnswerStates = AyahsAnswerStates.none,
        successQuestionAyah = Ayah.empty(),
        errorMessage = '',
        isLoading = false,
        isPressed = false,
        quastionNumber = 1,
        trueAnswersCounter = 0,
        wrongAnwersCounter = 0,
        selectedDropDownAnswerPage = 1,
        selectedDropDownAnswerJuz = 1,
        pageFrom = 1,
        pageTo = 20,
        juzFrom = 1,
        juzTo = 30;

  QuranQuestionsState copyWith({
    QuestionType? questionType,
    AyahsAnswersType? answersType,
    AyahsAnswerStates? ayahsAnswerStates,
    Ayah? successQuestionAyah,
    String? errorMessage,
    bool? isLoading,
    bool? isPressed,
    int? quastionNumber,
    int? trueAnswersCounter,
    int? wrongAnwersCounter,
    int? selectedDropDownAnswerPage,
    int? selectedDropDownAnswerJuz,
    int? pageFrom,
    int? pageTo,
    int? juzFrom,
    int? juzTo,
  }) {
    return QuranQuestionsState(
      questionType: questionType ?? this.questionType,
      answersType: answersType ?? this.answersType,
      ayahsAnswerStates: ayahsAnswerStates ?? this.ayahsAnswerStates,
      successQuestionAyah: successQuestionAyah ?? this.successQuestionAyah,
      errorMessage: errorMessage ?? '',
      isLoading: isLoading ?? false,
      isPressed: isPressed ?? this.isPressed,
      quastionNumber: quastionNumber ?? this.quastionNumber,
      trueAnswersCounter: trueAnswersCounter ?? this.trueAnswersCounter,
      wrongAnwersCounter: wrongAnwersCounter ?? this.wrongAnwersCounter,
      selectedDropDownAnswerPage: selectedDropDownAnswerPage ?? this.selectedDropDownAnswerPage,
      selectedDropDownAnswerJuz: selectedDropDownAnswerJuz ?? this.selectedDropDownAnswerJuz,
      pageFrom: pageFrom ?? this.pageFrom,
      pageTo: pageTo ?? this.pageTo,
      juzFrom: juzFrom ?? this.juzFrom,
      juzTo: juzTo ?? this.juzTo,
    );
  }

  @override
  List<Object> get props => [
        questionType,
        answersType,
        ayahsAnswerStates,
        successQuestionAyah,
        errorMessage,
        isLoading,
        isPressed,
        quastionNumber,
        trueAnswersCounter,
        wrongAnwersCounter,
        selectedDropDownAnswerPage,
        selectedDropDownAnswerJuz,
        pageFrom,
        pageTo,
        juzFrom,
        juzTo,
      ];
}
