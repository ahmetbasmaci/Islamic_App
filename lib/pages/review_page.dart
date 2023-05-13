import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
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
          children: [SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                 Expanded(child: Container()),
                SizedBox(
                  height: Get.height * .1,
                  child: Focus(
                    focusNode: Constants.focusScopeNode,
                    child: TextField(
                      controller: nameTxtCtr,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(2, 2, 5, 2),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        counterText: "",
                        hintText: 'الاسم',
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
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(2, 2, 5, 2),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        counterText: "",
                        hintText: 'الملاحظة',
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => sentReviewToDeveloper(),
                  // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                  style: ButtonStyle(
                    // backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  child: MyTexts.quran(title: 'ارسال'),
                ),
              ],
            ),
          )],
        ),
      ),
    );
  }

  sentReviewToDeveloper() async {
    if (reviewTxtCtr.text.isEmpty) {
      Fluttertoast.showToast(msg: 'الرجاء التأكد من كتابة الملاحظة');
      return;
    } else if (nameTxtCtr.text.isEmpty) {
      Fluttertoast.showToast(msg: 'الرجاء التأكد من كتابة الاسم');
      return;
    }
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
  }
}
