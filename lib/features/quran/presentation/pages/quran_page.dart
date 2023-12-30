import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../quran.dart';

class QuranPage extends StatefulWidget {
  QuranPage({super.key, bool? showInKahf}) {
    // Get.find<QuranPageCtr>().showInKahf = showInKahf ?? false;
  }
  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> with TickerProviderStateMixin {
  int animationDurationMilliseconds = 600;
  // final QuranPageCtr _quranCtr = Get.find<QuranPageCtr>();

  @override
  void initState() {
    super.initState();

    // HelperMethods.setNewOpendPageId(QuranPage.id);

    // _quranCtr.quranPageSetState = (() => setState(() {}));

    context.read<QuranCubit>().setCurrentPage(this);

    // _quranCtr.changeOnShownState(false);

    context.read<QuranCubit>().setTabCtrListener();
    // JsonService.loadQuranData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        return const Scaffold(
          resizeToAvoidBottomInset: false,
          // key: AppSettings.scaffoldKey,
          //  endDrawer: MyEndDrawer(),
          body: Stack(
            children: [
              QuranPageBody(),
              QuranPageTop(),
              //QuranPageFooter(),
            ],
          ),
        );
      },
    );
  }
}
