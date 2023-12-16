import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../core/extentions/extentions.dart';
import 'hadith_part/app_card_content_hadith.dart';
import 'quran_part/app_card_content_quran.dart';
import 'zikr_part/home_page_zikr_slider_all_azkars.dart';
import '../../../../core/widget/animations/animated_list_item_down_to_up.dart';
import 'zikr_part/home_page_zikr_slider_allah_names.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height,
      width: context.width,
      child: AnimationLimiter(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [
              AnimatedListItemDownToUp(index: 1, child: AppCardContentQuran()),
              AnimatedListItemDownToUp(index: 2, child: AppCardContentHadith()),
              AnimatedListItemDownToUp(index: 3, child: HomePageZikrSliderAllAzkars()),
              AnimatedListItemDownToUp(index: 3, child: HomePageZikrSliderAllahNames()),
            ],
          ),
        ),
      ),
    );
  }
}
