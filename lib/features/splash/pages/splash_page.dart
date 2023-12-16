import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/helpers/navigator_helper.dart';
import '../../../core/utils/app_router.dart';
import '../widget/splah_image_widget.dart';
import '../widget/splah_text_widget.dart';


class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  double opacity = 0;
  bool value = true;

  @override
  void initState() {
    super.initState();
    _setAnimationController();
    scaleAnimation = Tween<double>(begin: 0.0, end: 12).animate(scaleController);
    _updateVlauesTime();
    _updateAnimationTimer();
  }

  void _setAnimationController() {
    scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            NavigatorHelper.pushReplacementNamed(Routes.onboarding);
          }
        },
      );
  }

  void _updateVlauesTime() {
    Timer(Duration(seconds: 1), () {
      setState(() {
        opacity = 1.0;
        value = false;
      });
    });
  }

  void _updateAnimationTimer() {
    Timer(Duration(milliseconds: 3000), () {
      setState(() {
        scaleController.forward();
      });
    });
  }

  @override
  void dispose() {
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SplahTextWidget(),
            SplahImageWidget(
              opacity: opacity,
              value: value,
              scaleAnimation: scaleAnimation,
            ),
          ],
        ),
      ),
    );
  }
}
