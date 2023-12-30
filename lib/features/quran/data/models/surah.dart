import '../../../../core/utils/enums/enums.dart';
import '../../quran.dart';

class Surah {
  Surah({
    required this.name,
    required this.startAtPage,
    required this.ayahs,
    required this.number,
    required this.downloadState,
  });

  Surah.empty({
    this.name = 'ERROR',
    this.startAtPage = 0,
    this.number = 0,
    this.ayahs = const [],
    this.downloadState = DownloadState.notDownloaded,
  });

  final String name;
  final int startAtPage;
  final int number;
  final List<Ayah> ayahs;
  final DownloadState downloadState;
  factory Surah.fromjson(dynamic json) {
    List<Ayah> ayahs = [];
    for (var ayah in json['ayahs']) {
      Ayah newAyah = Ayah.fromJson(ayah);
      newAyah.surahName = json['name'];
      newAyah.surahNumber = json['number'];
      ayahs.add(newAyah);
    }
    return Surah(
      name: json['name'],
      startAtPage: ayahs[0].page,
      number: json['number'],
      ayahs: ayahs,
      downloadState: DownloadState.notDownloaded,
    );
  }
}
