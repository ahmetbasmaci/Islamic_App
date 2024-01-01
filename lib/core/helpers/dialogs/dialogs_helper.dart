import 'package:flutter/material.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/helpers/navigator_helper.dart';
import 'package:zad_almumin/core/utils/constants.dart';
import '../../utils/resources/resources.dart';
import '../../widget/dialogs/alert_dialog_ok_no.dart';

class DialogsHelper {
  static Future<bool> showEnableLocationServiceDialog() async {
    bool okHitted = false;
    //TODO
    await showDialog(
      context: Constants.context,
      builder: (context) => AlertDialogOkNo(
        title: "تشغيل خدمات الموقع الجغرافي",
        content:
            "يجمع زاد المؤمن بيانات الموقع الجغرافي  لتحديد مواقيت الصلاة الخاصة بك حتى إذا كان التطبيق مغلقًا أو لم يكن قيد الاستخدام",
        okText: "حسنا",
        noText: "رفض",
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
      context: Constants.context,
      builder: (context) => AlertDialogOkNo(
        title: "طلب الاذن بالوصول للموقع الحالي",
        content:
            "يجمع زاد المؤمن بيانات الموقع الجغرافي  لتحديد مواقيت الصلاة الخاصة بك حتى إذا كان التطبيق مغلقًا أو لم يكن قيد الاستخدام",
        okText: "حسنا",
        noText: "رفض",
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
}
