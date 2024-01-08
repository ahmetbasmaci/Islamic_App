import 'package:flutter/material.dart';
import 'package:zad_almumin/config/local/l10n.dart';
import 'package:zad_almumin/features/quran/quran.dart';

import '../../../../../core/utils/resources/app_constants.dart';

class QuranSearchDelegate extends SearchDelegate {
  final QuranSearchCubit quranSearchCubit;
  QuranSearchDelegate({required this.quranSearchCubit});
  @override
  String get searchFieldLabel => AppStrings.of(AppConstants.context).searchForAyahOrSureOrPage;

  // @override
  // ThemeData appBarTheme(BuildContext context) => Get.find<ThemeCtr>().currentThemeMode.value.copyWith(
  //       scaffoldBackgroundColor: MyColors.quranBackGround,
  //       iconTheme: IconThemeData(color: MyColors.quranPrimary),
  //       textTheme: TextTheme(
  //         titleMedium: TextStyle(color: MyColors.quranPrimary),
  //       ),
  //       appBarTheme: AppBarTheme(
  //         color: MyColors.quranBackGround,
  //         iconTheme: IconThemeData(color: MyColors.quranPrimary),
  //         titleTextStyle: TextStyle(color: MyColors.quranPrimary),
  //       ),
  //       inputDecorationTheme: InputDecorationTheme(
  //         focusedBorder: InputBorder.none,
  //         border: InputBorder.none,
  //         labelStyle: Text.main(title: '', color: MyColors.quranPrimary).style,
  //       ),
  //     );

  @override
  List<Widget>? buildActions(BuildContext context) =>
      [IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () => close(context, null))];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(icon: const Icon(Icons.close), onPressed: () => query = '');

  @override
  Widget buildResults(BuildContext context) => QuranSearchSuggestions(query: query);

  @override
  Widget buildSuggestions(BuildContext context) => QuranSearchSuggestions(query: query);
}
