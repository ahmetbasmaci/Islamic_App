import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/resources/resources.dart';
import '../../../../../src/injection_container.dart';
import '../../../quran.dart';

class QuranTopSearchButton extends StatelessWidget {
  const QuranTopSearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return QuranAppbarButton(
      child: BlocProvider(
        create: (context) => GetItManager.instance.quranSearchCubit,
        child: BlocBuilder<QuranSearchCubit, QuranSearchState>(
          builder: (context, state) {
            return IconButton(
              onPressed: () => showSearch(
                  context: context, delegate: QuranSearchDelegate(quranSearchCubit: context.read<QuranSearchCubit>())),
              icon: AppIcons.search,
            );
          },
        ),
      ),
    );
  }
}
