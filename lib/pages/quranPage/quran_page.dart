import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/components/my_drawer.dart';
import 'package:zad_almumin/constents/colors.dart';
import 'package:zad_almumin/constents/icons.dart';
import 'package:zad_almumin/constents/texts.dart';

import '../../services/theme_service.dart';
import '../home_page.dart';
import 'classes/page_prop.dart';
import 'controllers/quran_page_ctr.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({Key? key}) : super(key: key);
  static const String id = 'QuranPage';
  @override
  State<QuranPage> createState() => _QuranPageState();
}

final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key to can open drawer


class _QuranPageState extends State<QuranPage> with SingleTickerProviderStateMixin {
  var goToPageCtr = TextEditingController();
  late TabController tabCtr;
  QuranPageCtr quranCtr = Get.find<QuranPageCtr>();

  @override
  void initState() {
    super.initState();
    tabCtr = TabController(length: 604, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _key,
        endDrawer: myEndDrawer(),
        drawer: MyDrawer(),
        body: Stack(
          children: [
            DefaultTabController(
              initialIndex: 5,
              length: 604,
              child: TabBarView(
                controller: tabCtr,
                children: [for (var i = 1; i <= 604; i++) quranPage(index: i)],
              ),
            ),
            Obx(() => quranCtr.onShown.value
                ? Align(
                    alignment: Alignment.topCenter,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      height: 70,
                      decoration: BoxDecoration(
                        color: MyColors.quranBackGround(),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10, spreadRadius: 5)],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () => Get.offAll(() => HomePage()),
                                icon: MyIcons.home(),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                MyTexts.normal(context, title: 'الصفحة:   '),
                                SizedBox(
                                  width: 40,
                                  child: TextField(
                                    controller: goToPageCtr,
                                    keyboardType: TextInputType.number,
                                    maxLength: 3,
                                    cursorHeight: 20,
                                    showCursor: false,
                                    onSubmitted: (val) {
                                      // goToPageCtr.clear();
                                      quranCtr.onShown.value = false;
                                      // setState(() {});
                                    },
                                    // onTap: () => goToPageCtr.clear(),
                                    onChanged: (val) {
                                      if (goToPageCtr.text == '') return;
                                      if (int.parse(goToPageCtr.text) > 604 || int.parse(goToPageCtr.text) < 1) {
                                        Fluttertoast.showToast(msg: 'صفحة غير موجودة');
                                        return;
                                      }
                                      tabCtr.index = int.parse(goToPageCtr.text) - 1;
                                    },
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.fromLTRB(2, 2, 5, 2),
                                      border: OutlineInputBorder(),
                                      counterText: "",
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => showMarkDialog(),
                                  icon: MyIcons.mark,
                                ),
                                IconButton(
                                  onPressed: () {
                                    bool isDark = ThemeService().getThemeMode() == ThemeMode.dark;
                                    ThemeService().changeThemeMode(!isDark);
                                  },
                                  icon: MyIcons.animated_Light_Dark(),
                                ),
                                IconButton(
                                  onPressed: () => _key.currentState!.openEndDrawer(),
                                  icon: MyIcons.book,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container()),
          ],
        ));
  }

  Widget myEndDrawer() {
    quranCtr.markedList.sort((a, b) => a.pageNumber.compareTo(b.pageNumber));
    return Drawer(
      backgroundColor: MyColors.quranBackGround(),
      width: 220,
      child: Column(
        children: [
          Container(
            height: 80,
            alignment: Alignment.center,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: MyColors.quranBackGround(),
                border: Border(bottom: BorderSide(color: MyColors.quranSecond())),
                boxShadow: [
                  BoxShadow(
                      color: MyColors.quranSecond().withOpacity(0.5),
                      offset: Offset(-5, 0),
                      blurRadius: 10,
                      spreadRadius: 5)
                ]),
            child: Text(
              'الملاحظات',
              style: TextStyle(color: MyColors.quranSecond(), fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: quranCtr.markedList.length,
              itemBuilder: (context, index) {
                return markedListTile(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget markedListTile(int index) {
    return ListTile(
      title: MyTexts.settingsTitle(context, title: 'الجزء ${quranCtr.markedList[index].juz}'),
      subtitle: MyTexts.settingsContent(context,
          title: '${quranCtr.markedList[index].surahName}  |  الصفحة ${quranCtr.markedList[index].pageNumber}'),
      shape: Border(bottom: BorderSide(color: MyColors.quranSecond())),
      onTap: () {
        tabCtr.index = quranCtr.markedList[index].pageNumber - 1;
        quranCtr.onShown.value = false;
        Get.back();
        goToPageCtr.text = '${quranCtr.markedList[index].pageNumber}';
        setState(() {});
      },
    );
  }

  Widget quranPage({required int index}) {
    bool isMarked = false;
    var pageProp =
        PageProp(pageNumber: index, juz: getJuzNumberByPage(index: index), surahName: getSurahnameByPage(index: index));
    for (var element in quranCtr.markedList) {
      if (element.juz == pageProp.juz &&
          element.pageNumber == pageProp.pageNumber &&
          element.surahName == pageProp.surahName) {
        isMarked = true;
        break;
      }
    }
    return isBannerWidget(
      isMarked: isMarked,
      child: InkWell(
        onTap: () {
          quranCtr.onShown.value = !quranCtr.onShown.value;
        },
        onLongPress: () => showMarkDialog(),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          color: MyColors.quranBackGround(),
          child: Stack(
            children: [
              Image.asset('assets/images/quran pages/00$index.png', fit: BoxFit.cover, color: MyColors.quranText()),
              Image.asset('assets/images/quran pages/000$index.png', fit: BoxFit.cover),
            ],
          ),
        ),
      ),
    );
  }

  Widget isBannerWidget({required bool isMarked, required Widget child}) {
    Widget parent = Container(child: child);
    if (isMarked) parent = Banner(message: '', location: BannerLocation.bottomStart, child: child);
    return parent;
  }

  showMarkDialog() {
    bool willAdd = true;

    var pageProp = PageProp(pageNumber: tabCtr.index + 1, juz: getJuzNumberByPage(), surahName: getSurahnameByPage());

    for (var element in quranCtr.markedList) {
      if (element.juz == pageProp.juz &&
          element.pageNumber == pageProp.pageNumber &&
          element.surahName == pageProp.surahName) {
        willAdd = false;
        break;
      }
    }
    String title = willAdd ? 'اضافة علامة قراءة' : 'ازالة علامة قراءة';
    String content = willAdd ? 'هل تود وضع علامة على هذه الصفحة؟' : 'هل تود ازالة علامة القراءة على هذه الصفحة؟';

    return Get.dialog(
      Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text(title, style: TextStyle(color: MyColors.quranText())),
          content: Text(content, style: TextStyle(color: MyColors.quranText())),
          actionsAlignment: MainAxisAlignment.spaceAround,
          backgroundColor: MyColors.quranBackGround(),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('الغاء'),
            ),
            TextButton(
              onPressed: () {
                if (willAdd) {
                  quranCtr.markedList.add(pageProp);
                  Fluttertoast.showToast(msg: 'تم اضافة العلامة');
                  quranCtr.updateDb(pageProp);
                } else {
                  quranCtr.markedList.removeWhere((element) =>
                      element.juz == pageProp.juz &&
                      element.pageNumber == pageProp.pageNumber &&
                      element.surahName == pageProp.surahName);
                  Fluttertoast.showToast(msg: 'تم ازالة العلامة');
                }
                Get.back();
                setState(() {});
              },
              child: Text('تأكيد'),
            ),
          ],
        ),
      ),
      transitionDuration: Duration(milliseconds: 500),
    );
  }

  int getJuzNumberByPage({int? index}) {
    int juz = 1;
    index ??= tabCtr.index;
    if (index <= 21)
      juz = 1;
    else if (index <= 41)
      juz = 2;
    else if (index <= 61)
      juz = 3;
    else if (index <= 81)
      juz = 4;
    else if (index <= 101)
      juz = 5;
    else if (index <= 121)
      juz = 6;
    else if (index <= 141)
      juz = 7;
    else if (index <= 161)
      juz = 8;
    else if (index <= 181)
      juz = 9;
    else if (index <= 201)
      juz = 10;
    else if (index <= 221)
      juz = 11;
    else if (index <= 241)
      juz = 12;
    else if (index <= 261)
      juz = 13;
    else if (index <= 281)
      juz = 14;
    else if (index <= 301)
      juz = 15;
    else if (index <= 321)
      juz = 16;
    else if (index <= 341)
      juz = 17;
    else if (index <= 361)
      juz = 18;
    else if (index <= 381)
      juz = 19;
    else if (index <= 401)
      juz = 20;
    else if (index <= 421)
      juz = 21;
    else if (index <= 441)
      juz = 22;
    else if (index <= 461)
      juz = 23;
    else if (index <= 481)
      juz = 24;
    else if (index <= 501)
      juz = 25;
    else if (index <= 521)
      juz = 26;
    else if (index <= 541)
      juz = 27;
    else if (index <= 561)
      juz = 28;
    else if (index <= 581)
      juz = 29;
    else
      juz = 30;
    return juz;
  }

  String getSurahnameByPage({int? index}) {
    String surahName = '';
    index ??= tabCtr.index + 1;
    if (index == 1)
      surahName = 'الفاتحة';
    else if (index < 50)
      surahName = 'البقرة';
    else if (index < 77)
      surahName = 'آل عمران';
    else if (index < 106)
      surahName = 'النساء';
    else if (index < 128)
      surahName = 'المائدة';
    else if (index < 151)
      surahName = 'الأنعام';
    else if (index < 177)
      surahName = 'الأعراف';
    else if (index < 187)
      surahName = 'الأنفال';
    else if (index < 208)
      surahName = 'التوبة';
    else if (index < 221)
      surahName = 'يونس';
    else if (index < 235)
      surahName = 'هود';
    else if (index < 249)
      surahName = 'يوسف';
    else if (index < 255)
      surahName = 'الرعد';
    else if (index < 262)
      surahName = 'إبراهيم';
    else if (index < 267)
      surahName = 'الحجر';
    else if (index < 282)
      surahName = 'النحل';
    else if (index < 293)
      surahName = 'الإسراء';
    else if (index < 305)
      surahName = 'الكهف';
    else if (index < 312)
      surahName = 'مريم';
    else if (index < 322)
      surahName = 'طه';
    else if (index < 332)
      surahName = 'الأنبياء';
    else if (index < 342)
      surahName = 'الحج';
    else if (index < 350)
      surahName = 'المؤمنون';
    else if (index < 359)
      surahName = 'النور';
    else if (index < 367)
      surahName = 'الفرقان';
    else if (index < 377)
      surahName = 'الشعراء';
    else if (index < 385)
      surahName = 'النمل';
    else if (index < 396)
      surahName = 'القصص';
    else if (index < 404)
      surahName = 'العنكبوت';
    else if (index < 411)
      surahName = 'الروم';
    else if (index < 415)
      surahName = 'لقمان';
    else if (index < 418)
      surahName = 'السجدة';
    else if (index <= 428)
      surahName = 'الأحزاب';
    else if (index < 434)
      surahName = 'سبإ';
    else if (index < 440)
      surahName = 'فاطر';
    else if (index < 446)
      surahName = 'يس';
    else if (index < 453)
      surahName = 'الصافات';
    else if (index < 458)
      surahName = 'ص';
    else if (index < 467)
      surahName = 'الزمر';
    else if (index < 477)
      surahName = 'غافر';
    else if (index < 483)
      surahName = 'فصلت';
    else if (index < 489)
      surahName = 'الشورى';
    else if (index < 496)
      surahName = 'الزخرف';
    else if (index < 499)
      surahName = 'الدخان';
    else if (index < 502)
      surahName = 'الجاثية';
    else if (index < 507)
      surahName = 'الأحقاف';
    else if (index < 511)
      surahName = 'محمد';
    else if (index < 515)
      surahName = 'الفتح';
    else if (index < 518)
      surahName = 'الحجرات';
    else if (index < 520)
      surahName = 'ق';
    else if (index < 523)
      surahName = 'الذاريات';
    else if (index < 526)
      surahName = 'الطور';
    else if (index < 528)
      surahName = 'النجم';
    else if (index < 531)
      surahName = 'القمر';
    else if (index < 534)
      surahName = 'الرحمن';
    else if (index < 537)
      surahName = 'الواقعة';
    else if (index < 542)
      surahName = 'الحديد';
    else if (index < 545)
      surahName = 'المجادلة';
    else if (index < 549)
      surahName = 'الحشر';
    else if (index < 551)
      surahName = 'الممتحنة';
    else if (index < 553)
      surahName = 'الصف';
    else if (index < 554)
      surahName = 'الجمعة';
    else if (index < 556)
      surahName = 'المنافقون';
    else if (index < 558)
      surahName = 'التغابن';
    else if (index < 560)
      surahName = 'الطلاق';
    else if (index < 562)
      surahName = 'التحريم';
    else if (index < 564)
      surahName = 'الملك';
    else if (index < 566)
      surahName = 'القلم';
    else if (index < 568)
      surahName = 'الحاقة';
    else if (index < 570)
      surahName = 'المعارج';
    else if (index < 572)
      surahName = 'نوح';
    else if (index < 574)
      surahName = 'الجن';
    else if (index < 575)
      surahName = 'المزمل';
    else if (index < 577)
      surahName = 'المدثر';
    else if (index < 578)
      surahName = 'القيامة';
    else if (index < 580)
      surahName = 'الإنسان';
    else if (index < 582)
      surahName = 'المرسلات';
    else if (index < 583)
      surahName = 'النبأ';
    else if (index < 585)
      surahName = 'النازعات';
    else if (index < 586)
      surahName = 'عبس';
    else if (index < 587)
      surahName = 'التكوير';
    else if (index < 587)
      surahName = 'الإنفطار';
    else if (index < 589)
      surahName = 'المطففين';
    else if (index < 590)
      surahName = 'الإنشقاق';
    else if (index < 591)
      surahName = 'البروج';
    else if (index < 591)
      surahName = 'الطارق';
    else if (index < 592)
      surahName = 'الأعلى';
    else if (index < 593)
      surahName = 'الغاشية';
    else if (index < 594)
      surahName = 'الفجر';
    else if (index < 595)
      surahName = 'البلد';
    else if (index < 595)
      surahName = 'الشمس';
    else if (index < 596)
      surahName = 'الليل';
    else if (index < 596)
      surahName = 'الضحى';
    else if (index < 597)
      surahName = 'الشرح';
    else if (index < 597)
      surahName = 'التين';
    else if (index < 598)
      surahName = 'العلق';
    else if (index < 598)
      surahName = 'القدر';
    else if (index < 599)
      surahName = 'البينة';
    else if (index <= 599)
      surahName = 'الزلزلة';
    else if (index < 600)
      surahName = 'العاديات';
    else if (index < 600)
      surahName = 'القارعة';
    else if (index < 601)
      surahName = 'التكاثر';
    else if (index < 601)
      surahName = 'العصر';
    else if (index < 601)
      surahName = 'الهمزة';
    else if (index < 602)
      surahName = 'الفيل';
    else if (index < 602)
      surahName = 'قريش';
    else if (index < 602)
      surahName = 'الماعون';
    else if (index < 603)
      surahName = 'الكوثر';
    else if (index < 603)
      surahName = 'الكافرون';
    else if (index < 603)
      surahName = 'النصر';
    else if (index < 604)
      surahName = 'المسد';
    else if (index < 604)
      surahName = 'الإخلاص';
    else if (index < 604)
      surahName = 'الناس';
    else
      surahName = 'الفلق';
    return surahName;
  }
}
