import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return
    
    
     BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        return const Scaffold(
          resizeToAvoidBottomInset: false,
          // key: AppSettings.scaffoldKey,
          //  endDrawer: MyEndDrawer(),
          body: Stack(
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
