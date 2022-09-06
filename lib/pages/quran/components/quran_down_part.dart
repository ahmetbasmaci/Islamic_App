import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/components/my_circular_progress_indecator.dart';
import '../../../constents/colors.dart';
import '../../../constents/icons.dart';
import '../../../constents/texts.dart';
import '../../../moduls/enums.dart';
import '../../../services/audio_service.dart';
import '../../../services/http_service.dart';
import '../../../services/json_service.dart';
import '../classes/ayah.dart';
import '../classes/quran_helper.dart';
import '../controllers/quran_page_ctr.dart';

class QuranDownPart extends StatelessWidget {
  QuranDownPart({Key? key, required this.animationCtr, required this.audioService}) : super(key: key);
  QuranPageCtr quranCtr = Get.find<QuranPageCtr>();
  final double _downPartHeight = Get.size.height * .2;
  final double _loadingRowHeight = Get.size.height * .03;

  int animationDurationMilliseconds = 600;

  late AudioService audioService;
  late AnimationController animationCtr;
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      bottom: quranCtr.onShown.value ? 0 : -_downPartHeight,
      child: Obx(
        () => AnimatedContainer(
            duration: Duration(milliseconds: animationDurationMilliseconds),
            height: Get.find<HttpServiceCtr>().isLoading.value ? _downPartHeight + _loadingRowHeight : _downPartHeight,
            width: Get.size.width,
            decoration: BoxDecoration(
              color: MyColors.quranBackGround(),
              boxShadow: [
                BoxShadow(
                  color: MyColors.whiteBlack().withOpacity(0.2),
                  offset: Offset(0, 5),
                  blurRadius: 30,
                  spreadRadius: .5,
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Obx(
                  () => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      MyTexts.quranSecondTitle(title: quranCtr.selectedSurah.surahName.value),
                      MyTexts.quranSecondTitle(title: quranCtr.selectedSurah.pageNumber.value.toString()),
                      MyTexts.quranSecondTitle(title: 'الجزء ${quranCtr.selectedSurah.juz.value}'),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    selectStartEndAyah(true),
                    AnimatedContainer(
                      duration: Duration(milliseconds: animationDurationMilliseconds),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: MyColors.quranBackGround(),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          // BoxShadow(color: MyColors.quranSecond().withOpacity(0.2), blurRadius: 30, spreadRadius: 10),
                        ],
                      ),
                      child: Obx(
                        () => DropdownButton<QuranReaders>(
                          value: quranCtr.selectedSurah.selectedQuranReader.value,
                          onChanged: (newVal) {
                            quranCtr.selectedSurah.selectedQuranReader.value = newVal!;
                            GetStorage()
                                .write('selectedQuranReader', quranCtr.selectedSurah.selectedQuranReader.value.index);
                          },
                          items: [
                            for (QuranReaders item in QuranReaders.values)
                              DropdownMenuItem(
                                value: item,
                                child: MyTexts.quranSecondTitle(title: item.arabicName),
                              )
                          ],
                        ),
                      ),
                    ),
                    selectStartEndAyah(false),
                  ],
                ),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 600),
                  opacity: Get.find<HttpServiceCtr>().isLoading.value ? 1 : 0,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 600),
                    height: Get.find<HttpServiceCtr>().isLoading.value ? _loadingRowHeight : 0,
                    width: double.maxFinite,
                    decoration: BoxDecoration(boxShadow: []),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: LinearProgressIndicator(
                            value: Get.find<HttpServiceCtr>().received.value,
                            backgroundColor: Colors.grey,
                            color: MyColors.quranSecond(),
                          ),
                        ),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MyTexts.quranSecondTitle(
                                title:
                                    '${Get.find<HttpServiceCtr>().downloadingIndex}/${Get.find<HttpServiceCtr>().totalAyahsDownload}'),
                            IconButton(
                              onPressed: () {
                                Get.find<HttpServiceCtr>().isStopDownload.value = true;
                                Get.find<HttpServiceCtr>().isLoading.value = false;
                                // stopAudio();
                              },
                              icon: MyIcons.close(color: MyColors.quranSecond()),
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                        icon: MyIcons.repeat(color: MyColors.quranSecond()), onPressed: () async => showRepeatDialog()),
                    IconButton(
                      icon: AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        progress: animationCtr,
                        color: MyColors.quranSecond(),
                        size: 25,
                      ),
                      onPressed: () async {
                        if (animationCtr.isDismissed)
                          playAudio();
                        else
                          pauseAudio();
                      },
                    ),
                    IconButton(icon: MyIcons.stop(color: MyColors.quranSecond()), onPressed: () => stopAudio()),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  Widget selectStartEndAyah(bool isStartAyah) {
    return Row(
      children: [
        MyTexts.quranSecondTitle(title: isStartAyah ? 'من الاية:  ' : 'الى الاية:  '),
        SizedBox(
          width: Get.size.width * .18,
          child: MaterialButton(
            shape: Border.all(color: MyColors.quranSecond()),
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MyTexts.quranSecondTitle(title: 'اختر الاية:  '),
                      MyTexts.quranSecondTitle(title: quranCtr.selectedSurah.surahNumber.value.toString()),
                    ],
                  ),
                  content: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(200)),
                    height: Get.size.height * .5,
                    child: FutureBuilder(
                      future: getSurahAyahsList(isStartAyah),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Widget> dataList = snapshot.data as List<Widget>;

                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: dataList,
                            ),
                          );
                        } else
                          return MyCircularProgressIndecator();
                      },
                    ),
                  ),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Obx(
                  () => MyTexts.content(
                      title: isStartAyah
                          ? quranCtr.selectedSurah.startAyahNum.value.toString()
                          : quranCtr.selectedSurah.endAyahNum.value.toString(),
                      size: 10),
                ),
                Icon(Icons.keyboard_arrow_down, color: MyColors.quranSecond()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<List<Widget>> getSurahAyahsList(bool isStartAyah) async {
    List<Widget> list = [];
    Map quranMap = await JsonService.getAllHadithData(quranCtr.selectedSurah.surahNumber.value);
    int startFrom = isStartAyah ? 1 : quranCtr.selectedSurah.startAyahNum.value;
    for (var i = startFrom; i <= quranCtr.selectedSurah.totalAyahsNum.value; i++) {
      String ayah = '';
      if (quranMap.isNotEmpty) ayah = quranMap['ayahs'][i - 1]['text'].toString();

      list.add(
        Container(
          //TODO make the ayahs in one line
          height: Get.height * .08,
          width: double.maxFinite,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 0),
          color: isStartAyah
              ? i == quranCtr.selectedSurah.startAyahNum.value
                  ? MyColors.quranSecond().withOpacity(.4)
                  : Colors.transparent
              : i == quranCtr.selectedSurah.endAyahNum.value
                  ? MyColors.quranSecond().withOpacity(.4)
                  : Colors.transparent,
          child: MaterialButton(
            onPressed: () {
              if (isStartAyah)
                quranCtr.selectedSurah.startAyahNum.value = i;
              else
                quranCtr.selectedSurah.endAyahNum.value = i;

              if (quranCtr.selectedSurah.startAyahNum.value > quranCtr.selectedSurah.endAyahNum.value)
                quranCtr.selectedSurah.endAyahNum.value = quranCtr.selectedSurah.totalAyahsNum.value;

              Get.back();

              QuranHelper().changeCurrentPageToWhereStartRead();
            },
            child: SingleChildScrollView(
              padding: null,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  MyTexts.quran(title: '$i - ', textAlign: TextAlign.start, fontWeight: FontWeight.bold),
                  MyTexts.quran(title: ayah, textAlign: TextAlign.start),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return list;
  }

  void showRepeatDialog() {}

  void playAudio() async {
    animationCtr.forward();
    int surahNumber = quranCtr.selectedSurah.surahNumber.value;
    List<Ayah> ayahsFileList = await HttpService.getSurah(surahNumber: surahNumber);
    audioService.playSurahAudio(ayahsFileList);
  }

  void pauseAudio() {
    animationCtr.reverse();
    AudioService().pauseAudio();
  }

  void stopAudio() {
    animationCtr.reverse();
    AudioService().stopAudio();
  }
}
