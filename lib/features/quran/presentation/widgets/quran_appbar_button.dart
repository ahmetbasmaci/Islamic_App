import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../quran.dart';

class QuranAppbarButton extends StatelessWidget {
  const QuranAppbarButton({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        return AnimatedOpacity(
          opacity: context.read<QuranCubit>().state.showTopFooterPart ? 1 : 0,
          duration: const Duration(milliseconds: 100),
          child: child,
        );
      },
    );
  }
}
