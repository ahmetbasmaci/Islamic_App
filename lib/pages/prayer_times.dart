import 'package:flutter/material.dart';
import 'package:zad_almumin/components/main_container.dart';
import 'package:zad_almumin/components/my_app_bar.dart';
import 'package:zad_almumin/components/my_drawer.dart';
import 'package:zad_almumin/constents/colors.dart';
import 'package:zad_almumin/constents/texts.dart';

class PrayerTimes extends StatefulWidget {
  const PrayerTimes({Key? key}) : super(key: key);
  static String id = 'PrayerTimes';
  @override
  State<PrayerTimes> createState() => _PrayerTimesState();
}

class _PrayerTimesState extends State<PrayerTimes> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: MyAppBar(title: ''),
          drawer: MyDrawer(),
          body: mainContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: MyColors.background(),
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(color: MyColors.shadow(), blurRadius: 10, offset: Offset(0, 3)),
                          BoxShadow(color: MyColors.shadowPrimary(), blurRadius: 6, offset: Offset(0, 3)),
                        ],
                      ),
                      width: 200,
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          MyTexts.normal(context,
                              title: 'المغرب', size: 26, color: MyColors.insideHeader, fontWeight: FontWeight.bold),
                          MyTexts.normal(context, title: '12:23', size: 30, fontWeight: FontWeight.bold)
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      // child: MyTexts.content(context, title: 'upgrade'),
                      child: Text('تحديث'),
                    ),
                  ],
                ),
                prayerTime(),
                prayerTime(),
                prayerTime(),
                prayerTime(),
                prayerTime(),
              ],
            ),
          )),
    );
  }

  Widget prayerTime() {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.background(),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: MyColors.shadow(), blurRadius: 10, offset: Offset(0, 3)),
          BoxShadow(color: MyColors.shadowPrimary(), blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: ListTile(
        // shape: Border.all(color: Colors.black),
        title: MyTexts.settingsTitle(context, title: 'الفجر'),
        trailing: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: MyColors.background(),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(.3), blurRadius: 5)]),
          child: MyTexts.normal(context, title: '05:00'),
        ),
      ),
    );
  }
}
