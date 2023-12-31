// import 'package:animated_button/animated_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:zad_almumin/core/extentions/extentions.dart';
// import 'package:zad_almumin/core/utils/resources/resources.dart';
// import 'package:zad_almumin/features/quran/quran.dart';

// import '../../../../../core/utils/enums/enums.dart';

// class QuranPageFooter extends StatelessWidget {
//   const QuranPageFooter({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final double downPartHeight = context.height * .12;
//     final double loadingRowHeight = context.height * .04;
//     QuranState state = context.watch<QuranCubit>().state;
//     return AnimatedPositioned(
//       duration: const Duration(milliseconds: 300),
//       bottom: state.showTopFooterPart ? 0 : -downPartHeight,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         height: state.isLoading ? loadingRowHeight + downPartHeight : downPartHeight,
//         width: context.width,
//         decoration: AppDecorations.quranBottmCard(context),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             AnimatedOpacity(
//               duration: const Duration(milliseconds: 600),
//               opacity: state.isLoading ? 1 : 0,
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 600),
//                 height: state.isLoading ? loadingRowHeight : 0,
//                 width: double.maxFinite,
//                 decoration: const BoxDecoration(boxShadow: []),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Expanded(
//                       flex: 3,
//                       child: LinearProgressIndicator(
//                         value: state.downloadProgress == 0 ? 0 : state.downloadProgress / 100,
//                         backgroundColor: Colors.grey,
//                         color: context.themeColors.primary,
//                       ),
//                     ),
//                     Expanded(
//                         child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Text('${(state.downloadProgress).toStringAsFixed(0)}%'),
//                         IconButton(
//                           onPressed: () {
//                             //TODO
//                             // state.isStopDownload = true;
//                             // state.isLoading = false;
//                             // AudioService.stopAudio();
//                           },
//                           icon: AppIcons.close,
//                         ),
//                       ],
//                     )),
//                   ],
//                 ),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 DropdownButton<QuranReaders>(
//                   // iconEnabledColor: MyColors.quranPrimary,
//                   // dropdownColor: MyColors.quranBackGround,
//                   value: state.selectedPageInfo.selectedQuranReader,
//                   menuMaxHeight: context.height * .3,
//                   onChanged: (newVal) {
//                     //TODO
//                     // state.selectedPage.selectedQuranReader = newVal!;
//                     // GetStorage().write('selectedQuranReader', _quranCtr.selectedPage.selectedQuranReader.value.index);
//                   },
//                   items: [
//                     for (QuranReaders item in sortedQuranReader)
//                       DropdownMenuItem(
//                         value: item,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Text(
//                               item.translatedName,
//                               style: AppStyles.content.copyWith(
//                                   color: state.selectedPageInfo.selectedQuranReader == item
//                                       ? context.themeColors.primary
//                                       : context.themeColors.onBackground),
//                             ),
//                             IconButton(
//                               onPressed: () {
//                                 //TODO
//                                 // NavigatorHelper.pushNamed(route)

//                                 // .to(() => ReaderQuranDownloadPage(reader: item),
//                                 //     transition: Transition.cupertinoDialog,
//                                 //     duration: const Duration(milliseconds: 200));
//                               },
//                               icon: AppIcons.info,
//                             )
//                           ],
//                         ),
//                       ),
//                   ],
//                 ),
//                 DropdownButton<String>(
//                   // iconEnabledColor: MyColors.quranPrimary,
//                   // dropdownColor: MyColors.quranBackGround,
//                   value: state.selectedPageInfo.surahName,
//                   menuMaxHeight: context.height * .3,
//                   onChanged: (newVal) {
//                     //TODO
//                     // if (newVal != null) {
//                     //   Surah surah = _quranData.getSurahByName(newVal);
//                     //   _quranCtr.selectedPage.surahName.value = surah.name;
//                     //   _quranCtr.selectedPage.surahNumber.value = _quranData.getSurahNumberByName(surah.name);
//                     //   _quranCtr.selectedPage.startAyahNum.value = 1;
//                     //   _quranCtr.selectedPage.endAyahNum.value = surah.ayahs.length;
//                     //   _quranCtr.selectedPage.juz.value = _quranData.getJuzNumberByPage(surah.ayahs[1].page);
//                     //   _quranCtr.selectedPage.pageNumber.value = surah.ayahs[1].page;

//                     //   _quranCtr.updateCurrentPageToWhereStartRead();
//                     // }
//                   },
//                   items: [
//                     for (Surah item in context.read<QuranCubit>().alSurahs)
//                       DropdownMenuItem(
//                         value: item.name,
//                         child: Text(
//                           item.name.toString().withOutTashkil,
//                           style: AppStyles.content.copyWith(
//                             color: state.selectedPageInfo.surahName == item.name
//                                 ? context.themeColors.primary
//                                 : context.themeColors.onBackground,
//                           ),
//                         ),
//                       )
//                   ],
//                 ),
//                 // Container(
//                 //   child:
//                 //       MyTexts.quranSecondTitle(title: '${'الصفحة'.tr} :${_quranCtr.selectedPage.pageNumber.value}'),
//                 // ),
//                 // Container(
//                 //   child: MyTexts.quranSecondTitle(title: 'الجزء  :${_quranCtr.selectedPage.juz.value}'),
//                 // ),
//               ],
//             ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 Card(
//                   child: Tooltip(
//                     message: "ضبط اعدادات القراءة",
//                     child: InkWell(
//                       child: AppIcons.settings,
//                       onTap: () async => showResitationSettings(),
//                     ),
//                   ),
//                 ),
//                 Card(
//                   child: InkWell(
//                       child: AppIcons.animatedPlayPause(context), onTap: () {} //TODO=> _quranCtr.playPauseBtnPress(),
//                       ),
//                 ),
//                 Card(
//                   color: MyColors.quranBackGround,
//                   child: InkWell(
//                     child: AppIcons.stop(color: MyColors.quranPrimary, size: MySiezes.icon * 1.2),
//                     onTap: () => _quranCtr.stopAudio(),
//                   ),
//                 ),
//                 Card(
//                   color: MyColors.quranBackGround,
//                   child: Tooltip(
//                     message: "التنقل بين القران والتفسير".tr,
//                     child: InkWell(
//                       child: Obx(() =>
//                           AppIcons.animated_swichQuranTafseer(color: MyColors.primary, size: MySiezes.icon * 1.2)),
//                       onTap: () async {
//                         List<SurahTafseer> allTafseer = Get.find<TafseersCtr>().allTafseer;
//                         if (allTafseer.isEmpty) {
//                           Get.to(() => TafseersPage(),
//                               transition: Transition.cupertinoDialog, duration: const Duration(milliseconds: 200));
//                           return;
//                         }
//                         _quranCtr.changeShowQuranStyle();
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   List<QuranReaders> get sortedQuranReader {
//     if (AppSettings.isArabicLang) {
//       return QuranReaders.values.toList()..sort((a, b) => a.arabicName.compareTo(b.arabicName));
//     } else {
//       return QuranReaders.values.toList()..sort((a, b) => a.name.compareTo(b.name));
//     }
//   }

//   void showResitationSettings() {
//     Get.dialog(
//       AlertDialog(
//         backgroundColor: MyColors.quranBackGround,
//         contentPadding: EdgeInsets.all(MySiezes.screenPadding),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             MyTexts.quranSecondTitle(title: 'اعدادات القراءة'.tr, fontWeight: FontWeight.bold),
//           ],
//         ),
//         content: Container(
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(200)),
//           height: context.height * .6,
//           //width: context.width,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               selectReader(),
//               const Divider(),
//               selectAyahsLimits(),
//               const Divider(),
//               // selectRepeet(),
//               // Divider(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget selectReader() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         MyTexts.quranSecondTitle(title: 'القارئ:'.tr, fontWeight: FontWeight.bold),
//         AnimatedContainer(
//           duration: Duration(milliseconds: animationDurationMilliseconds),
//           padding: const EdgeInsets.all(5),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Obx(
//             () => DropdownButton<QuranReaders>(
//               value: _quranCtr.selectedPage.selectedQuranReader.value,
//               menuMaxHeight: context.height * .3,
//               onChanged: (newVal) {
//                 _quranCtr.selectedPage.selectedQuranReader.value = newVal!;
//                 GetStorage().write('selectedQuranReader', _quranCtr.selectedPage.selectedQuranReader.value.index);
//               },
//               items: [
//                 for (QuranReaders item in QuranReaders.values)
//                   DropdownMenuItem(
//                     value: item,
//                     child: MyTexts.quranSecondTitle(
//                       title: item.arabicName.tr,
//                       color: item == _quranCtr.selectedPage.selectedQuranReader.value
//                           ? MyColors.primary
//                           : MyColors.whiteBlack,
//                     ),
//                   )
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget selectAyahsLimits() {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             MyTexts.quranSecondTitle(title: 'تحديد المقطع:'.tr, fontWeight: FontWeight.bold),
//             MyTexts.quranSecondTitle(
//               title: _quranData.getSurahNameByNumber(_quranCtr.selectedPage.surahNumber.value),
//               fontWeight: FontWeight.bold,
//             ),
//           ],
//         ),
//         SizedBox(height: MySiezes.betweanCardItems),
//         startEndAyahsSelections(true),
//         SizedBox(height: MySiezes.betweanCardItems),
//         startEndAyahsSelections(false),
//       ],
//     );
//   }

//   Widget startEndAyahsSelections(bool isStartAyah) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         MyTexts.main(title: isStartAyah ? 'من الآية:'.tr : 'الى الآية:'.tr),
//         SizedBox(width: MySiezes.betweanCardItems),
//         SizedBox(
//           width: context.width * .5,
//           height: context.height * .04,
//           child: MaterialButton(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.0),
//               side: BorderSide(color: MyColors.quranPrimary),
//             ),
//             onPressed: () {
//               Get.dialog(
//                 AlertDialog(
//                   backgroundColor: MyColors.quranBackGround,
//                   title: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       MyTexts.quranSecondTitle(title: 'اختر الآية:  '.tr),
//                       MyTexts.quranSecondTitle(
//                         title: AppSettings.removeTashkil(
//                                 _quranData.getSurahNameByNumber(_quranCtr.selectedPage.surahNumber.value))
//                             .tr,
//                       ),
//                     ],
//                   ),
//                   content: Container(
//                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(200)),
//                     height: context.height * .5,
//                     child: FutureBuilder(
//                       future: getSurahAyahsList(isStartAyah),
//                       builder: (context, snapshot) {
//                         if (snapshot.hasData) {
//                           List<Widget> dataList = snapshot.data as List<Widget>;

//                           return SingleChildScrollView(
//                             controller: ScrollController(),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: dataList,
//                             ),
//                           );
//                         } else
//                           return MyIndicator(size: 0);
//                       },
//                     ),
//                   ),
//                 ),
//               );
//             },
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Obx(
//                   () => Expanded(
//                     child: RichText(
//                       maxLines: 1,
//                       text: TextSpan(
//                         text: isStartAyah
//                             ? '${_quranCtr.selectedPage.startAyahNum.value} - '
//                             : '${_quranCtr.selectedPage.endAyahNum.value} - ',
//                         style: MyTexts.mainStyle().copyWith(fontWeight: FontWeight.bold, fontSize: 15),
//                         children: [
//                           TextSpan(
//                             text: isStartAyah
//                                 ? _quranDataCtr
//                                     .getAyah(_quranCtr.selectedPage.surahNumber.value,
//                                         _quranCtr.selectedPage.startAyahNum.value)
//                                     .text
//                                 : _quranDataCtr
//                                     .getAyah(_quranCtr.selectedPage.surahNumber.value,
//                                         _quranCtr.selectedPage.endAyahNum.value)
//                                     .text,
//                             style: const TextStyle(overflow: TextOverflow.ellipsis),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Icon(Icons.keyboard_arrow_down, color: MyColors.quranPrimary),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget selectRepeet() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         MyTexts.quranSecondTitle(title: 'تكرار التلاوة:  '.tr, fontWeight: FontWeight.bold),
//         Obx(
//           () => Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               AnimatedOpacity(
//                 opacity: _quranCtr.selectedPage.isUnlimitRepeatAll.value ? 0.5 : 1,
//                 duration: const Duration(milliseconds: 200),
//                 child: Row(
//                   children: <Widget>[
//                     MyTexts.main(title: 'المقطع :  '.tr),
//                     MyTexts.main(
//                       title: _quranCtr.selectedPage.repeetAllCount.value.toString(),
//                       fontWeight: FontWeight.bold,
//                     ),
//                     IconButton(
//                       onPressed: _quranCtr.selectedPage.isUnlimitRepeatAll.value
//                           ? null
//                           : () => _quranCtr.selectedPage.repeetAllCount.value++,
//                       icon: AppIcons.plus(),
//                     ),
//                     IconButton(
//                       onPressed: _quranCtr.selectedPage.isUnlimitRepeatAll.value
//                           ? null
//                           : () {
//                               if (_quranCtr.selectedPage.repeetAllCount.value != 1)
//                                 _quranCtr.selectedPage.repeetAllCount.value--;
//                             },
//                       icon: AppIcons.minus(),
//                     ),
//                   ],
//                 ),
//               ),
//               Checkbox(
//                 fillColor: MaterialStateProperty.all<Color>(MyColors.quranBackGround),
//                 checkColor: MyColors.primary,
//                 overlayColor: MaterialStateProperty.all(MyColors.black.withOpacity(.1)),
//                 value: _quranCtr.selectedPage.isUnlimitRepeatAll.value,
//                 onChanged: ((value) => _quranCtr.selectedPage.isUnlimitRepeatAll.value = value ?? false),
//               ),
//               MyTexts.main(title: 'لا محدود'.tr),
//             ],
//           ),
//         ),
//         Obx(
//           () => Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               AnimatedOpacity(
//                 opacity: _quranCtr.selectedPage.isUnlimitRepeatAyah.value ? 0.5 : 1,
//                 duration: const Duration(milliseconds: 200),
//                 child: Row(
//                   children: <Widget>[
//                     MyTexts.main(title: 'الآية   :  '.tr),
//                     Obx(
//                       () => MyTexts.main(
//                         title: _quranCtr.selectedPage.repeetAyahCount.value.toString(),
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: _quranCtr.selectedPage.isUnlimitRepeatAyah.value
//                           ? null
//                           : () => _quranCtr.selectedPage.repeetAyahCount.value++,
//                       icon: AppIcons.plus(),
//                     ),
//                     IconButton(
//                       onPressed: _quranCtr.selectedPage.isUnlimitRepeatAyah.value
//                           ? null
//                           : () {
//                               if (_quranCtr.selectedPage.repeetAyahCount.value != 1)
//                                 _quranCtr.selectedPage.repeetAyahCount.value--;
//                             },
//                       icon: AppIcons.minus(),
//                     ),
//                   ],
//                 ),
//               ),
//               Obx(
//                 () => Checkbox(
//                   fillColor: MaterialStateProperty.all<Color>(MyColors.quranBackGround),
//                   checkColor: MyColors.primary,
//                   overlayColor: MaterialStateProperty.all(MyColors.black.withOpacity(.1)),
//                   value: _quranCtr.selectedPage.isUnlimitRepeatAyah.value,
//                   onChanged: ((value) => _quranCtr.selectedPage.isUnlimitRepeatAyah.value = value ?? false),
//                 ),
//               ),
//               MyTexts.main(title: 'لا محدود'.tr),
//             ],
//           ),
//         )
//       ],
//     );
//   }

//   Future<List<Widget>> getSurahAyahsList(bool isStartAyah) async {
//     List<Widget> list = [];
//     List<Ayah> ayahs = _quranData.getSurahAyahs(_quranCtr.selectedPage.surahNumber.value);

//     int startFrom = isStartAyah ? 1 : _quranCtr.selectedPage.startAyahNum.value;
//     for (var i = startFrom; i <= ayahs.length; i++) {
//       list.add(
//         Container(
//           height: Get.height * .08,
//           width: double.maxFinite,
//           alignment: Alignment.centerRight,
//           padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0),
//           color: isStartAyah
//               ? i == _quranCtr.selectedPage.startAyahNum.value
//                   ? MyColors.quranPrimary.withOpacity(.4)
//                   : Colors.transparent
//               : i == _quranCtr.selectedPage.endAyahNum.value
//                   ? MyColors.quranPrimary.withOpacity(.4)
//                   : Colors.transparent,
//           child: MaterialButton(
//             onPressed: () {
//               if (isStartAyah)
//                 _quranCtr.selectedPage.startAyahNum.value = i - 1;
//               else
//                 _quranCtr.selectedPage.endAyahNum.value = i - 1;

//               if (_quranCtr.selectedPage.startAyahNum.value > _quranCtr.selectedPage.endAyahNum.value)
//                 _quranCtr.selectedPage.endAyahNum.value = _quranCtr.selectedPage.totalAyahsNum.value;

//               Get.back();
//               if (isStartAyah) _quranCtr.updateSelectedAyah(ayahs.elementAt(i), index: i);
//               _quranCtr.updateCurrentPageToWhereStartRead();
//             },
//             child: SingleChildScrollView(
//               padding: null,
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: <Widget>[
//                   MyTexts.main(title: '$i - ', textAlign: TextAlign.start, fontWeight: FontWeight.bold),
//                   MyTexts.main(title: ayahs[i - 1].text, textAlign: TextAlign.start),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     }

//     return list;
//   }
// }
