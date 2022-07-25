import 'package:flutter/material.dart';
import 'package:zad_almumin/components/my_app_bar.dart';
import 'package:zad_almumin/components/my_drawer.dart';
import 'package:zad_almumin/constents/texts.dart';

class PrayerTimes extends StatefulWidget {
  const PrayerTimes({Key? key}) : super(key: key);

  @override
  State<PrayerTimes> createState() => _PrayerTimesState();
}

class _PrayerTimesState extends State<PrayerTimes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(title: ''),
        drawer: MyDrawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: MaterialButton(
                onPressed: () {},
                child: MyTexts.content(context, title: 'upgrade'),
              ),
            ),
            ListTile(
              shape: Border.all(color: Colors.black),
              title: MyTexts.settingsTitle(context, title: 'fajr'),
              trailing: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 5,
                    spreadRadius: 1,
                  )
                ]),
                child: MyTexts.normal(context, title: '05:00'),
              ),
            ),
          ],
        ));
  }

  ListTile prayerTime({required String label}) {
    return ListTile(
      title: Text(label),
    );
  }
}
