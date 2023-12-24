import 'package:flutter/material.dart';

class QuranBanner extends StatelessWidget {
  const QuranBanner({super.key, required this.isMarked, required this.child});
  final bool isMarked;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return isMarked ? _markedBanner() : Container(child: child);
  }

  Widget _markedBanner() {
    return Banner(message: '', location: BannerLocation.bottomStart, child: child);
  }
}
