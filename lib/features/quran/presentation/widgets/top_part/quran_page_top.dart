import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import '../../../../../core/utils/resources/resources.dart';
import '../../../quran.dart';

class QuranPageTop extends StatelessWidget {
  QuranPageTop({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: context.read<QuranCubit>().state.topFooterPartIsVisable ? kToolbarHeight : 0,
        width: context.width,
        decoration: _decoration(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const QuranTopMenuButton(),
            const QuranTopHomeButton(),
            const QuranTopSwichQuranViewButton(),
            Expanded(flex: 2, child: Container()),
            const QuranTopSearchButton(),
            const QuranTopEndDrawerButton(),
          ],
        ),
      ),
    );
  }

  BoxDecoration _decoration(BuildContext context) {
    return BoxDecoration(
      color: context.backgroundColor,
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(AppSizes.cardRadius)),
      boxShadow: [
        BoxShadow(
          color: context.primaryColor.withOpacity(.6),
          blurRadius: 10,
          offset: const Offset(0, 3),
        )
      ],
    );
  }
}
