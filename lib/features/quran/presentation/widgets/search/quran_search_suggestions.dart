import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/widget/space/vertical_space.dart';
import 'package:zad_almumin/features/quran/quran.dart';
import 'package:zad_almumin/src/injection_container.dart';

import '../../../../../core/utils/resources/resources.dart';

class QuranSearchSuggestions extends StatelessWidget {
  final String query;
  const QuranSearchSuggestions({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<QuranSearchCubit>(),
      child: BlocBuilder<QuranSearchCubit, QuranSearchState>(
        builder: (context, state) {
          return _body(context);
        },
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: AppSizes.screenPadding / 2),
      child: SingleChildScrollView(
        physics: query.isEmpty ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             VerticalSpace(AppSizes.spaceBetweanParts),
            const DraggableFilterChips(),
             VerticalSpace(AppSizes.spaceBetweanParts),
            QuranSearchSuggestionResultOrder(query: query),
          ],
        ),
      ),
    );
  }
}
