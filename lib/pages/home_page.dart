import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:zad_almumin/components/my_drawer.dart';
import 'package:zad_almumin/components/my_app_bar.dart';
import 'package:zad_almumin/constents/colors.dart';
import 'package:zad_almumin/constents/constents.dart';
import 'package:zad_almumin/constents/sizes.dart';
import 'package:zad_almumin/screens/azkar_blocks_screen.dart';
import 'package:zad_almumin/screens/main_screen.dart';
import '../constents/icons.dart';
import '../services/json_service.dart';
import 'quran/quran_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = 'HomePage';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Constants.setNewOpendPageId(HomePage.id);
  }

  int currentIndex = 0;
  List<Widget> icons = [
    MyIcons.home(color: MyColors.white),
    MyIcons.quran(color: MyColors.white),
    MyIcons.azkar(color: MyColors.white),
    // Icon(Icons.home, color: Colors.grey),
    // Icon(Icons.abc),
    // Icon(Icons.safety_check)
  ];
  List<Widget> screens = [
    MainScreen(),
    QuranPage(),
    AzkarBlockScreen(),
  ];

  updateCurrentIndex(int newIndex) {
    currentIndex = newIndex;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: currentIndex != 1 ? Constants.systemUiOverlayStyleDefault : Constants.systemUiOverlayStyleQuran,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: currentIndex != 1 ? MyAppBar(title: 'الرئيسية') : null,
          drawer: currentIndex != 1 ? MyDrawer() : null,
          floatingActionButton: FloatingActionButton(
              onPressed: () async {
                AudioPlayer player = AudioPlayer();
                await player.setSkipSilenceEnabled(false);
                await player.setPitch(1.01);
                // player.setLoopMode(LoopMode.one);
                // await player.setFilePath('assets/Adhan Halab.mp3'); // not playing yet because not ready
                await player.setAudioSource(
                  AudioSource.uri(
                    Uri.file('assets/Adhan Halab.mp3'),
                    tag: MediaItem(
                      // Specify a unique ID for each media item:
                      id: '12312',
                      // Metadata to display in the notification:
                      album: "Album name",
                      title: "Song name",
                      artUri: Uri.file('assets/Adhan Halab.mp3'),
                    ),
                  ),
                  preload: false,
                );
                // await player.setAudioSource(
                //   AudioSource.uri(
                //     Uri.parse('https://www.everyayah.com/data/AbdulSamad_64kbps_QuranExplorer.Com/006005.mp3'),
                //     tag: MediaItem(
                //       // Specify a unique ID for each media item:
                //       id: '12312',
                //       // Metadata to display in the notification:
                //       album: "Album name",
                //       title: "Song name",
                //       artUri:
                //           Uri.parse('https://www.everyayah.com/data/AbdulSamad_64kbps_QuranExplorer.Com/006005.mp3'),
                //     ),
                //   ),
                //   preload: false,
                // );
                await player
                    .load(); // audio will start playing after the load completes because the processing state has become "ready"
                // player.play();
                // player.dispose();
              },
              child: MyIcons.ayahsTest),
          bottomNavigationBar: currentIndex != 1
              ? CurvedNavigationBar(
                  height: MySiezes.navigationTap,
                  items: icons,
                  color: MyColors.primary(),
                  backgroundColor: MyColors.background(),
                  animationCurve: Curves.easeInOut,
                  animationDuration: Duration(milliseconds: 300),
                  index: currentIndex,
                  onTap: (newIndex) {
                    updateCurrentIndex(newIndex);
                  },
                )
              : null,
          // bottomNavigationBar: ConvexAppBar.badge(
          //   const <int, dynamic>{3: '99+'},
          //   style: TabStyle.react,
          //   activeColor: MyColors.white,
          //   backgroundColor: MyColors.primary(),
          //   color: MyColors.background(),
          //   badgeColor: Colors.red,
          //   items: <TabItem>[
          //     for (final entry in icons) TabItem(icon: entry, title: ''),
          //   ],
          //   onTap: (newIndex) => updateCurrentIndex(newIndex),
          // ),
          body: currentIndex != 1
              ? RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(Duration(seconds: 1));
                    Get.offAll(() => HomePage(), transition: Transition.fadeIn, duration: Duration(milliseconds: 300));
                    // setState(() {});
                  },
                  child: screens[currentIndex])
              : screens[currentIndex],
        ),
      ),
    );
  }
}
