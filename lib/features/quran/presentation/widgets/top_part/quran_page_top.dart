import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import '../../../../../core/utils/resources/resources.dart';
import '../../../quran.dart';

class QuranPageTop extends StatelessWidget {
  const QuranPageTop({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        return SafeArea(
          child: _animatedParent(
            context: context,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                QuranTopMenuButton(),
                QuranTopHomeButton(),
                QuranTopSwichQuranViewButton(),
                Spacer(),
                QuranTopSearchButton(),
                QuranTopEndDrawerButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _animatedParent({required BuildContext context, required Widget child}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      height: context.read<QuranCubit>().state.showTopFooterPart ? kToolbarHeight : 0,
      width: context.width,
      decoration: AppDecorations.quranTopCard(context),
      child: child,
    );
  }
}
