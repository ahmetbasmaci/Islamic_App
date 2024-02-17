import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/helpers/navigator_helper.dart';
import 'package:zad_almumin/core/utils/resources/app_constants.dart';
import 'package:zad_almumin/core/widget/space/space.dart';
import '../../features/quran/quran.dart';
import '../utils/resources/resources.dart';
import '../widget/buttons/buttons.dart';
import '../widget/dialogs/alert_dialog_ok_no.dart';

class DialogsHelper {
  DialogsHelper._();
  static Future<bool> showEnableLocationServiceDialog() async {
    bool okHitted = false;
    //TODO
    await showDialog(
      context: AppConstants.context,
      builder: (context) => AlertDialogOkNo(
        title: "تشغيل خدمات الموقع الجغرافي",
        content:
            "يجمع زاد المؤمن بيانات الموقع الجغرافي  لتحديد مواقيت الصلاة الخاصة بك حتى إذا كان التطبيق مغلقًا أو لم يكن قيد الاستخدام",
        onOk: () async {
          okHitted = true;
          NavigatorHelper.pop();
        },
        onNo: () {
          NavigatorHelper.pop();
        },
      ),
    );
    return okHitted;
  }

  static Future<bool> showAllowAppToUseLocationDialog() async {
    bool okHitted = false;
    //TODO
    await showDialog(
      context: AppConstants.context,
      builder: (context) => AlertDialogOkNo(
        title: "طلب الاذن بالوصول للموقع الحالي",
        content:
            "يجمع زاد المؤمن بيانات الموقع الجغرافي  لتحديد مواقيت الصلاة الخاصة بك حتى إذا كان التطبيق مغلقًا أو لم يكن قيد الاستخدام",
        onOk: () async {
          okHitted = true;
          NavigatorHelper.pop();
        },
        onNo: () {
          NavigatorHelper.pop();
        },
      ),
    );
    return okHitted;
  }

  static Future<void> showCostumDialog({
    required BuildContext context,
    required Widget title,
    required Widget child,
    double? height,
    double? width,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(AppSizes.screenPadding),
          title: title,
          content: Container(
            decoration: BoxDecoration(
              // color: context.themeColors.background,
              borderRadius: BorderRadius.circular(AppSizes.cardRadius),
            ),
            height: height ?? context.height * .6,
            width: context.width,
            child: child,
          ),
        );
      },
    );
  }

  static Future<bool> showAddQuranPageMarkDialog(MarkedPage pageProp) async {
    //TODO
    bool okHitted = false;
    String title = pageProp.isMarked ? 'ازالة علامة قراءة' : 'اضافة علامة قراءة';
    String content =
        pageProp.isMarked ? 'هل تود ازالة علامة القراءة من هذه الصفحة؟' : 'هل تود وضع علامة على هذه الصفحة؟';

    await showDialog(
      context: AppConstants.context,
      builder: (context) => AlertDialogOkNo(
        title: title,
        content: content,
        onOk: () async {
          okHitted = true;
          NavigatorHelper.pop();
        },
        onNo: () {
          NavigatorHelper.pop();
        },
      ),
    );
    return okHitted;
  }

  static void showSelectAyahBotToatsDialog({
    required BuildContext context,
    required LongPressStartDetails details,
    required Ayah ayah,
  }) {
    BotToast.showAttachedWidget(
      target: details.globalPosition,
      animationDuration: const Duration(microseconds: 700),
      animationReverseDuration: const Duration(microseconds: 700),
      attachedBuilder: (cancel) => Card(
        color: AppConstants.context.themeColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AddBookMarkButton(
                isMarked: ayah.isMarked,
                ayah: ayah,
                onDone: () {
                  ayah.isMarked = !ayah.isMarked;
                  cancel();
                },
              ),
              HorizontalSpace(AppSizes.spaceBetweanWidgets),
              CopyButton(
                content: ayah.text,
                onDone: () => cancel(),
              ),
              HorizontalSpace(AppSizes.spaceBetweanWidgets),
              AudioPlayPauseButton(
                isPlaying: false,
                isLoading: false,
                onPressed: () {
                  // cancel();
                  // List<Ayah> ayahsList = await HttpService.getSurah(surahNumber: ayah.surahNumber);
                  // _quranCtr.selectedPage.startAyahNum.value = ayah.ayahNumber;
                  // _quranCtr.selectedPage.endAyahNum.value = ayahsList.last.ayahNumber;
                  // _quranCtr.selectedPage.surahName.value = ayah.surahName;
                  // _quranCtr.selectedPage.surahNumber.value = ayah.surahNumber;
                  // _quranCtr.selectedPage.totalAyahsNum.value = ayahsList.length;
                  // _quranCtr.changeOnShownState(false);

                  // if (_httpCtr.downloadComplated.value) {
                  //   AudioService.playMultiAudio(ayahList: ayahsList);
                  // }
                },
                onDone: () => cancel(),
              ),
              HorizontalSpace(AppSizes.spaceBetweanWidgets),
              ShareButton(
                content: ayah.text,
                onDone: () => cancel(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
