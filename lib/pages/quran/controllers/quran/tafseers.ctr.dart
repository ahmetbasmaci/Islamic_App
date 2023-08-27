// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/constents/app_settings.dart';
import 'package:zad_almumin/moduls/enums.dart';
import '../../../../services/json_service.dart';
import '../../models/ayah_tafseer.dart';
import '../../models/tafseer_model.dart';

class TafseersCtr extends GetxController {
  GetStorage storage = GetStorage();
  TafseersCtr() {
    updateSelectedTafseerIdFromStorage();
  }
  final List<TafseerModel> _tafseersManager = [];
  RxList<SurahTafseer> allTafseer = <SurahTafseer>[].obs;
  final RxInt _selectedTafseerId_ar = 0.obs;
  final RxInt _selectedTafseerId_en = 0.obs;
  RxInt get selectedTafseerId {
    if (AppSettings.isArabicLang)
      return _selectedTafseerId_ar;
    else
      return _selectedTafseerId_en;
  }

  List<TafseerModel> get tafseersManager {
    if (AppSettings.isArabicLang)
      return _tafseersManager.where((element) => element.language == 'ar').toList();
    else
      return _tafseersManager.where((element) => element.language == 'en').toList();
  }

  void addTafseer(List<TafseerModel> tafseerModels) {
    _tafseersManager.addAll(tafseerModels);
  }

  void updateSelectedTafseerId(int newID) {
    if (AppSettings.isArabicLang) {
      _selectedTafseerId_ar.value = newID;
      storage.write('_selectedTafseerId_ar', newID);
    } else {
      _selectedTafseerId_en.value = newID;
      storage.write('_selectedTafseerId_en', newID);
    }
  }

  void updateSelectedTafseerIdFromStorage() {
    _selectedTafseerId_ar.value = storage.read<int>('_selectedTafseerId_ar') ?? 0;
    _selectedTafseerId_en.value = storage.read<int>('_selectedTafseerId_en') ?? 0;
  }

  void languageUpdated() {
    TafseerModel? newTafseerModel =
        tafseersManager.firstWhereOrNull((element) => element.downloadState.value == DownloadState.downloaded);
    if (newTafseerModel == null) {
      updateSelectedTafseerId(0);
      allTafseer.clear();
    } else {
      updateSelectedTafseerIdFromStorage();
      JsonService.loadTafseer();
    }
  }
}
