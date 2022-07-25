import 'package:flutter/material.dart';
import 'package:zad_almumin/components/main_container.dart';
import 'package:zad_almumin/components/my_app_bar.dart';
import 'package:zad_almumin/components/my_drawer.dart';
import 'package:zad_almumin/pages/ayahsTest/components/question.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/pages/ayahsTest/components/questions_footer.dart';
import 'controller/first_ayahs_in_pages_ctr.dart';

class FirstAyahsInPages extends StatefulWidget {
  const FirstAyahsInPages({Key? key}) : super(key: key);
  static String id = 'FirstAyahsInPages';
  @override
  State<FirstAyahsInPages> createState() => _FirstAyahsInPagesState();
}

class _FirstAyahsInPagesState extends State<FirstAyahsInPages> {
  @override
  void initState() {
    super.initState();
  }

  FirstAyahsInPagesCtr ctr = Get.put(FirstAyahsInPagesCtr());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: MyAppBar(title: 'مراجعة القران'),
        drawer: MyDrawer(),
        body: mainContainer(
            child: Column(
          children: [
            Expanded(
              child: Question(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: QuestionsFooter(
                pageSetState: () {
                  setState(() {});
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}
