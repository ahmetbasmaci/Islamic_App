import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/components/my_circular_progress_indecator.dart';
import 'package:zad_almumin/constents/my_sizes.dart';
import 'package:zad_almumin/pages/quran/models/quran_data.dart';
import '../../../services/audio_ctr.dart';
import '../../../constents/my_colors.dart';
import '../../../constents/my_icons.dart';
import '../../../constents/my_texts.dart';
import '../../../moduls/enums.dart';
import '../../../services/http_service.dart';
import '../models/ayah.dart';
import '../classes/quran_helper.dart';
import '../controllers/quran_page_ctr.dart';

class QuranPageFooter extends StatelessWidget {
  QuranPageFooter({Key? key}) : super(key: key);
  final QuranPageCtr _quranCtr = Get.find<QuranPageCtr>();
  final double _downPartHeight = Get.size.height * .2;
  final double _loadingRowHeight = Get.size.height * .03;
  final AudioCtr _audioCtr = Get.find<AudioCtr>();
  final HttpCtr _httpCtr = Get.find<HttpCtr>();
  int animationDurationMilliseconds = 600;
  final QuranData _quranData = Get.find<QuranData>();
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      bottom: _quranCtr.onShown.value ? 0 : -_downPartHeight,
      child: AnimatedContainer(
        duration: Duration(milliseconds: animationDurationMilliseconds),
        height: _downPartHeight,
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
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              AnimatedOpacity(
                duration: Duration(milliseconds: 600),
                opacity: _httpCtr.isLoading.value ? 1 : 0,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  height: _httpCtr.isLoading.value ? _loadingRowHeight : 0,
                  width: double.maxFinite,
                  decoration: BoxDecoration(boxShadow: []),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: LinearProgressIndicator(
                          value: _httpCtr.downloadProgress.value == 0 ? 0 : _httpCtr.downloadProgress.value / 100,
                          backgroundColor: Colors.grey,
                          color: MyColors.quranPrimary(),
                        ),
                      ),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MyTexts.quranSecondTitle(title: '${(_httpCtr.downloadProgress.value).toStringAsFixed(1)}%'),
                          AnimatedButton(
                            color: MyColors.quranBackGround(),
                            width: MySiezes.btnIcon,
                            height: MySiezes.btnIcon,
                            onPressed: () {
                              _httpCtr.isStopDownload.value = true;
                              _httpCtr.isLoading.value = false;
                              //  stopAudio();
                            },
                            child: MyIcons.close(color: MyColors.quranPrimary()),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  MyTexts.quranSecondTitle(title: _quranCtr.selectedSurah.selectedQuranReader.value.arabicName),
                  MyTexts.quranSecondTitle(title: _quranCtr.selectedSurah.surahName.value),
                  MyTexts.quranSecondTitle(title: 'الصفحة :${_quranCtr.selectedSurah.pageNumber.value}'),
                  MyTexts.quranSecondTitle(title: 'الجزء  :${_quranCtr.selectedSurah.juz.value}'),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Card(
                    color: MyColors.quranBackGround(),
                    child: InkWell(
                        child: MyIcons.settings(color: MyColors.quranPrimary(), size: MySiezes.icon * 1.2),
                        onTap: () async => showResitationSettings()),
                  ),
                  Card(
                    color: MyColors.quranBackGround(),
                    child: InkWell(
                      child: MyIcons.animated_Play_Pause(color: MyColors.quranPrimary(), size: MySiezes.icon * 1.2),
                      onTap: () {
                        if (_audioCtr.isPlaying.value)
                          pauseAudio();
                        else
                          playAudio();
                      },
                    ),
                  ),
                  Card(
                      color: MyColors.quranBackGround(),
                      child: InkWell(
                          child: MyIcons.stop(color: MyColors.quranPrimary(), size: MySiezes.icon * 1.2),
                          onTap: () => stopAudio())),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showResitationSettings() {
    Get.dialog(
      AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyTexts.quranSecondTitle(title: 'اعدادات القراءة', fontWeight: FontWeight.bold),
          ],
        ),
        content: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(200)),
          height: Get.size.height * .6,
          width: Get.size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              selectReader(),
              Divider(),
              selectAyahsLimits(),
              Divider(),
              selectRepeet(),
              Divider(),
              changeFontSize(),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectReader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyTexts.quranSecondTitle(title: 'القارئ:', fontWeight: FontWeight.bold),
        AnimatedContainer(
          duration: Duration(milliseconds: animationDurationMilliseconds),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Obx(
            () => DropdownButton<QuranReaders>(
              value: _quranCtr.selectedSurah.selectedQuranReader.value,
              menuMaxHeight: Get.size.height * .3,
              onChanged: (newVal) {
                _quranCtr.selectedSurah.selectedQuranReader.value = newVal!;
                GetStorage().write('selectedQuranReader', _quranCtr.selectedSurah.selectedQuranReader.value.index);
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
      ],
    );
  }

  Widget selectAyahsLimits() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyTexts.quranSecondTitle(title: 'تحديد المقطع:', fontWeight: FontWeight.bold),
            MyTexts.quranSecondTitle(
              title: _quranData.getSurahNameByNumber(_quranCtr.selectedSurah.surahNumber.value),
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        startEndAyahsSelections(true),
        startEndAyahsSelections(false),
      ],
    );
  }

  Widget startEndAyahsSelections(bool isStartAyah) {
    return Row(
      children: [
        MyTexts.quranSecondTitle(title: isStartAyah ? 'من الاية:  ' : 'الى الاية :  '),
        SizedBox(
          width: Get.size.width * .18,
          child: MaterialButton(
            shape: Border.all(color: MyColors.quranPrimary()),
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MyTexts.quranSecondTitle(title: 'اختر الاية:  '),
                      MyTexts.quranSecondTitle(
                          title: _quranData.getSurahNameByNumber(_quranCtr.selectedSurah.surahNumber.value)),
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
                          ? _quranCtr.selectedSurah.startAyahNum.value.toString()
                          : _quranCtr.selectedSurah.endAyahNum.value.toString(),
                      size: 10),
                ),
                Icon(Icons.keyboard_arrow_down, color: MyColors.quranPrimary()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget selectRepeet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTexts.quranSecondTitle(title: 'تكرار التلاوة:  ', fontWeight: FontWeight.bold),
        Row(
          children: <Widget>[
            MyTexts.quranSecondTitle(title: 'المقطع    :  '),
            Obx(
              () => MyTexts.quranSecondTitle(
                  title: _quranCtr.selectedSurah.repeetAllCount.value.toString(), fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () => _quranCtr.selectedSurah.repeetAllCount.value++,
              icon: MyIcons.plus(color: MyColors.quranPrimary()),
            ),
            IconButton(
              onPressed: () {
                if (_quranCtr.selectedSurah.repeetAllCount.value != 1) _quranCtr.selectedSurah.repeetAllCount.value--;
              },
              icon: MyIcons.minus(color: MyColors.quranPrimary()),
            ),
            Obx(
              () => Checkbox(
                fillColor: MaterialStateProperty.all(MyColors.quranPrimary()),
                value: _quranCtr.selectedSurah.isUnlimitRepeatAll.value,
                onChanged: ((value) => _quranCtr.selectedSurah.isUnlimitRepeatAll.value = value ?? false),
              ),
            ),
            MyTexts.quranSecondTitle(title: 'لا محدود'),
          ],
        ),
        Row(
          children: <Widget>[
            MyTexts.quranSecondTitle(title: 'الاية      :  '),
            Obx(
              () => MyTexts.quranSecondTitle(
                  title: _quranCtr.selectedSurah.repeetAyahCount.value.toString(), fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () => _quranCtr.selectedSurah.repeetAyahCount.value++,
              icon: MyIcons.plus(color: MyColors.quranPrimary()),
            ),
            IconButton(
              onPressed: () {
                if (_quranCtr.selectedSurah.repeetAyahCount.value != 1) _quranCtr.selectedSurah.repeetAyahCount.value--;
              },
              icon: MyIcons.minus(color: MyColors.quranPrimary()),
            ),
            Obx(
              () => Checkbox(
                fillColor: MaterialStateProperty.all(MyColors.quranPrimary()),
                value: _quranCtr.selectedSurah.isUnlimitRepeatAyah.value,
                onChanged: ((value) => _quranCtr.selectedSurah.isUnlimitRepeatAyah.value = value ?? false),
              ),
            ),
            MyTexts.quranSecondTitle(title: 'لا محدود'),
          ],
        ),
      ],
    );
  }

  Future<List<Widget>> getSurahAyahsList(bool isStartAyah) async {
    List<Widget> list = [];
    List<Ayah> ayahs = _quranData.getSurahByNumber(_quranCtr.selectedSurah.surahNumber.value).ayahs;
    int startFrom = isStartAyah ? 1 : _quranCtr.selectedSurah.startAyahNum.value;
    for (var i = startFrom; i <= _quranCtr.selectedSurah.totalAyahsNum.value; i++) {
      list.add(
        Container(
          height: Get.height * .08,
          width: double.maxFinite,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 0),
          color: isStartAyah
              ? i == _quranCtr.selectedSurah.startAyahNum.value
                  ? MyColors.quranPrimary().withOpacity(.4)
                  : Colors.transparent
              : i == _quranCtr.selectedSurah.endAyahNum.value
                  ? MyColors.quranPrimary().withOpacity(.4)
                  : Colors.transparent,
          child: MaterialButton(
            onPressed: () {
              if (isStartAyah)
                _quranCtr.selectedSurah.startAyahNum.value = i;
              else
                _quranCtr.selectedSurah.endAyahNum.value = i;

              if (_quranCtr.selectedSurah.startAyahNum.value > _quranCtr.selectedSurah.endAyahNum.value)
                _quranCtr.selectedSurah.endAyahNum.value = _quranCtr.selectedSurah.totalAyahsNum.value;

              Get.back();

              QuranHelper().changeCurrentPageToWhereStartRead();
            },
            child: SingleChildScrollView(
              padding: null,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  MyTexts.quran(title: '$i - ', textAlign: TextAlign.start, fontWeight: FontWeight.bold),
                  MyTexts.quran(title: ayahs[i - 1].text, textAlign: TextAlign.start),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return list;
  }

  Widget changeFontSize() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MyIcons.letter(color: MyColors.quranPrimary()),
        SizedBox(width: Get.width * .04),
        MyTexts.quran(title: "حجم الخط", color: MyColors.quranPrimary(), size: 16),
        Obx(
          () => SizedBox(
            width: Get.width * .4,
            child: Slider(
              max: (Get.width * Get.height * 0.000090),
              min: (Get.width * Get.height * 0.000060),
              activeColor: MyColors.quranPrimary(),
              thumbColor: MyColors.quranBackGround(),
              value: _quranCtr.quranFontSize.value,
              onChanged: (val) => _quranCtr.updateQuranFontSize(val),
            ),
          ),
        )
      ],
    );
  }

  void playAudio() async {
    List<Ayah> ayahsList = await HttpService.getSurah(surahNumber: _quranCtr.selectedSurah.surahNumber.value);
    _audioCtr.playMultiAudio(
      ayahList: ayahsList,
    );
  }

  void pauseAudio() async {
    _audioCtr.pauseAudio();
    //await reverseAnimation();
  }

  void stopAudio() async {
    _audioCtr.stopAudio();
    //await reverseAnimation();
  }
}
