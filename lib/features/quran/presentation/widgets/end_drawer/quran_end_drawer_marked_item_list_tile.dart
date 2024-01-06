import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';

import '../../../quran.dart';

class QuranEndDrawerMarkedItemListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final int page;

  const QuranEndDrawerMarkedItemListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          titleTextStyle: AppStyles.quran,
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(title),
          ),
          subtitle: Text(subtitle),
          onTap: () => context.read<QuranCubit>().endDrawerSavedItemPressed(page),
        ),
        Divider(color: context.themeColors.primary)
      ],
    );
  }
}
