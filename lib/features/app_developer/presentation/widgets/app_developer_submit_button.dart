import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/features/app_developer/app_developer.dart';

class AppDeveloperSubmitButton extends StatelessWidget {
  const AppDeveloperSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.read<AppDeveloperCubit>().sendMessageToDb(),
      // style: ButtonStyle(
      //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      //     RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular( AppSizes.cardRadius),
      //       side: BorderSide(color: Theme.of(context).primaryColor),
      //     ),
      //   ),
      // ),
      child: const Text('ارسال'),
    );
  }
}
