import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/pages/quran/models/ayah.dart';
import '../../../moduls/enums.dart';

class Surah {
  Surah({required this.name, required this.startAtPage, required this.ayahs, required this.number, required this.downloadState});

  Surah.empty({this.name = '', this.startAtPage = 0, this.number = 0, this.ayahs = const []});

  String name;
  int startAtPage;
  int number;
  List<Ayah> ayahs = [];
  Rx<DownloadState> downloadState=DownloadState.notDownloaded.obs;
  factory Surah.fromjson(Map<String, dynamic> json) {
    List<Ayah> ayahs = [];
    for (var ayah in json['ayahs']) {
      Ayah newAyah = Ayah.fromJson(ayah);
      newAyah.surahName = json['name'];
      newAyah.surahNumber = json['number'];
      newAyah.isMarked = GetStorage().read<bool>('markedAyah${newAyah.surahNumber}${newAyah.ayahNumber}') ?? false;
      ayahs.add(newAyah);
    }
    return Surah(
      name: json['name'],
      startAtPage: ayahs[0].page,
      number: json['number'],
      ayahs: ayahs,
      downloadState:DownloadState.notDownloaded.obs
    );
  }
}
