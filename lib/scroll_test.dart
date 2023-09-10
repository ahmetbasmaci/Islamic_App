// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:scroll_to_index/scroll_to_index.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// import 'package:zad_almumin/pages/quran/controllers/quran/quran_page_ctr.dart';

// class ScrollTest extends StatefulWidget {
//   const ScrollTest({super.key});

//   @override
//   State<ScrollTest> createState() => _ScrollTestState();
// }

// class _ScrollTestState extends State<ScrollTest> {
//   final QuranPageCtr _quranCtr = Get.find<QuranPageCtr>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               height: 200,
//               color: Colors.blue,
//             ),
//             SizedBox(
//               height: Get.height - 200, // Adjust the height as needed
//               child: ScrollablePositionedList.builder(
//                 key: UniqueKey(),
//                 itemCount: 150,
//                 shrinkWrap: true,
//                 itemScrollController: _quranCtr.itemScrollController,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     key: UniqueKey(),
//                     title: Text('title $index'),
//                     subtitle: Text('subtitle $index'),
//                   );
//                 },
//               ),
//             ),
//             Container(
//               height: 200,
//               color: Colors.blue,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _quranCtr.itemScrollController.scrollTo(
//             index: 10, // Change this to the desired index
//             duration: Duration(seconds: 1),
//             curve: Curves.easeInOutCubic,
//           );
//         },
//         child: Icon(Icons.arrow_downward),
//       ),
//     );
//   }
// }
