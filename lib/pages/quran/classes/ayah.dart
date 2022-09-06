import 'dart:io';

import 'package:zad_almumin/constents/constents.dart';

class Ayah {
  Ayah({required this.file,  required this.surahNumber,required this.ayahNumber}) {
    formatedAyahNumber = Constants.format3.format(ayahNumber);
    formatedSurahNumber =  Constants.format3.format(surahNumber);
  }
  File file;
  int ayahNumber;
  int surahNumber;
  late String formatedAyahNumber;
  late String formatedSurahNumber;
}
