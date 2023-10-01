import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zad_almumin/classes/helper_methods.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/constents/my_sizes.dart';
import 'package:zad_almumin/pages/quran/controllers/quran/quran_page_ctr.dart';
import 'package:zad_almumin/services/audio_ctr.dart';
import 'package:zad_almumin/services/http_service.dart';

import '../models/ayah.dart';

class BotToastDialog {
  static final QuranPageCtr _quranCtr = Get.find<QuranPageCtr>();
  static final AudioCtr _audioCtr = Get.find<AudioCtr>();
  static final HttpCtr _httpCtr = Get.find<HttpCtr>();
  static void showToastDialog({required LongPressStartDetails details, required Ayah ayah}) {
    BotToast.showAttachedWidget(
      target: details.globalPosition,
      animationDuration: Duration(microseconds: 700),
      animationReverseDuration: Duration(microseconds: 700),
      attachedBuilder: (cancel) => Card(
        color: MyColors.quranBackGround,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _addAyahMarkBtn(cancel, ayah),
              SizedBox(width: MySiezes.icon / 2),
              _copyAyahBtn(cancel, ayah),
              SizedBox(width: MySiezes.icon / 2),
              _playAyahBtn(cancel, ayah),
              SizedBox(width: MySiezes.icon / 2),
              _shareBtn(cancel, ayah),
            ],
          ),
        ),
      ),
    );
  }

  static Container _addAyahMarkBtn(CancelFunc cancel, Ayah ayah) {
    return Container(
      height: MySiezes.icon * 2,
      width: MySiezes.icon * 2,
      decoration: BoxDecoration(color: MyColors.blackWhite, borderRadius: BorderRadius.all(Radius.circular(50))),
      child: IconButton(
        icon: Icon(ayah.isMarked ? Icons.bookmark : Icons.bookmark_border,
            size: MySiezes.icon, color: MyColors.quranPrimary),
        onPressed: () {
          _quranCtr.addRemoveAyahMark(ayah);
          cancel();
        },
      ),
    );
  }

  static Container _copyAyahBtn(CancelFunc cancel, Ayah ayah) {
    return Container(
      height: MySiezes.icon * 2,
      width: MySiezes.icon * 2,
      decoration: BoxDecoration(
        color: MyColors.blackWhite,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: IconButton(
        icon: Icon(
          Icons.copy_outlined,
          size: MySiezes.icon,
          color: MyColors.quranPrimary,
        ),
        onPressed: () {
          HelperMethods.copyText(ayah.text);
          cancel();
        },
      ),
    );
  }

  static Container _playAyahBtn(CancelFunc cancel, Ayah ayah) {
    return Container(
      height: MySiezes.icon * 2,
      decoration: BoxDecoration(color: MyColors.blackWhite, borderRadius: BorderRadius.all(Radius.circular(50))),
      child: IconButton(
        icon: Icon(
          Icons.play_circle,
          size: MySiezes.icon,
          color: MyColors.quranPrimary,
        ),
        onPressed: () async {
          cancel();
          List<Ayah> ayahsList = await HttpService.getSurah(surahNumber: ayah.surahNumber);
          _quranCtr.selectedPage.startAyahNum.value = ayah.ayahNumber;
          _quranCtr.changeOnShownState(false);
          _audioCtr.stopAudio();
          if (_httpCtr.downloadComplated.value) {
            _audioCtr.playMultiAudio(ayahList: ayahsList);
          }
        },
      ),
    );
  }

  static Container _shareBtn(CancelFunc cancel, Ayah ayah) {
    return Container(
      height: MySiezes.icon * 2,
      width: MySiezes.icon * 2,
      decoration: BoxDecoration(color: MyColors.blackWhite, borderRadius: BorderRadius.all(Radius.circular(50))),
      child: IconButton(
        icon: Icon(
          Icons.share_outlined,
          size: MySiezes.icon,
          color: MyColors.quranPrimary,
        ),
        onPressed: () {
          Share.share(ayah.text, subject: ayah.surahName);
          cancel();
        },
      ),
    );
  }
}
