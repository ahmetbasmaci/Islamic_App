import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import 'package:zad_almumin/src/injection_container.dart';
import '../../../quran.dart';

class QuranEndDrawer extends StatelessWidget {
  const QuranEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<QuranEndDrawerCubit>(),
      child: BlocBuilder<QuranEndDrawerCubit, QuranEndDrawerState>(
        builder: (context, state) {
          return SafeArea(
            child: Drawer(
              width: context.width * 0.6,
              child: Column(
                children: [
                  SizedBox(height: context.height * 0.01),
                  const QuranEndDrawerPagesTitles(),
                  Divider(color: context.themeColors.primary),
                  const QuranEndDrawerPages(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
