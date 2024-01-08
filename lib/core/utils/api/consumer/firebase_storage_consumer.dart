import 'package:firebase_storage/firebase_storage.dart';
import 'package:zad_almumin/core/utils/enums/enums.dart';
import '../../../error/exceptions/app_exceptions.dart';

abstract class IFirebaseStorageConsumer {
  Future<String> getUrl(FireBaseStorageFileName fileName, int id);
}

class FirebaseStorageConsumer implements IFirebaseStorageConsumer {
  @override
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
}
