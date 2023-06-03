import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:zad_almumin/components/my_app_bar.dart';
import 'package:zad_almumin/components/my_drawer.dart';
import 'package:zad_almumin/constents/constants.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/constents/my_sizes.dart';
import 'package:zad_almumin/constents/my_texts.dart';
import 'package:zad_almumin/services/theme_service.dart';

class ReviewPage extends GetView<ThemeCtr> {
  ReviewPage({super.key});
  static String id = 'ReviewPage';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController reviewTxtCtr = TextEditingController();
  TextEditingController nameTxtCtr = TextEditingController();
  RxBool isLoading = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "ملاحظة للمطور".tr),
      drawer: MyDrawer(),
      body: Obx(() {
        return ModalProgressHUD(
          inAsyncCall: isLoading.value,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: MySiezes.screenPadding),
            height: Get.height,
            child: ListView(
              shrinkWrap: true,
              children: [
                Focus(
                  focusNode: AppSettings.focusScopeNode,
                  child: TextField(
                    maxLength: 30,
                    controller: nameTxtCtr,
                    style: MyTexts.main(title: "").style,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(2, 2, 5, 2),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      counterText: "",
                      hintText: 'الاسم :'.tr,
                    ),
                  ),
                ),
                SizedBox(height: Get.height * .05),
                Focus(
                  focusNode: AppSettings.focusScopeNode,
                  child: TextField(
                    controller: reviewTxtCtr,
                    minLines: 5,
                    maxLines: 15,
                    style: MyTexts.main(title: "").style,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(2, 2, 5, 2),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      counterText: "",
                      hintText: 'الملاحظة :'.tr,
                    ),
                  ),
                ),
                SizedBox(height: Get.height * .05),
                ElevatedButton(
                  onPressed: () => sentReviewToDeveloper(),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  child: MyTexts.main(title: 'ارسال'.tr, color: MyColors.white),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void sentReviewToDeveloper() async {
    if (nameTxtCtr.text.isEmpty) {
      Fluttertoast.showToast(msg: 'الرجاء التأكد من كتابة الاسم'.tr);
      return;
    } else if (reviewTxtCtr.text.isEmpty) {
      Fluttertoast.showToast(msg: 'الرجاء التأكد من كتابة الملاحظة'.tr);
      return;
    }
    try {
      isLoading.value = true;
      List<dynamic> allData = [];
      var oldData = await _firestore.collection('users').doc(AppSettings.machineCode).get();
      if (oldData.data() != null) {
        allData = oldData['data'];
      }
      allData.add({'review': reviewTxtCtr.text, 'name': nameTxtCtr.text});
      await _firestore.collection('users').doc(AppSettings.machineCode).set({'data': allData});
      reviewTxtCtr.clear();
      nameTxtCtr.clear();
      Fluttertoast.showToast(msg: 'تم ارسال الرسالة للمطور بنجاح'.tr);
    } catch (e) {
      Fluttertoast.showToast(msg: 'حدث خطأ ما الرجاء المحاولة مرة اخرى'.tr);
    }
    isLoading.value = false;
  }
}
