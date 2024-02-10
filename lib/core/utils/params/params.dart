import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import '../../../features/alarm/data/models/alarm_model.dart';
import '../../../features/tafseer/tafseer.dart';
import '../enums/enums.dart';

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetZikrCardDataParams extends Equatable {
  ZikrCategories zikrCategory;

  GetZikrCardDataParams({required this.zikrCategory});
  @override
  List<Object?> get props => [zikrCategory];
}

class GetAlarmDataPartParams extends Equatable {
  final AlarmPart aLarmType;

  const GetAlarmDataPartParams({required this.aLarmType});
  @override
  List<Object?> get props => [aLarmType];
}

class UpdateAlarmModelParams extends Equatable {
  final AlarmModel alarmModel;

  const UpdateAlarmModelParams({required this.alarmModel});
  @override
  List<Object?> get props => [alarmModel];
}

class GetPrayTimeParams extends Equatable {
  final Position position;
  final DateTime date;

  const GetPrayTimeParams({required this.position, required this.date});
  @override
  List<Object?> get props => [position, date];
}

class GetNextAyahParams extends Equatable {
  final int ayahNumber;
  final int surahNumber;

  const GetNextAyahParams({required this.ayahNumber, required this.surahNumber});
  @override
  List<Object?> get props => [ayahNumber, surahNumber];
}

class DownloadTafseerParams extends Equatable {
  final int tafseerId;

  const DownloadTafseerParams({required this.tafseerId});
  @override
  List<Object?> get props => [tafseerId];
}

class TafseerIdParams extends Equatable {
  final int tafseerId;

  const TafseerIdParams({required this.tafseerId});
  @override
  List<Object?> get props => [tafseerId];
}

class TafseerIdModelParams extends Equatable {
  final SelectedTafseerIdModel tafseerIdModel;

  const TafseerIdModelParams({required this.tafseerIdModel});
  @override
  List<Object?> get props => [tafseerIdModel];
}

class WriteDataIntoFileAsBytesSyncParams extends Equatable {
  final int tafseerId;
  final List<int> data;

  const WriteDataIntoFileAsBytesSyncParams({required this.tafseerId, required this.data});
  @override
  List<Object?> get props => [tafseerId, data];
}

class GetRandomStartAyahParams extends Equatable {
  final int juzFrom;
  final int juzTo;
  final int pageFrom;
  final int pageTo;

  const GetRandomStartAyahParams({
    required this.juzFrom,
    required this.juzTo,
    required this.pageFrom,
    required this.pageTo,
  });

  @override
  List<Object?> get props => [juzFrom, juzTo, pageFrom, pageTo];
}

class JuzFromParams extends Equatable {
  final int juzFrom;

  const JuzFromParams({required this.juzFrom});
  @override
  List<Object?> get props => [juzFrom];
}

class JuzToParams extends Equatable {
  final int juzTo;

  const JuzToParams({required this.juzTo});
  @override
  List<Object?> get props => [juzTo];
}

class PageFromParams extends Equatable {
  final int pageFrom;

  const PageFromParams({required this.pageFrom});
  @override
  List<Object?> get props => [pageFrom];
}

class PageToParams extends Equatable {
  final int pageTo;

  const PageToParams({required this.pageTo});
  @override
  List<Object?> get props => [pageTo];
}

class QuestionTypeParams extends Equatable {
  final QuestionType questionType;

  const QuestionTypeParams({required this.questionType});
  @override
  List<Object?> get props => [questionType];
}

class AnswerTypeParams extends Equatable {
  final AyahsAnswersType answerType;

  const AnswerTypeParams({required this.answerType});
  @override
  List<Object?> get props => [answerType];
}

class AddNewUserMessageParams extends Equatable {
  final String name;
  final String message;

  const AddNewUserMessageParams({required this.name, required this.message});

  @override
  List<Object?> get props => [name, message];
}

class FavoriteParams extends Equatable {
  final String content;

  const FavoriteParams({required this.content});

  @override
  List<Object?> get props => [content];
}
