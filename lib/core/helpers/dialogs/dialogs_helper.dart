import 'package:flutter/material.dart';
import 'package:zad_almumin/core/helpers/navigator_helper.dart';
import 'package:zad_almumin/core/utils/constants.dart';
import '../../widget/dialogs/alert_dialog_ok_no.dart';

class DialogsHelper {
  static Future<bool> showEnableLocationServiceDialog() async {
    bool okHitted = false;
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


  
}

