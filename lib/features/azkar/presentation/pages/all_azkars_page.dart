import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/local/l10n.dart';
import '../../azkar.dart';

import '../../../../core/widget/app_scaffold.dart';

class AllAzkarsPage extends StatelessWidget {
  const AllAzkarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppStrings.of(context).muslimZikrs,
      usePadding: false,
      body: BlocBuilder<AzkarCubit, AzkarState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: _itemsList(context),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _itemsList(BuildContext context) {
    List<Widget> resultList = [];
    var azkarList = context.read<AzkarCubit>().zikrCategoryModelsAllAzkars;
    for (var i = 0; i < azkarList.length; i++) {
      resultList.add(
        ZikrListTileItem(
          index: i,
          zikrCategoryModel: azkarList[i],
        ),
      );
    }
    //add allahNames item
    resultList.add(
      ZikrListTileItem(
        index: azkarList.length,
        zikrCategoryModel: context.read<AzkarCubit>().zikrCategoryModelsAllahNames.first,
      ),
    );
    return resultList;
  }
}
