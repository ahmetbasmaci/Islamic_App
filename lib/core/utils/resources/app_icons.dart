import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';

class AppIcons {
  AppIcons._();
  static Icon menu = const Icon(Icons.menu);
  static Icon home = const Icon(Icons.home);
  static Icon search = const Icon(Icons.search);
  static Icon drawer = const Icon(Icons.menu);
  static Icon refresh = const Icon(Icons.refresh);
  static Icon copy = const Icon(Icons.file_copy_outlined);
  static Icon copyFilled = const Icon(Icons.file_copy);
  static Icon share = const Icon(Icons.share_outlined);
  static Icon person = const Icon(Icons.person);
  static Icon shop = const Icon(Icons.shopify);
  static Icon backArrow = const Icon(Icons.arrow_forward);
  static Icon selectAll = const Icon(Icons.select_all);
  static Icon alarmOn = const Icon(Icons.alarm);
  static Icon alarmOff = const Icon(Icons.alarm_off_rounded);
  static Icon settings = const Icon(Icons.settings);

  static Icon ayahsTest = const Icon(Icons.question_answer_outlined);
  static Icon book = const Icon(Icons.book);
  static Icon tafseer = const Icon(Icons.my_library_books_rounded);
  static Icon quran = const Icon(CupertinoIcons.book_solid);
  static Icon quranText = const Icon(Icons.menu_book_sharp);
  static Icon quranImages = const Icon(Icons.image);

  static Icon darkMode = const Icon(Icons.dark_mode);
  static Icon lightMode = const Icon(Icons.light_mode);
  static Icon language = const Icon(Icons.language);
  static Icon favoriteFilled = const Icon(Icons.favorite);
  static Icon favorite = const Icon(Icons.favorite_border);
  static Icon audioPlay = const Icon(Icons.play_arrow_rounded);
  static Icon audioPause = const Icon(Icons.pause_rounded);
  static Icon leftArrow = const Icon(Icons.arrow_back_ios_new);
  static Icon rightArrow = const Icon(Icons.arrow_forward_ios);
  static Icon review = const Icon(Icons.reviews);
  static Icon azkar = const Icon(Icons.workspace_premium_sharp);
  static Icon notification = const Icon(Icons.notifications);
  static Icon prayersTime = const Icon(CupertinoIcons.timer_fill);
  static Icon moreVert = const Icon(Icons.more_vert);

  static Icon addBookMark = const Icon(Icons.bookmark_add_sharp);
  static Icon letter = const Icon(Icons.font_download_off_rounded);
  static Icon letterSize = const Icon(CupertinoIcons.textformat_size);
  static Icon close = const Icon(Icons.close);
  static Icon info = const Icon(Icons.info_outline);
  static Icon stop = const Icon(Icons.stop);
  static Icon plus = const Icon(Icons.add);
  static Icon minus = const Icon(Icons.remove);
  static Icon downArrow = const Icon(Icons.arrow_drop_down);
  static Icon bookmarkAdded = const Icon(Icons.bookmark_added);
  static Icon bookmarkAdd = const Icon(Icons.bookmark_add_rounded);

  static Widget animatedQuranImagesView(bool isImages) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 200),
      firstChild: quranImages,
      secondChild: quranText,
      crossFadeState: isImages ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }

  static Widget animatedQuranTafseerView(bool isTafseer) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 200),
      firstChild: tafseer,
      secondChild: quran,
      crossFadeState: isTafseer ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }

  static Widget animatedLightDark(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 200),
      firstChild: lightMode,
      secondChild: darkMode,
      crossFadeState:
          context.theme.brightness == Brightness.light ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }

  static Widget animatedPlayPause(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 200),
      firstChild: audioPlay,
      secondChild: audioPause,
      crossFadeState:
          context.theme.brightness == Brightness.light ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }
}
