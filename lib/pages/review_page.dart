import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/components/my_app_bar.dart';
import 'package:zad_almumin/components/my_drawer.dart';
import 'package:zad_almumin/constents/constants.dart';
import 'package:zad_almumin/constents/my_sizes.dart';
import 'package:zad_almumin/constents/my_texts.dart';
import 'package:zad_almumin/services/theme_service.dart';

class ReviewPage extends GetView<ThemeCtr> {
  ReviewPage({super.key});
  static String id = 'ReviewPage';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var reviewTxtCtr = TextEditingController();
  var nameTxtCtr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "ملاحظة للمطور"),
      drawer: MyDrawer(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: MySiezes.screenPadding),
        height: Get.height,
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: Get.height * .1,
              child: Focus(
                focusNode: Constants.focusScopeNode,
                child: TextField(
                  maxLength: 30,
                  controller: nameTxtCtr,
                  style: MyTexts.quran(title: "").style,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(2, 2, 5, 2),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    counterText: "",
                    hintText: 'الاسم :',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * .4,
              child: Focus(
                focusNode: Constants.focusScopeNode,
                child: TextField(
                  controller: reviewTxtCtr,
                  minLines: 5,
                  maxLines: 15,
                  style: MyTexts.quran(title: "").style,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(2, 2, 5, 2),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    counterText: "",
                    hintText: 'الملاحظة :',
                  ),
                ),
              ),
            ),
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
              child: MyTexts.quran(title: 'ارسال'),
            ),
          ],
        ),
      ),
    );
  }

  sentReviewToDeveloper() async {
    if (nameTxtCtr.text.isEmpty) {
      Fluttertoast.showToast(msg: 'الرجاء التأكد من كتابة الاسم');
      return;
    } else if (reviewTxtCtr.text.isEmpty) {
      Fluttertoast.showToast(msg: 'الرجاء التأكد من كتابة الملاحظة');
      return;
    }
    try {
      List<dynamic> allData = [];
      var oldData = await _firestore.collection('users').doc(Constants.machineCode).get();
      if (oldData['data'] != null) {
        allData = oldData['data'];
      }
      allData.add({'review': reviewTxtCtr.text, 'name': nameTxtCtr.text});
      await _firestore.collection('users').doc(Constants.machineCode).set({'data': allData});
      reviewTxtCtr.clear();
      nameTxtCtr.clear();
      Fluttertoast.showToast(msg: 'تم ارسال الرسالة للمطور بنجاح');
    } catch (e) {
      Fluttertoast.showToast(msg: 'حدث خطأ ما الرجاء المحاولة مرة اخرى');
    }
  }
}
