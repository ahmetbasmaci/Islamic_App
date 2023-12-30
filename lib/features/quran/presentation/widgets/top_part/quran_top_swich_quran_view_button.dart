import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/resources/resources.dart';
import '../../../quran.dart';

class QuranTopSwichQuranViewButton extends StatelessWidget {
  const QuranTopSwichQuranViewButton({super.key});

  @override
  Widget build(BuildContext context) {
    return QuranAppbarButton(
      child: IconButton(
        onPressed: () => context.read<QuranCubit>().changeQuranImagesStyle(),
        icon: AppIcons.animatedQuranImages(context.read<QuranCubit>().state.showQuranImages),
      ),
    );
  }
}
