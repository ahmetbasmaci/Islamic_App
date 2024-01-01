import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/utils/constants.dart';
import '../../quran.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({super.key, this.showInKahf = false});
  final bool showInKahf;
  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<QuranCubit>().initPage(this, widget.showInKahf);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          key: Constants.scaffoldKey,
          endDrawer: const QuranEndDrawer(),
          body: const Stack(
            children: [
              QuranPageBody(),
              QuranPageTop(),
              QuranPageFooter(),
            ],
          ),
        );
      },
    );
  }
}
