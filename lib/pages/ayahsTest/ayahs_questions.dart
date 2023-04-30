import 'package:flutter/material.dart';
import 'package:zad_almumin/components/my_app_bar.dart';
import 'package:zad_almumin/components/my_drawer.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/my_texts.dart';
import 'package:zad_almumin/pages/ayahsTest/components/questions_footer.dart';
import 'package:zad_almumin/pages/quran/models/quran_data.dart';
import 'package:zad_almumin/pages/quran/models/ayah.dart';
import '../../components/my_circular_progress_indecator.dart';
import '../../constents/my_icons.dart';
import '../../constents/my_sizes.dart';
import 'components/question_button.dart';
import 'components/question_card.dart';
import 'controller/ayahs_questions_ctr.dart';

class AyahsQuestions extends StatefulWidget {
  const AyahsQuestions({Key? key}) : super(key: key);
  static String id = 'AyahsQuestions';
  @override
  State<AyahsQuestions> createState() => _AyahsQuestionsState();
}

class _AyahsQuestionsState extends State<AyahsQuestions> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    animCtr = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    rightToLeftAnim = Tween<Offset>(begin: Offset(1500, 0), end: Offset(0, 0)).animate(animCtr);
  }

  final QuranData _quranData = Get.find<QuranData>();
  AyahsQuestionsCtr ctr = Get.find<AyahsQuestionsCtr>();
  late Ayah selectedAyah;
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
            MyTexts.outsideHeader(title: "اختبر حفظك للقران واختر رقم الصفحة والجزء للاية"),
            Expanded(
              child: FutureBuilder(
                  future: Future.delayed(Duration(seconds: 0)).then((value) => _quranData.getRandomPageStartAyah()),
                  builder: (context, AsyncSnapshot<Ayah> snapshot) {
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
                          QuestionCard(ayah: selectedAyah),
                          QuestionAnswerOptions(selectedAyah: selectedAyah),
                        ],
                      ),
                    );
                  }),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: QuestionsFooter(pageSetState: () => setState(() {})),
            ),
          ],
        ),
      ),
    );
  }
}
