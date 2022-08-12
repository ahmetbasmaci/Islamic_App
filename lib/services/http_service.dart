import 'dart:io';
import 'dart:typed_data';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static Future<File?> _downloadFile({required String url, required int numberInQuran}) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/${numberInQuran.toString()}.mp3');
    bool exists = await file.exists();
    if (exists) return file;

    try {
      http.Response request = await http.get(Uri.parse(url)); //downlaod the file
      Uint8List bytes = request.bodyBytes; //close();
      await file.writeAsBytes(bytes);
      Fluttertoast.showToast(msg: 'تم تحميل الاية بنجاح');
    } catch (e) {
      Fluttertoast.showToast(msg: 'مشكلة في الاتصال بالانترنت');
    }
    return file;
  }

  static Future downloadAllQuranAyahs() async {
    for (var i = 0; i <= 6236; i++) {
      await _downloadFile(url: 'https://cdn.islamic.network/quran/audio/128/ar.alafasy/$i.mp3', numberInQuran: i);
    }
  }

  static Future getAyah({required int numberInQuran}) {
    return _downloadFile(
        url: 'https://cdn.islamic.network/quran/audio/128/ar.alafasy/$numberInQuran.mp3', numberInQuran: numberInQuran);
  }
}
