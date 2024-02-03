import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/resources/app_constants.dart';
import '../../app_developer.dart';

class AppDeveloperAddNameTextField extends StatelessWidget {
  const AppDeveloperAddNameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: AppConstants.focusScopeNode,
      child: TextField(
        maxLength: 30,
        controller: context.read<AppDeveloperCubit>().nameTxtCtr,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.fromLTRB(2, 2, 5, 2),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          counterText: "",
          hintText: 'الاسم :',
        ),
      ),
    );
  }
}
