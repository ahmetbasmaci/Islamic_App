import 'dart:io';

import 'package:zad_almumin/constents/constents.dart';

class Ayah {
  Ayah({required this.file, required this.surahNumber, required this.ayahNumber}) {
    formatedAyahNumber = Constants.formatInt3.format(ayahNumber);
    formatedSurahNumber = Constants.formatInt3.format(surahNumber);
  }
  File file;
  int ayahNumber;
  int surahNumber;
  late String formatedAyahNumber;
  late String formatedSurahNumber;
}
