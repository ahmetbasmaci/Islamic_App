import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/utils/enums/enums.dart';

abstract class IAyahApi {
  String getAyahDownloadUrl(int surahNumber, int ayahNumber, QuranReader quranReader);
  String getSurahZipDownloadUrl(int surahNumber, QuranReader quranReader);
}

class AyahApi implements IAyahApi {
  final String _baseUrl = 'http://www.everyayah.com/data/';
  Map<QuranReader, String> _readersUrls = {};
  AyahApi() {
    _readersUrls = {
      QuranReader.yaserAlsalamah: "${_baseUrl}Yaser_Salamah_128kbps/",
      QuranReader.yaserAldosary: "${_baseUrl}Yasser_Ad-Dussary_128kbps/",
      QuranReader.ibrahimAldosary: "${_baseUrl}warsh/warsh_ibrahim_aldosary_128kbps/",
      QuranReader.aymanSwaid: "${_baseUrl}Ayman_Sowaid_64kbps/",
      QuranReader.alhasri: "${_baseUrl}Husary_Mujawwad_64kbps/",
      QuranReader.almenshawi: "${_baseUrl}Menshawi_16kbps/",
      QuranReader.abdulBased: "${_baseUrl}AbdulSamad_64kbps_QuranExplorer.Com/",
      QuranReader.alafasi: "${_baseUrl}Alafasy_64kbps/",
      QuranReader.abdullahBasfar: "${_baseUrl}Abdullah_Basfar_64kbps/",
      QuranReader.abdullahMatroud: "${_baseUrl}Abdullah_Matroud_128kbps/",
      QuranReader.abuBakrAlshatiri: "${_baseUrl}Abu_Bakr_Ash-Shaatree_64kbps/",
      QuranReader.ahmedAlajamy: "${_baseUrl}Ahmed_ibn_Ali_al-Ajamy_64kbps_QuranExplorer.Com/",
      QuranReader.haniRifai: "${_baseUrl}Hani_Rifai_192kbps/",
      QuranReader.abdullaahAwwaad: "${_baseUrl}Abdullaah_3awwaad_Al-Juhaynee_128kbps/",
      QuranReader.ahmedNeana: "${_baseUrl}Ahmed_Neana_128kbps/",
      QuranReader.warshAbdulBasit: "${_baseUrl}warsh/warsh_Abdul_Basit_128kbps/",
      QuranReader.akramAlALqimy: "${_baseUrl}Akram_AlAlaqimy_128kbps/",
      QuranReader.faresAbbad: "${_baseUrl}Fares_Abbad_64kbps/",
      QuranReader.maherAlmuaqly: "${_baseUrl}Maher_AlMuaiqly_64kbps/",
      QuranReader.nabilRifa3i: "${_baseUrl}Nabil_Rifa3i_48kbps/",
      QuranReader.naserAlqatami: "${_baseUrl}Nasser_Alqatami_128kbps/",
      QuranReader.saoodAlShuraym: "${_baseUrl}Saood_ash-Shuraym_64kbps/",
      QuranReader.mahmoudAliAlBanna: "${_baseUrl}mahmoud_ali_al_banna_32kbps/",
    };
  }

  @override
  String getAyahDownloadUrl(int surahNumber, int ayahNumber, QuranReader quranReader) {
    String baseUrl = _readersUrls[quranReader] ?? '';
    if (baseUrl.isEmpty) {
      throw Exception('Reader url not found in everyayah.com');
    }

    return "$baseUrl${surahNumber.formated3}${ayahNumber.formated3}.mp3";
  }

  @override
  String getSurahZipDownloadUrl(int surahNumber, QuranReader quranReader) {
    String baseUrl = _readersUrls[quranReader] ?? '';
    if (baseUrl.isEmpty) {
      throw Exception('Reader url not found in everyayah.com');
    }

    return "$baseUrl/zips/${surahNumber.formated3}.zip";
  }
}
