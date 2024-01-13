import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/helpers/toats_helper.dart';

import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/resources/resources.dart';
import '../../../../src/injection_container.dart';
import '../../tafseer.dart';

class TafseersListItem extends StatelessWidget {
  final TafseerManagerModel tafseerModel;
  const TafseersListItem({super.key, required this.tafseerModel});

  @override
  Widget build(BuildContext context) {
    bool itemSelected = context.read<TafseerCubit>().selectedTafseerId == tafseerModel.id;
    return ListTile(
      title: Text("${tafseerModel.name} - ${tafseerModel.bookName}"),
      subtitle: Text(tafseerModel.author),
      selected: itemSelected,
      onTap: tafseerModel.downloadState == DownloadState.downloaded
          ? () => context.read<TafseerCubit>().selectTafseer(tafseerModel)
          : null,
      trailing: _downloadButton(context, tafseerModel),
    );
  }

  Widget _downloadButton(BuildContext context, TafseerManagerModel tafseerModel) {
    return BlocProvider(
      create: (context) => GetItManager.instance.tafseerDownloadCubit,
      child: BlocConsumer<TafseerDownloadCubit, TafseerDownloadState>(
        listener: (context, state) {
          if (state is TafseerDownloadErrorState) {
            ToatsHelper.showError(state.message);
          }
        },
        builder: (context, state) {
          return IconButton(
            icon: _downlaodButtonIcon(context, state, tafseerModel),
            onPressed: tafseerModel.downloadState == DownloadState.notDownloaded
                ? () => context.read<TafseerDownloadCubit>().downlaodTafseer(tafseerModel)
                : null,
          );
        },
      ),
    );
  }

  Widget _downlaodButtonIcon(
    BuildContext context,
    TafseerDownloadState state,
    TafseerManagerModel tafseerModel,
  ) {
    //downloaded
    if (tafseerModel.downloadState == DownloadState.downloaded) return AppIcons.downlaodDone;

    //donwloading
    if (state is TafseerDownloadDownloadingState && tafseerModel == state.tafseerManagerModel) {
      return CircularProgressIndicator(
        value: state.progress / 100,
        valueColor: AlwaysStoppedAnimation<Color>(context.themeColors.primary),
      );
    }

    //not downloaded
    return AppIcons.downlaod;
  }
}
