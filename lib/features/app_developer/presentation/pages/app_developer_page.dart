import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/helpers/toats_helper.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';
import 'package:zad_almumin/features/app_developer/app_developer.dart';
import '../../../../core/widget/app_scaffold.dart';
import '../../../../core/widget/screen_loading_layer.dart';

class AppDeveloperPage extends StatelessWidget {
  const AppDeveloperPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppDeveloperCubit, AppDeveloperState>(
      listener: (context, state) {
        if (state is AppDeveloperSuccesState) {
          ToatsHelper.show('تم ارسال الرسالة بنجاح');
        } else if (state is AppDeveloperErrorMessage) {
          ToatsHelper.showError(' حدث خطأ ما الرجاء المحاولة مرة اخرى => [${state.message}]');
        }
      },
      builder: (context, state) {
        return ScreenLoadingLayer(
          isLoading: context.watch<AppDeveloperCubit>().state is AppDeveloperLoadingState,
          child: _body(context),
        );
      },
    );
  }

  Widget _body(BuildContext context) {
    return AppScaffold(
      title: 'مطور التطبيق',
      body: _childeren(context),
    );
  }

  Widget _childeren(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        _image(context), //developer_3d,cosrumerSurvices_3d
        _title(),
        _description(),
        _textFieldsTitle(),
        const AppDeveloperAddNameTextField(),
        SizedBox(height: context.height * .01),
        const AppDeveloperAddMessageTextField(),
        SizedBox(height: context.height * .01),
        const AppDeveloperSubmitButton(),
      ],
    );
  }

  Image _image(BuildContext context) {
    return Image.asset(
      AppImages.developer_3d,
      height: context.height * .4,
    );
  }

  Text _title() => const Text('مرحبا, انا مطور البرنامج أسمي (أحمد بصمه جي)');

  Wrap _description() {
    return const Wrap(
      children: <Widget>[
        Text("تواصل معي عبر الايميل:"),
        SelectableText('engahmet10@gmail.com'),
      ],
    );
  }

  Text _textFieldsTitle() => const Text(
        'أكتب لي ملاحظاتك عن التطبيق من اجل تحسينه',
        textAlign: TextAlign.center,
      );
}
