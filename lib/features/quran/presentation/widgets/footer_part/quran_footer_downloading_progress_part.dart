import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/widget/progress_indicator/app_linear_progress_indicator.dart';
import '../../../../../core/utils/resources/resources.dart';
import '../../../quran.dart';

class QuranFooterDownloadingProgressPart extends StatelessWidget {
  const QuranFooterDownloadingProgressPart({super.key});

  @override
  Widget build(BuildContext context) {
    return _animatedParent(context, _body(context));
  }

  Row _body(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 3,
          child: _downloadProgress(context),
        ),
        Expanded(
          flex: 1,
          child: _downloadRateAndCloseButton(context),
        ),
      ],
    );
  }

  AppLinearProgressIndicator _downloadProgress(BuildContext context) {
    return AppLinearProgressIndicator(
      value: context.read<QuranCubit>().state.downloadProgress == 0
          ? 0
          : context.read<QuranCubit>().state.downloadProgress / 100,
    );
  }

  Row _downloadRateAndCloseButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('${(context.read<QuranCubit>().state.downloadProgress).toStringAsFixed(0)}%'),
        IconButton(
          onPressed: () {
            //TODO
            // context.read<QuranCubit>().state.isStopDownload = true;
            // context.read<QuranCubit>().state.isLoading = false;
            // AudioService.stopAudio();
          },
          icon: AppIcons.close,
        ),
      ],
    );
  }

  Widget _animatedParent(BuildContext context, Widget child) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 600),
      opacity: context.read<QuranCubit>().state.isLoading ? 1 : 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        height: context.read<QuranCubit>().state.isLoading ? AppSizes.loadingRowHeight : 0,
        width: context.width,
        child: child,
      ),
    );
  }
}
