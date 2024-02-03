import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/resources/app_constants.dart';
import '../../app_developer.dart';

class AppDeveloperAddMessageTextField extends StatelessWidget {
  const AppDeveloperAddMessageTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: AppConstants.focusScopeNode,
      child: TextField(
        controller: context.read<AppDeveloperCubit>().messageTxtCtr,
        minLines: 5,
        maxLines: 15,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(2, 2, 5, 2),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          counterText: "",
          hintText: 'الملاحظة :',
        ),
      ),
    );
  }
}
