import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zad_almumin/components/my_app_bar.dart';
import 'package:zad_almumin/components/my_drawer.dart';
import 'package:zad_almumin/pages/ayahsTest/components/question.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/pages/ayahsTest/components/questions_footer.dart';
import '../../animations/my_animations.dart';
import '../../components/my_circular_progress_indecator.dart';
import '../../constents/colors.dart';
import '../../constents/icons.dart';
import '../../constents/sizes.dart';
import '../../constents/texts.dart';
import '../../moduls/enums.dart';
import '../../services/json_service.dart';
import 'classes/ayah_prop.dart';
import 'classes/option_btn_props.dart';
import 'components/question_button.dart';
import 'controller/first_ayahs_in_pages_ctr.dart';

class FirstAyahsInPages extends StatefulWidget {
  const FirstAyahsInPages({Key? key}) : super(key: key);
  static String id = 'FirstAyahsInPages';
  @override
  State<FirstAyahsInPages> createState() => _FirstAyahsInPagesState();
}

class _FirstAyahsInPagesState extends State<FirstAyahsInPages> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    animCtr = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    rightToLeftAnim = Tween<Offset>(begin: Offset(1500, 0), end: Offset(0, 0)).animate(animCtr);
  }

  FirstAyahsInPagesCtr ctr = Get.find<FirstAyahsInPagesCtr>();
  late AyahProp selectedAyah;
  late AnimationController animCtr;
  late Animation rightToLeftAnim;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'مراجعة القران'),
      drawer: MyDrawer(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: MySiezes.screenPadding),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: JsonService.getAyahForQuestion(context),
                  builder: (context, AsyncSnapshot<AyahProp> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return MyCircularProgressIndecator();
                    else if (snapshot.hasError)
                      return Center(
                        child: Column(
                          children: [
                            IconButton(onPressed: () => setState(() {}), icon: MyIcons.refresh),
                            Text(snapshot.error.toString()),
                          ],
                        ),
                      );

                    selectedAyah = snapshot.data!;

                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          questionTitle(),
                          QuestionButtons(selectedAyah: selectedAyah, questionBtnProps: getRandomJuzAndPages()),
                        ],
                      ),
                    );
                  }),
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
        ),
      ),
    );
  }

  Container questionTitle() {
    return Container(
      padding: EdgeInsets.all(MySiezes.cardPadding * 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MySiezes.blockRadius),
        color: MyColors.zikrCard(),
        border: Border.all(color: Colors.black, width: 1),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.6), blurRadius: 5, offset: Offset(0, 5)),
        ],
      ),
      child: MyTexts.quran(
        title: ctr.questionType.value == QuestionType.ayahInJuzAndPage ? selectedAyah.ayah : selectedAyah.surah,
      ),
    );
  }

  List<OptionBtnProps> getRandomJuzAndPages() {
    List<OptionBtnProps> list = [];
    int page1 = 0;
    int page2 = 0;
    int page3 = 0;
    int juz1 = 0;
    int juz2 = 0;
    int juz3 = 0;

    //check if page1 is not the same as page2 and in arrange betwean 1 and 20
    int random = Random().nextInt(3);
    if (random == 0) {
      page1 = selectedAyah.page - 1 > 0 ? selectedAyah.page - 1 : selectedAyah.page + 1;
      page2 = selectedAyah.page - 2 > 0 ? selectedAyah.page - 2 : selectedAyah.page + 2;
      page3 = selectedAyah.page - 3 > 0 ? selectedAyah.page - 3 : selectedAyah.page + 3;

      juz1 = selectedAyah.juz - 1 > 0 ? selectedAyah.juz - 1 : selectedAyah.juz + 1;
      juz2 = selectedAyah.juz - 2 > 0 ? selectedAyah.juz - 2 : selectedAyah.juz + 2;
      juz3 = selectedAyah.juz - 3 > 0 ? selectedAyah.juz - 3 : selectedAyah.juz + 3;
    } else if (random == 1) {
      page1 = selectedAyah.page - 1 > 0 ? selectedAyah.page - 1 : selectedAyah.page + 2;
      page2 = selectedAyah.page - 2 > 0 ? selectedAyah.page - 2 : selectedAyah.page + 3;
      page3 = selectedAyah.page + 1 < 21 ? selectedAyah.page + 1 : selectedAyah.page - 3;

      juz1 = selectedAyah.juz - 1 > 0 ? selectedAyah.juz - 1 : selectedAyah.juz + 2;
      juz2 = selectedAyah.juz - 2 > 0 ? selectedAyah.juz - 2 : selectedAyah.juz + 3;
      juz3 = selectedAyah.juz + 1 < 31 ? selectedAyah.juz + 1 : selectedAyah.juz - 3;
    } else if (random == 2) {
      page1 = selectedAyah.page - 1 > 0 ? selectedAyah.page - 2 : selectedAyah.page + 3;
      page2 = selectedAyah.page + 1 < 21 ? selectedAyah.page + 1 : selectedAyah.page - 1;
      page3 = selectedAyah.page + 2 < 21 ? selectedAyah.page + 2 : selectedAyah.page - 2;

      juz1 = selectedAyah.juz - 1 > 0 ? selectedAyah.juz - 2 : selectedAyah.juz + 3;
      juz2 = selectedAyah.juz + 1 < 31 ? selectedAyah.juz + 1 : selectedAyah.juz - 1;
      juz3 = selectedAyah.juz + 2 < 31 ? selectedAyah.juz + 2 : selectedAyah.juz - 2;
    } else if (random == 3) {
      page1 = selectedAyah.page + 1 < 21 ? selectedAyah.page + 1 : selectedAyah.page - 1;
      page2 = selectedAyah.page + 2 < 21 ? selectedAyah.page + 2 : selectedAyah.page - 2;
      page3 = selectedAyah.page + 3 < 21 ? selectedAyah.page + 3 : selectedAyah.page - 3;

      juz1 = selectedAyah.juz + 1 < 31 ? selectedAyah.juz + 1 : selectedAyah.juz - 1;
      juz2 = selectedAyah.juz + 2 < 31 ? selectedAyah.juz + 2 : selectedAyah.juz - 2;
      juz3 = selectedAyah.juz + 3 < 31 ? selectedAyah.juz + 3 : selectedAyah.juz - 3;
    }

    list.add(OptionBtnProps(juz: selectedAyah.juz, page: selectedAyah.page));
    list.add(OptionBtnProps(juz: juz1, page: page1));
    list.add(OptionBtnProps(juz: juz2, page: page2));
    list.add(OptionBtnProps(juz: juz3, page: page3));
    list.shuffle(); //resort randomly
    return list;
  }
}
