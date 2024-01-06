import 'package:flutter/material.dart';

import '../../../../../core/widget/animations/animations.dart';

class QuranEndDrawerPageBodyItem extends StatelessWidget {
  final int itemsCount;
  final Widget Function(int) itemChild;
  const QuranEndDrawerPageBodyItem({
    super.key,
    required this.itemsCount,
    required this.itemChild,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemCount: itemsCount,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: index != itemsCount - 1 ? 10 : 0),
            child: AnimatedListItemDownToUp(
              index: index,
              child: itemChild(index),
            ),
          );
        },
      ),
    );
  }
}
