import 'package:flutter/material.dart';
import 'package:zad_almumin/components/my_app_bar.dart';
import 'package:zad_almumin/components/my_drawer.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/pages/ayahsTest/components/questions_footer.dart';
import '../../components/my_circular_progress_indecator.dart';
import '../../constents/icons.dart';
import '../../constents/sizes.dart';
import '../../services/json_service.dart';
import 'classes/ayah_prop.dart';
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

  AyahsQuestionsCtr ctr = Get.find<AyahsQuestionsCtr>();
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
                  future: JsonService.getRandomAyah(),
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
                          QuestionCard(selectedAyah: selectedAyah),
                          QuestionButtons(selectedAyah: selectedAyah),
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
