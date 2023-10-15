// ignore_for_file: non_constant_identifier_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/app_settings.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/constents/my_sizes.dart';
import 'package:zad_almumin/pages/quran/controllers/quran/quran_page_ctr.dart';
import 'package:zad_almumin/pages/settings/settings_ctr.dart';
import 'package:zad_almumin/services/audio_ctr.dart';

class MyIcons {
  static Icon drawer = Icon(Icons.menu);
  static Icon refresh = Icon(Icons.refresh);
  static Icon copy = Icon(Icons.file_copy_outlined);
  static Icon copyFilled = Icon(Icons.file_copy);
  static Icon share = Icon(Icons.share_outlined);
  static Icon error = Icon(Icons.error_outline, color: MyColors.wrong);
  static Icon ayahsTest = Icon(Icons.menu_book_sharp);
  static Icon person = Icon(Icons.person);
  static Icon shop = Icon(Icons.shopify);
  static Icon delete = Icon(Icons.delete, color: MyColors.wrong);
  static Icon backArrow = Icon(Icons.arrow_forward, size: MySiezes.icon);
  static Icon selectAll = Icon(Icons.select_all);
  static Icon alarm = Icon(Icons.alarm);

  static Icon lang({Color? color, double size = MySiezes.icon}) => Icon(Icons.language, color: color, size: size);
  static Icon info({Color? color, double size = MySiezes.icon}) => Icon(Icons.info_outline, color: color, size: size);
  static Icon color({Color? color, double size = MySiezes.icon}) =>
      Icon(Icons.color_lens_outlined, color: color, size: size);
  static Icon letterSize({Color? color, double size = MySiezes.icon}) =>
      Icon(CupertinoIcons.textformat_size, color: color, size: size);

  static Icon letter({Color? color, double size = MySiezes.icon}) =>
      Icon(Icons.font_download_rounded, color: color, size: size);
  static Icon plus({Color? color, double size = MySiezes.icon}) => Icon(Icons.add, color: color, size: size);
  static Icon minus({Color? color, double size = MySiezes.icon}) =>
      Icon(CupertinoIcons.minus, color: color, size: size);
  static Icon send({Color? color, double size = MySiezes.icon}) => Icon(Icons.send, color: color, size: size);
  static Icon settings({Color? color, double size = MySiezes.icon}) => Icon(Icons.settings, color: color, size: size);
  static Icon peaper({Color? color, double size = MySiezes.icon}) =>
      Icon(Icons.my_library_books_rounded, color: color, size: size);
  static Icon review({Color? color, double size = MySiezes.icon}) => Icon(Icons.reviews, color: color, size: size);
  static Icon reviewSound({Color? color, double size = MySiezes.icon}) =>
      Icon(Icons.record_voice_over, color: color, size: size);
  static Icon moreVert({Color? color, double size = MySiezes.icon}) => Icon(Icons.more_vert, color: color, size: size);
  static Icon repeat({Color? color, double size = MySiezes.icon}) => Icon(Icons.repeat, color: color, size: size);
  static Icon stop({Color? color, double size = MySiezes.icon}) => Icon(Icons.stop, color: color, size: size);
  static Icon close({Color? color, double size = MySiezes.icon}) => Icon(Icons.close, color: color, size: size);
  static Icon home({Color? color, double size = MySiezes.icon}) => Icon(Icons.home, color: color);
  static Icon mark({Color? color, double size = MySiezes.icon}) => Icon(Icons.bookmark_add_sharp, color: color);
  static Icon book({Color? color, double size = MySiezes.icon}) => Icon(Icons.book, color: color);
  static Icon quran({Color? color, double size = MySiezes.icon}) =>
      Icon(CupertinoIcons.book_solid, color: color, size: size);
  static Icon azkar({Color? color, double size = MySiezes.icon}) => Icon(Icons.workspace_premium_sharp, color: color);
  static Icon prayersTime({Color? color, double size = MySiezes.icon}) => Icon(CupertinoIcons.timer_fill, color: color);
  static Icon menu({Color? color, double size = MySiezes.icon}) => Icon(Icons.menu_book, color: color, size: size);
  static Icon notification({Color? color, double size = MySiezes.icon}) =>
      Icon(Icons.notification_important, color: color);
  static Icon rightArrow({Color? color, double size = MySiezes.icon}) =>
      Icon(Icons.arrow_back_ios_rounded, color: color, size: size);
  static Icon leftArrow({Color? color, double size = MySiezes.icon}) =>
      Icon(Icons.arrow_forward_ios_rounded, color: color, size: size);
  static Icon nextArrow({Color? color, double size = MySiezes.icon}) =>
      Icon(AppSettings.isArabicLang ? Icons.arrow_back_ios_rounded : Icons.arrow_forward_ios_rounded,
          color: color, size: size);
  static Icon search({Color? color, double size = MySiezes.icon}) =>
      Icon(CupertinoIcons.search, color: color, size: size);

  static Icon favoriteFilled({Color? color, double size = MySiezes.icon}) =>
      Icon(Icons.favorite, color: color, size: size);
  static Icon downlaod({Color? color, double size = MySiezes.icon}) => Icon(Icons.download, color: color, size: size);
  static Icon downlaodDone({Color? color, double size = MySiezes.icon}) =>
      Icon(Icons.download_done, color: color, size: size);
  static Icon favorite({Color? color, double size = MySiezes.icon}) =>
      Icon(Icons.favorite_border, color: color, size: size);
  static Icon downArrow({Color? color, double size = MySiezes.icon}) =>
      Icon(Icons.arrow_drop_down, color: color, size: size);
  static Icon upArrow({Color? color, double size = MySiezes.icon}) =>
      Icon(Icons.keyboard_arrow_up, color: color, size: size);
  static Icon done({Color? color = Colors.green, double size = MySiezes.icon}) =>
      Icon(Icons.done, color: color, size: size);
  static Icon optinos({Color? color = Colors.green, double size = MySiezes.icon}) =>
      Icon(Icons.add_circle_outline_sharp, color: color, size: size);
  static Widget animated_swichQuranImages({Color? color, double size = MySiezes.icon}) {
    color = color ?? MyColors.second;
    QuranPageCtr quranCtr = Get.find<QuranPageCtr>();
    return AnimatedCrossFade(
      duration: Duration(milliseconds: 200),
      firstChild: Icon(CupertinoIcons.book_circle, color: color, size: size),
      secondChild: Icon(Icons.image_sharp, color: color, size: size),
      crossFadeState: quranCtr.showQuranImages.value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }

  static Widget animated_swichQuranTafseer({Color? color, double size = MySiezes.icon}) {
    QuranPageCtr quranCtr = Get.find<QuranPageCtr>();
    return AnimatedCrossFade(
      duration: Duration(milliseconds: 200),
      firstChild: Icon(CupertinoIcons.book_fill, color: color, size: size),
      secondChild: Icon(Icons.library_books_outlined, color: color, size: size),
      crossFadeState: quranCtr.showTafseerPage.value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }

  static Widget animated_Light_Dark({Color? color, double size = MySiezes.icon}) {
    return AnimatedCrossFade(
      duration: Duration(milliseconds: 200),
      firstChild: Icon(Icons.dark_mode, color: color, size: size),
      secondChild: Icon(Icons.light_mode, color: color, size: size),
      crossFadeState: Get.isDarkMode ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }

  static Widget animatedSound_On_Of({Color? color, double size = MySiezes.icon}) {
    return AnimatedCrossFade(
      duration: Duration(milliseconds: 200),
      firstChild: Icon(Icons.notifications, color: color, size: size),
      secondChild: Icon(Icons.notifications_off, color: color, size: size),
      crossFadeState:
          Get.find<SettingsCtr>().isNotificationSoundOn.value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }

  static Widget animated_Play_Pause({Color? color, double size = MySiezes.icon}) {
    AudioCtr audioCtr = Get.find<AudioCtr>();
    return Obx(
      () => AnimatedCrossFade(
        duration: Duration(milliseconds: 200),
        firstChild: Icon(Icons.play_arrow_outlined, color: color, size: size),
        secondChild: Icon(Icons.pause_outlined, color: color, size: size),
        crossFadeState: audioCtr.isPlaying.value ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      ),
    );
  }
}
