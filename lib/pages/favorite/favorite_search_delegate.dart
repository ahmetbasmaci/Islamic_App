import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/my_colors.dart';

import 'favorite_body.dart';

class FavoriteSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'بحث'.tr;

  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context).copyWith(
        scaffoldBackgroundColor: MyColors.background,
        iconTheme: IconThemeData(color: MyColors.primary),
        appBarTheme: AppBarTheme(color: MyColors.background, iconTheme: IconThemeData(color: MyColors.primary)),
        textTheme: TextTheme(labelLarge: TextStyle(color: MyColors.primary)),
        textSelectionTheme: TextSelectionThemeData(cursorColor: MyColors.primary),
        inputDecorationTheme: InputDecorationTheme(focusedBorder: InputBorder.none, border: InputBorder.none),
      );

  @override
  List<Widget>? buildActions(BuildContext context) =>
      [IconButton(icon: Icon(Icons.arrow_forward), onPressed: () => close(context, null))];

  @override //back button
  Widget? buildLeading(BuildContext context) => IconButton(icon: Icon(Icons.close), onPressed: () => query = '');

  @override
  Widget buildResults(BuildContext context) => FavoriteBody(searchText: query);

  @override
  Widget buildSuggestions(BuildContext context) => FavoriteBody(searchText: query);
}
