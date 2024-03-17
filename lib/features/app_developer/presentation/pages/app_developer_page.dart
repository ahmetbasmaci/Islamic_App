import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/helpers/toats_helper.dart';
import 'package:zad_almumin/core/utils/resources/app_constants.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';
import 'package:zad_almumin/core/widget/space/space.dart';
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
      usePadding: true,
      body: GestureDetector(
        onTap: () => AppConstants.focusScopeNode.unfocus(),
        child: _childeren(context),
      ),
    );
  }

  Widget _childeren(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        _image(context), //developer_3d,cosrumerSurvices_3d
        _title(),
        _description(context),
        VerticalSpace(AppSizes.spaceBetweanWidgets),
        _textFieldsTitle(),
        const AppDeveloperAddNameTextField(),
        VerticalSpace(AppSizes.spaceBetweanWidgets),
        const AppDeveloperAddMessageTextField(),
        VerticalSpace(AppSizes.spaceBetweanWidgets),
        const AppDeveloperSubmitButton(),
      ],
    );
  }

  Image _image(BuildContext context) {
    return Image.asset(
      AppImages.developer_3d,
      height: context.height * .3,
    );
  }

  Text _title() => const Text('مرحبا, انا مطور البرنامج أسمي (أحمد بصمه جي)');

  Wrap _description(BuildContext context) {
    return Wrap(
      children: <Widget>[
        const Text("تواصل معي عبر الايميل:"),
        SelectableText(
          AppConstants.developerEmail,
          style: AppStyles.contentBold.copyWith(color: context.themeColors.secondary),
        ),
      ],
    );
  }

  Text _textFieldsTitle() => const Text(
        'أكتب لي ملاحظاتك عن التطبيق من اجل تحسينه',
        textAlign: TextAlign.center,
      );
}
