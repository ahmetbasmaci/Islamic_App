import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../config/theme/app_themes.dart';
import '../../../core/packages/local_storage/local_storage.dart';
import '../../../core/utils/resources/app_storage_keys.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required this.localStorage}) : super(ThemeState(AppThemes.themes[0]));

  final ILocalStorage localStorage;

  void getSavedTheme() async {
    String savedThemeName = localStorage.read<String>(AppStorageKeys.theme) ?? '';

    if (savedThemeName.isEmpty) return;

    emit(ThemeState(AppThemes.themes.firstWhere((element) => element.brightness.name == savedThemeName)));
  }

  void updateTheme(Brightness themeBrightness) async {
    ThemeData themeData = AppThemes.themes.firstWhere((element) => element.brightness == themeBrightness);

    localStorage.write(AppStorageKeys.theme, themeBrightness.name);

    emit(ThemeState(themeData));
  }

  void triggerTheme() {
    if (state.theme.brightness == Brightness.dark) {
      updateTheme(Brightness.light);
    } else {
      updateTheme(Brightness.dark);
    }
  }
}
