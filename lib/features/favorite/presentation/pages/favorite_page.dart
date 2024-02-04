import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/resources/resources.dart';
import '../../../../core/widget/app_scaffold.dart';
import '../../favorite.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        return AppScaffold(
          title: 'المفضلة',
          actions: _actions(context),
          body: FavoriteBody(),
        );
      },
    );
  }

  List<Widget> _actions(BuildContext context) {
    return [
      IconButton(
        icon: AppIcons.search,
        onPressed: () => showSearch(context: context, delegate: FavoriteSearchDelegate()),
      ),
    ];
  }
}
