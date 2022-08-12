import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/pages/ayahsTest/controller/first_ayahs_in_pages_ctr.dart';
import '../../../animations/my_animations.dart';
import '../../../components/my_circular_progress_indecator.dart';
import '../../../constents/colors.dart';
import '../../../constents/sizes.dart';
import '../../../constents/texts.dart';
import '../../../moduls/enums.dart';
import '../classes/ayah_prop.dart';
import '../classes/option_btn_props.dart';
import 'option_button.dart';

// ignore: must_be_immutable
class Question extends StatelessWidget {
  Question({Key? key}) : super(key: key);

  final FirstAyahsInPagesCtr ctr = Get.find<FirstAyahsInPagesCtr>();
  late AyahProp selectedAyah;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: MySiezes.betweanAzkarBlock),
      child: FutureBuilder(
          future: getRandomAyah(context),
          builder: (context, AsyncSnapshot<AyahProp> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return MyCircularProgressIndecator();
            else if (snapshot.hasError)
              return Column(
                children: [
                  // IconButton(onPressed: () => setState(() {}), icon: MyIcons.refresh),
                  Text(snapshot.error.toString()),
                ],
              );

            selectedAyah = snapshot.data!;

            return MyAnimations.fadeOut(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.all(MySiezes.cardPadding * 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(MySiezes.blockRadius),
                        color: MyColors.zikrCard(),
                        border: Border.all(color: Colors.black, width: 1),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(.6), blurRadius: 5, offset: Offset(0, 5)),
                        ],
                      ),
                      child: MyTexts.content(
                        context,
                        title: ctr.questionType.value == QuestionType.ayahInJusAndPage
                            ? selectedAyah.ayah
                            : selectedAyah.surah,
                      ),
                    ),
                    OptionButton(selectedAyah: selectedAyah, optionBtnProps: getRandomJuzAndPages()),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Future<AyahProp> getRandomAyah(BuildContext context) async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/database/quran/firstAyahsFromEachPage/first_ayahs_from_each_page.json');

    List juzs = json.decode(jsonString);

    int randomJuz = ctr.juzFrom.value - 1;
    if (ctr.juzTo.value != ctr.juzFrom.value)
      randomJuz = Random().nextInt(ctr.juzTo.value - ctr.juzFrom.value) + ctr.juzFrom.value;

    int randomPage = ctr.pageFrom.value - 1;
    if (ctr.pageTo.value != ctr.pageFrom.value)
      randomPage = Random().nextInt(ctr.pageTo.value - ctr.pageFrom.value) + ctr.pageFrom.value;

    AyahProp selectedAyah = AyahProp.fromJson(juzs[randomJuz][randomPage]);
    return selectedAyah;
  }

  List<OptionBtnProps> getRandomJuzAndPages() {
    List<OptionBtnProps> list = [];
    list.add(OptionBtnProps(juz: selectedAyah.juz, page: selectedAyah.page));
    for (int i = 1; i <= 3; i++) {
      int randomJuz = Random().nextInt(30) + 1;
      int randomPage = ctr.pageFrom.value;
      if (ctr.pageFrom != ctr.pageTo)
        randomPage = Random().nextInt(ctr.pageTo.value - ctr.pageFrom.value) + ctr.pageFrom.value;
      list.add(OptionBtnProps(juz: randomJuz, page: randomPage));
    }
    list.shuffle(); //resort randomly
    return list;
  }
}
