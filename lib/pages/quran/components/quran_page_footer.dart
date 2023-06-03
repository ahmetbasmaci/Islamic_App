import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/components/my_circular_progress_indecator.dart';
import 'package:zad_almumin/constents/constants.dart';
import 'package:zad_almumin/constents/my_sizes.dart';
import 'package:zad_almumin/pages/quran/models/quran_data.dart';
import 'package:zad_almumin/pages/quran/models/surah.dart';
import '../../../services/audio_ctr.dart';
import '../../../constents/my_colors.dart';
import '../../../constents/my_icons.dart';
import '../../../constents/my_texts.dart';
import '../../../moduls/enums.dart';
import '../../../services/http_service.dart';
import '../models/ayah.dart';
import '../controllers/quran_page_ctr.dart';

class QuranPageFooter extends StatelessWidget {
  QuranPageFooter({Key? key}) : super(key: key);
  final QuranPageCtr _quranCtr = Get.find<QuranPageCtr>();
  final QuranData _quranDataCtr = Get.find<QuranData>();

  final double _downPartHeight = Get.size.height * .12;
  final double _loadingRowHeight = Get.size.height * .04;
  final AudioCtr _audioCtr = Get.find<AudioCtr>();
  final HttpCtr _httpCtr = Get.find<HttpCtr>();
  int animationDurationMilliseconds = 600;
  final QuranData _quranData = Get.find<QuranData>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          bottom: _quranCtr.onShown.value ? 0 : -_downPartHeight,
          child: AnimatedContainer(
            duration: Duration(milliseconds: animationDurationMilliseconds),
            height: _httpCtr.isLoading.value ? _loadingRowHeight + _downPartHeight : _downPartHeight,
            width: Get.size.width,
            decoration: BoxDecoration(
              color: MyColors.quranBackGround(),
              boxShadow: [
                BoxShadow(
                  color: MyColors.quranPrimary().withOpacity(.5),
                  offset: Offset(0, 5),
                  blurRadius: 30,
                  spreadRadius: .5,
                )
              ],
            ),
            child: Column(
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
                                _audioCtr.stopAudio();
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
                    DropdownButton<QuranReaders>(
                      //underline: Container(),
                      //alignment: Alignment.bottomRight,
                      //isExpanded: true,
                      iconEnabledColor: MyColors.quranPrimary(),
                      dropdownColor: MyColors.quranBackGround(),
                      value: _quranCtr.selectedPage.selectedQuranReader.value,
                      menuMaxHeight: Get.size.height * .3,
                      onChanged: (newVal) {
                        _quranCtr.selectedPage.selectedQuranReader.value = newVal!;
                        GetStorage()
                            .write('selectedQuranReader', _quranCtr.selectedPage.selectedQuranReader.value.index);
                      },
                      items: [
                        for (QuranReaders item in QuranReaders.values)
                          DropdownMenuItem(
                            value: item,
                            child: MyTexts.quranSecondTitle(title: item.arabicName.tr),
                          )
                      ],
                    ),
                    DropdownButton<String>(
                      //underline: Container(),
                      //alignment: Alignment.bottomRight,
                      //isExpanded: true,
                      iconEnabledColor: MyColors.quranPrimary(),
                      dropdownColor: MyColors.quranBackGround(),
                      value: _quranCtr.selectedPage.surahName.value,
                      menuMaxHeight: Get.size.height * .3,
                      onChanged: (newVal) {
                        if (newVal != null) {
                          Surah surah = _quranData.getSurahByName(newVal);
                          _quranCtr.selectedPage.surahName.value = surah.name;
                          _quranCtr.selectedPage.surahNumber.value = _quranData.getSurahNumberByName(surah.name);
                          _quranCtr.selectedPage.startAyahNum.value = 1;
                          _quranCtr.selectedPage.endAyahNum.value = surah.ayahs.length;
                          _quranCtr.selectedPage.juz.value = _quranData.getJuzNumberByPage(surah.ayahs[1].page);
                          _quranCtr.selectedPage.pageNumber.value = surah.ayahs[1].page;

                          _quranCtr.updateCurrentPageToWhereStartRead();
                        }
                      },
                      items: [
                        for (Surah item in _quranData.getAllSurahs())
                          DropdownMenuItem(
                            value: item.name,
                            child: MyTexts.quranSecondTitle(title: AppSettings.removeTashkil(item.name.toString()).tr),
                          )
                      ],
                    ),
                    // Container(
                    //   child:
                    //       MyTexts.quranSecondTitle(title: '${'الصفحة'.tr} :${_quranCtr.selectedPage.pageNumber.value}'),
                    // ),
                    // Container(
                    //   child: MyTexts.quranSecondTitle(title: 'الجزء  :${_quranCtr.selectedPage.juz.value}'),
                    // ),
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
                        onTap: () async => showResitationSettings(),
                      ),
                    ),
                    Card(
                      color: MyColors.quranBackGround(),
                      child: InkWell(
                        child: MyIcons.animated_Play_Pause(color: MyColors.quranPrimary(), size: MySiezes.icon * 1.2),
                        onTap: () => _quranCtr.playPauseBtnPress(),
                      ),
                    ),
                    Card(
                      color: MyColors.quranBackGround(),
                      child: InkWell(
                        child: MyIcons.stop(color: MyColors.quranPrimary(), size: MySiezes.icon * 1.2),
                        onTap: () => _audioCtr.stopAudio(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showResitationSettings() {
    Get.dialog(
      AlertDialog(
        backgroundColor: MyColors.quranBackGround(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyTexts.quranSecondTitle(title: 'اعدادات القراءة'.tr, fontWeight: FontWeight.bold),
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
              //changeFontSize(),
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
        MyTexts.quranSecondTitle(title: 'القارئ:'.tr, fontWeight: FontWeight.bold),
        AnimatedContainer(
          duration: Duration(milliseconds: animationDurationMilliseconds),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Obx(
            () => DropdownButton<QuranReaders>(
              value: _quranCtr.selectedPage.selectedQuranReader.value,
              menuMaxHeight: Get.size.height * .3,
              onChanged: (newVal) {
                _quranCtr.selectedPage.selectedQuranReader.value = newVal!;
                GetStorage().write('selectedQuranReader', _quranCtr.selectedPage.selectedQuranReader.value.index);
              },
              items: [
                for (QuranReaders item in QuranReaders.values)
                  DropdownMenuItem(
                    value: item,
                    child: MyTexts.quranSecondTitle(title: item.arabicName.tr),
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
            MyTexts.quranSecondTitle(title: 'تحديد المقطع:'.tr, fontWeight: FontWeight.bold),
            MyTexts.quranSecondTitle(
              title: _quranData.getSurahNameByNumber(_quranCtr.selectedPage.surahNumber.value),
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        startEndAyahsSelections(true),
        SizedBox(height: MySiezes.betweanCardItems),
        startEndAyahsSelections(false),
      ],
    );
  }

  Widget startEndAyahsSelections(bool isStartAyah) {
    return Row(
      children: [
        MyTexts.quranSecondTitle(title: isStartAyah ? 'من الآية:  '.tr : 'الى الآية :  '.tr),
        SizedBox(
          width: Get.size.width * .5,
          height: Get.size.height * .04,
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: MyColors.quranPrimary()),
            ),
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  backgroundColor: MyColors.quranBackGround(),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MyTexts.quranSecondTitle(title: 'اختر الآية:  '),
                      MyTexts.quranSecondTitle(
                          title: _quranData.getSurahNameByNumber(_quranCtr.selectedPage.surahNumber.value)),
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
                            controller: ScrollController(),
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
                  () => Expanded(
                    child: RichText(
                      maxLines: 1,
                      text: TextSpan(
                        text: isStartAyah
                            ? '${_quranCtr.selectedPage.startAyahNum.value} - '
                            : '${_quranCtr.selectedPage.endAyahNum.value} - ',
                        style: MyTexts.main(title: '').style!.copyWith(fontWeight: FontWeight.bold, fontSize: 15),
                        children: [
                          TextSpan(
                            text: isStartAyah
                                ? _quranDataCtr
                                    .getAyah(_quranCtr.selectedPage.surahNumber.value,
                                        _quranCtr.selectedPage.startAyahNum.value)
                                    .text
                                : _quranDataCtr
                                    .getAyah(_quranCtr.selectedPage.surahNumber.value,
                                        _quranCtr.selectedPage.endAyahNum.value)
                                    .text,
                            style: TextStyle(overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    ),
                  ),
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
        MyTexts.quranSecondTitle(title: 'تكرار التلاوة:  '.tr, fontWeight: FontWeight.bold),
        Row(
          children: <Widget>[
            MyTexts.quranSecondTitle(title: 'المقطع :  '.tr),
            Obx(
              () => MyTexts.quranSecondTitle(
                  title: _quranCtr.selectedPage.repeetAllCount.value.toString(), fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () => _quranCtr.selectedPage.repeetAllCount.value++,
              icon: MyIcons.plus(color: MyColors.quranPrimary()),
            ),
            IconButton(
              onPressed: () {
                if (_quranCtr.selectedPage.repeetAllCount.value != 1) _quranCtr.selectedPage.repeetAllCount.value--;
              },
              icon: MyIcons.minus(color: MyColors.quranPrimary()),
            ),
            Obx(
              () => Checkbox(
                fillColor: MaterialStateProperty.all(MyColors.quranPrimary()),
                value: _quranCtr.selectedPage.isUnlimitRepeatAll.value,
                onChanged: ((value) => _quranCtr.selectedPage.isUnlimitRepeatAll.value = value ?? false),
              ),
            ),
            MyTexts.quranSecondTitle(title: 'لا محدود'.tr),
          ],
        ),
        Row(
          children: <Widget>[
            MyTexts.quranSecondTitle(title: 'الآية   :  '.tr),
            Obx(
              () => MyTexts.quranSecondTitle(
                  title: _quranCtr.selectedPage.repeetAyahCount.value.toString(), fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () => _quranCtr.selectedPage.repeetAyahCount.value++,
              icon: MyIcons.plus(color: MyColors.quranPrimary()),
            ),
            IconButton(
              onPressed: () {
                if (_quranCtr.selectedPage.repeetAyahCount.value != 1) _quranCtr.selectedPage.repeetAyahCount.value--;
              },
              icon: MyIcons.minus(color: MyColors.quranPrimary()),
            ),
            Obx(
              () => Checkbox(
                fillColor: MaterialStateProperty.all(MyColors.quranPrimary()),
                value: _quranCtr.selectedPage.isUnlimitRepeatAyah.value,
                onChanged: ((value) => _quranCtr.selectedPage.isUnlimitRepeatAyah.value = value ?? false),
              ),
            ),
            MyTexts.quranSecondTitle(title: 'لا محدود'.tr),
          ],
        ),
      ],
    );
  }

  Future<List<Widget>> getSurahAyahsList(bool isStartAyah) async {
    List<Widget> list = [];
    List<Ayah> ayahs = _quranData.getSurahAyahs(_quranCtr.selectedPage.surahNumber.value);

    int startFrom = isStartAyah ? 1 : _quranCtr.selectedPage.startAyahNum.value;
    for (var i = startFrom; i <= ayahs.length; i++) {
      list.add(
        Container(
          height: Get.height * .08,
          width: double.maxFinite,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 0),
          color: isStartAyah
              ? i == _quranCtr.selectedPage.startAyahNum.value
                  ? MyColors.quranPrimary().withOpacity(.4)
                  : Colors.transparent
              : i == _quranCtr.selectedPage.endAyahNum.value
                  ? MyColors.quranPrimary().withOpacity(.4)
                  : Colors.transparent,
          child: MaterialButton(
            onPressed: () {
              if (isStartAyah)
                _quranCtr.selectedPage.startAyahNum.value = i;
              else
                _quranCtr.selectedPage.endAyahNum.value = i;

              if (_quranCtr.selectedPage.startAyahNum.value > _quranCtr.selectedPage.endAyahNum.value)
                _quranCtr.selectedPage.endAyahNum.value = _quranCtr.selectedPage.totalAyahsNum.value;

              Get.back();
              if (isStartAyah) _quranCtr.selectedAyah.value = ayahs.elementAt(i);
              _quranCtr.updateCurrentPageToWhereStartRead();
            },
            child: SingleChildScrollView(
              padding: null,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  MyTexts.main(title: '$i - ', textAlign: TextAlign.start, fontWeight: FontWeight.bold),
                  MyTexts.main(title: ayahs[i - 1].text, textAlign: TextAlign.start),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return list;
  }
}
