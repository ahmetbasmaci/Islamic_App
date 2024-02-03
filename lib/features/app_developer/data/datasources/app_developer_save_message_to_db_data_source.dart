import 'package:zad_almumin/features/app_developer/app_developer.dart';
import '../../../../core/utils/firebase/firebase.dart';

abstract class IAppDeveloperSaveMessageToDbDataSource {
  Future<void> saveMessageToDb(String name, String message);
}

class AppDeveloperSaveMessageToDbDataSource implements IAppDeveloperSaveMessageToDbDataSource {
  final IFirebaseStorageConsumer firebaseStorageConsumer;

  AppDeveloperSaveMessageToDbDataSource({required this.firebaseStorageConsumer});

  @override
  Future<void> saveMessageToDb(String name, String message) async {
    var newMessage = UserMessageToDeveloperModel(name: name, message: message);
    await firebaseStorageConsumer.addNewUserMessage(newMessage);
  }
}
