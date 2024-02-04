import 'package:flutter/material.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';

import 'favorite_body.dart';

class FavoriteSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'بحث';

  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context).copyWith(
        scaffoldBackgroundColor: context.themeColors.background,
        iconTheme: IconThemeData(color: context.themeColors.primary),
        appBarTheme: AppBarTheme(
            color: context.themeColors.background, iconTheme: IconThemeData(color: context.themeColors.primary)),
        textTheme: TextTheme(labelLarge: TextStyle(color: context.themeColors.primary)),
        textSelectionTheme: TextSelectionThemeData(cursorColor: context.themeColors.primary),
        inputDecorationTheme: const InputDecorationTheme(focusedBorder: InputBorder.none, border: InputBorder.none),
      );

  @override
  List<Widget>? buildActions(BuildContext context) =>
      [IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () => close(context, null))];

  @override //back button
  Widget? buildLeading(BuildContext context) => IconButton(icon: const Icon(Icons.close), onPressed: () => query = '');

  @override
  Widget buildResults(BuildContext context) => FavoriteBody(searchText: query);

  @override
  Widget buildSuggestions(BuildContext context) => FavoriteBody(searchText: query);
}
