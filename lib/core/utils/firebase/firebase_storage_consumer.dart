import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:zad_almumin/core/utils/enums/enums.dart';
import '../../../features/app_developer/app_developer.dart';
import '../../error/exceptions/app_exceptions.dart';
import 'firebase.dart';

abstract class IFirebaseStorageConsumer {
  Future<String> getUrl(FireBaseStorageFileName fileName, int id);
  Future<void> addNewUserMessage(UserMessageToDeveloperModel userMessageToDeveloperModel);
}

class FirebaseStorageConsumer implements IFirebaseStorageConsumer {
  @override

  /// Retrieves the URL of a file from Firebase Storage.
  ///
  /// The [fileName] parameter specifies the name of the file to retrieve.
  /// The [id] parameter specifies the ID of the file.
  ///
  /// Returns a [Future] that completes with the URL of the file.
  Future<String> getUrl(FireBaseStorageFileName fileName, int id) async {
    ListResult filesList = await FirebaseStorage.instance.ref(fileName.name).listAll();

    for (var element in filesList.items) {
      if (element.name.contains(id.toString())) {
        String url = await element.getDownloadURL();
        return url;
      }
    }
    throw ServerException('Firebase file name id  not found file name: $fileName id: $id');
  }

  /// Adds a new user message to the developer model.
  ///
  /// This method is responsible for adding a new user message to the developer model.
  /// It takes a [UserMessageToDeveloperModel] object as a parameter and returns a [Future].
  /// The [UserMessageToDeveloperModel] object contains the necessary information for the message.
  @override
  Future<void> addNewUserMessage(UserMessageToDeveloperModel userMessageToDeveloperModel) async {
    await FirebaseFirestore.instance.collection(FirebaseStrings.users).add(
          userMessageToDeveloperModel.toJson(),
        );
  }

  /// Retrieves a list of user messages to the developer from Firebase.
  ///
  /// Returns a Future that resolves to a List of UserMessageToDeveloperModel objects.
  Future<List<UserMessageToDeveloperModel>> _getUsersMessages() async {
    var data = await FirebaseFirestore.instance.collection(FirebaseStrings.users).get();
    return data.docs.map((e) => UserMessageToDeveloperModel.fromJson(e.data())).toList();
  }
}
