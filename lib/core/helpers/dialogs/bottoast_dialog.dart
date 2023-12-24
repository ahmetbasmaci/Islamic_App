// import 'package:bot_toast/bot_toast.dart';
// import 'package:flutter/material.dart';

// class BotToastDialog {
//   static final QuranPageCtr _quranCtr = Get.find<QuranPageCtr>();
//   static final HttpCtr _httpCtr = Get.find<HttpCtr>();
//   static void showToastDialog({required LongPressStartDetails details, required Ayah ayah}) {
//     BotToast.showAttachedWidget(
//       target: details.globalPosition,
//       animationDuration: const Duration(microseconds: 700),
//       animationReverseDuration: const Duration(microseconds: 700),
//       attachedBuilder: (cancel) => Card(
//         color: MyColors.quranBackGround,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _addAyahMarkBtn(cancel, ayah),
//               SizedBox(width: MySiezes.icon / 2),
//               _copyAyahBtn(cancel, ayah),
//               SizedBox(width: MySiezes.icon / 2),
//               _playAyahBtn(cancel, ayah),
//               SizedBox(width: MySiezes.icon / 2),
//               _shareBtn(cancel, ayah),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   static Container _addAyahMarkBtn(CancelFunc cancel, Ayah ayah) {
//     return Container(
//       height: MySiezes.icon * 2,
//       width: MySiezes.icon * 2,
//       decoration: BoxDecoration(color: MyColors.blackWhite, borderRadius: const BorderRadius.all(Radius.circular(50))),
//       child: IconButton(
//         icon: Icon(ayah.isMarked ? Icons.bookmark : Icons.bookmark_border,
//             size: MySiezes.icon, color: MyColors.quranPrimary),
//         onPressed: () {
//           _quranCtr.addRemoveAyahMark(ayah);
//           cancel();
//         },
//       ),
//     );
//   }

//   static Container _copyAyahBtn(CancelFunc cancel, Ayah ayah) {
//     return Container(
//       height: MySiezes.icon * 2,
//       width: MySiezes.icon * 2,
//       decoration: BoxDecoration(
//         color: MyColors.blackWhite,
//         borderRadius: const BorderRadius.all(Radius.circular(50)),
//       ),
//       child: IconButton(
//         icon: Icon(
//           Icons.copy_outlined,
//           size: MySiezes.icon,
//           // color: MyColors.quranPrimary,
//         ),
//         onPressed: () {
//           HelperMethods.copyText(ayah.text);
//           cancel();
//         },
//       ),
//     );
//   }

//   static Container _playAyahBtn(CancelFunc cancel, Ayah ayah) {
//     return Container(
//       height: MySiezes.icon * 2,
//       decoration: BoxDecoration(color: MyColors.blackWhite, borderRadius: const BorderRadius.all(Radius.circular(50))),
//       child: IconButton(
//         icon: Icon(
//           Icons.play_circle_outline_outlined,
//           size: MySiezes.icon,
//           // color: MyColors.quranPrimary,
//         ),
//         onPressed: () async {
//           cancel();
//           List<Ayah> ayahsList = await HttpService.getSurah(surahNumber: ayah.surahNumber);
//           _quranCtr.selectedPage.startAyahNum.value = ayah.ayahNumber;
//           _quranCtr.selectedPage.endAyahNum.value = ayahsList.last.ayahNumber;
//           _quranCtr.selectedPage.surahName.value = ayah.surahName;
//           _quranCtr.selectedPage.surahNumber.value = ayah.surahNumber;
//           _quranCtr.selectedPage.totalAyahsNum.value = ayahsList.length;
//           _quranCtr.changeOnShownState(false);

//           if (_httpCtr.downloadComplated.value) {
//             AudioService.playMultiAudio(ayahList: ayahsList);
//           }
//         },
//       ),
//     );
//   }

//   static Container _shareBtn(CancelFunc cancel, Ayah ayah) {
//     return Container(
//       height: MySiezes.icon * 2,
//       width: MySiezes.icon * 2,
//       decoration: BoxDecoration(color: MyColors.blackWhite, borderRadius: const BorderRadius.all(Radius.circular(50))),
//       child: IconButton(
//         icon: Icon(
//           Icons.share_outlined,
//           size: MySiezes.icon,
//           // color: MyColors.quranPrimary,
//         ),
//         onPressed: () {
//           Share.share(ayah.text, subject: ayah.surahName);
//           cancel();
//         },
//       ),
//     );
//   }
// }
